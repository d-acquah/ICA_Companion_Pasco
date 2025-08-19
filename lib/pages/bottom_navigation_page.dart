import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ica_companion_pasco/home_page.dart';
import 'package:ica_companion_pasco/models/AppOpenAdManager.dart';
import 'package:ica_companion_pasco/models/PdfDocument.dart';
import 'package:ica_companion_pasco/pages/download_page.dart';
import 'package:ica_companion_pasco/pages/premium_page.dart';
import 'package:ica_companion_pasco/pages/subscription.dart';
import 'package:ica_companion_pasco/pages/topics_page.dart';
import 'package:ica_companion_pasco/pages/trend_page.dart';
import 'package:ica_companion_pasco/utils/topics_page_locked.dart';
import 'package:ica_companion_pasco/utils/trend_page_locked.dart';
import 'package:onepref/onepref.dart';
import 'package:path_provider/path_provider.dart';

class BottomNavigationPage extends StatefulWidget {
  final bool showPaymentSnackBar;
  final String? paymentSnackBarMessage;

  const BottomNavigationPage({
    Key? key,
    this.showPaymentSnackBar = false,
    this.paymentSnackBarMessage,
  }) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage>
    with WidgetsBindingObserver {
  final AppOpenAdManager appOpenAdManager = AppOpenAdManager();
  final List<Widget> screens = [
    HomePage(),
    TrendPage(),
    TopicsPage(),
    const Subscriptions(),
    PdfListScreen(),
    PremiumPage(),
  ];

  int currentIndex = 0;
  bool isPaused = false;
  bool _isLoaded = false;
  bool isPremiumUserFirestore = false;
  bool isPremiumUserRealtime = false;
  List<PdfDocument> pdfDocuments = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadPdfDocuments();
    restoreSub();

    appOpenAdManager.loadAd(onAdLoaded: () {
      if (mounted) {
        setState(() {
          _isLoaded = true;
        });
      }
    });

    IApEngine().inAppPurchase.purchaseStream.listen((list) {
      OnePref.setPremium(list.isNotEmpty);
    });

    _checkFirestoreSubscription();
    _checkRealtimeDatabaseSubscription();

    if (widget.showPaymentSnackBar && widget.paymentSnackBarMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              widget.paymentSnackBarMessage!,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      isPaused = true;
    }
    if (state == AppLifecycleState.resumed && isPaused) {
      if (_isLoaded && !isUserPremium()) {
        appOpenAdManager.showAdIfAvailable();
      }
      isPaused = false;
    }
  }

  bool isUserPremium() {
    return (OnePref.getPremium() ?? false) ||
        isPremiumUserFirestore ||
        isPremiumUserRealtime;
  }

  Future<void> restoreSub() async {
    await IApEngine().inAppPurchase.restorePurchases();
  }

  Future<void> _checkFirestoreSubscription() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .get();
      if (doc.exists) {
        final data = doc.data();
        if (data?['subscribed'] == true && data?['subscriptionEnd'] != null) {
          final endDate = (data!['subscriptionEnd'] as Timestamp).toDate();
          setState(() {
            isPremiumUserFirestore = DateTime.now().isBefore(endDate);
          });
        }
      }
    }
  }

  Future<void> _checkRealtimeDatabaseSubscription() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;
      final snapshot = await FirebaseDatabase.instance.ref('users/$uid').get();

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        final isPremium = data['isPremium'] as bool? ?? false;
        final subEndMs = data['subscriptionEnd'] as int?;
        final endDate = subEndMs != null
            ? DateTime.fromMillisecondsSinceEpoch(subEndMs)
            : null;

        setState(() {
          isPremiumUserRealtime = isPremium &&
              (endDate != null && DateTime.now().isBefore(endDate));
        });

        print("✅ Premium status (Realtime): $isPremium, Expires: $endDate");
      } else {
        print("🚫 No premium data found at users/$uid");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
   

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          currentIndex: currentIndex,
          onTap: (index) async {
            switch (index) {
              case 0:
              case 3:
                setState(() => currentIndex = index);
                break;
              case 1:
                await _handlePremiumNavigation(
                    index, showTrendLockedDialog,
                    showInfoDialog: true);
                break;
              case 2:
                await _handlePremiumNavigation(
                    index, showTopicsLockedDialog);
                break;
              case 4:
                await _handlePremiumNavigation(
                    index, _showDownloadLockedDialog);
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.trending_up), label: 'Trend'),
            BottomNavigationBarItem(icon: Icon(Icons.topic), label: 'Topics'),
            BottomNavigationBarItem(
                icon: Icon(Icons.workspace_premium_outlined), label: 'Premium'),
            BottomNavigationBarItem(
                icon: Icon(Icons.download), label: 'Download'),
          ],
        ),
      ),
    );
  }

  Future<void> _handlePremiumNavigation(
    int index, Function(BuildContext) lockedDialog,
    {bool showInfoDialog = false}) async {
  await Future.delayed(const Duration(milliseconds: 400));

  final premiumStatus = isUserPremium(); // recheck fresh status

  if (_isLoaded && premiumStatus) {
    setState(() => currentIndex = index);
    if (showInfoDialog) {
      _showInfoDialog(
          context,
          'Trend analysis gives insight into the pattern of questions.'
          'This is crafted to be a guide for your ICA exam preparation.');
    }
  } else {
    lockedDialog(context);
  }
}


  void _showInfoDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.blue,
        title: const Text('Disclaimer',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600)),
        content: Text(message,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _showDownloadLockedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.blue,
        title: const Text('Download Feature',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600)),
        content: const Text(
          'The download feature is available to premium users only. '
          'Subscribe to access offline past questions.',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Future<void> _loadPdfDocuments() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final files = Directory(directory.path).listSync();

      pdfDocuments.clear();
      for (var file in files) {
        if (file is File && file.path.endsWith('.pdf')) {
          pdfDocuments.add(
            PdfDocument(
              title: file.uri.pathSegments.last,
              localPath: file.path,
              id: 1,
            ),
          );
        }
      }
      setState(() {});
    } catch (e) {
      print('Error loading PDF documents: $e');
    }
  }
}
