import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
  // When navigating here from payment verification, pass a true value along with 
  // a non-null message to trigger the SnackBar.
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
  List<PdfDocument> pdfDocuments = [];
  AppOpenAdManager appOpenAdManager = AppOpenAdManager();
  bool premiumPageVisible = false;
  bool isPaused = false;
  IApEngine iApEngine = IApEngine();
  bool _isLoaded = true;
  int currentIndex = 0;
  InterstitialAd? interstitialAd;

  // State variable for Paystack subscription status.
  bool isPremiumUser = false;

  // Define the list of screens. Note that Subscriptions is here without any parameters,
  // so when users start the app, no SnackBar is shown on that page.
  final List<Widget> screens = [
    HomePage(),
    TrendPage(),
    TopicsPage(),
    const Subscriptions(), // No parameters passed here for normal startup.
    PdfListScreen(),
    PremiumPage(),
  ];

  @override
  void initState() {
    super.initState();
    premiumPageVisible = false;
    appOpenAdManager.loadAd();
    WidgetsBinding.instance.addObserver(this);
    restoreSub();
    _loadPdfDocuments();

    iApEngine.inAppPurchase.purchaseStream.listen((list) {
      if (list.isNotEmpty) {
        OnePref.setPremium(true);
      } else {
        OnePref.setPremium(false);
      }
    });

    // Check Firebase for Paystack subscription status.
    checkUserSubscription().then((subscriptionActive) {
      setState(() {
        isPremiumUser = subscriptionActive;
      });
    });

    // If coming from a payment verification, show the SnackBar once.
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
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      isPaused = true;
    }
    if (state == AppLifecycleState.resumed && isPaused) {
      print("Resumed==========================");
      if (_isLoaded && !((OnePref.getPremium() ?? false) || isPremiumUser)) {
        appOpenAdManager.showAdIfAvailable();
        isPaused = false;
      }
    }
  }

  // Firebase subscription check using Firestore. Returns true if the user is signed in,
  // the "subscribed" field is true, and the current time is before "subscriptionEnd".
  Future<bool> checkUserSubscription() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;

    final docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      if (data?['subscribed'] == true && data?['subscriptionEnd'] != null) {
        final expirationDate = (data!['subscriptionEnd'] as Timestamp).toDate();
        return DateTime.now().isBefore(expirationDate);
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Close the app without showing an ad.
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
            // Combine OnePref (Google Play subscriptions) with isPremiumUser (Paystack subscriptions)
            bool hasPremium = (OnePref.getPremium() ?? false) || isPremiumUser;

            switch (index) {
              case 0:
              case 3:
                setState(() {
                  currentIndex = index;
                });
                break;
              case 1:
                restoreSub(); // Restore subscriptions.
                await Future.delayed(const Duration(milliseconds: 500));
                if (_isLoaded && hasPremium) {
                  setState(() {
                    currentIndex = index;
                  });
                  showPersistentDialog(
                      context,
                      'Trend analysis gives insight into the pattern of questions. '
                      'This is crafted to be a guide for your ICA exam preparation.');
                } else {
                  showTrendLockedDialog(context);
                }
                break;
              case 2:
                restoreSub();
                await Future.delayed(const Duration(milliseconds: 500));
                if (_isLoaded && hasPremium) {
                  setState(() {
                    currentIndex = index;
                  });
                } else {
                  showTopicsLockedDialog(context);
                }
                break;
              case 4:
                restoreSub();
                await Future.delayed(const Duration(seconds: 1));
                if (_isLoaded && hasPremium) {
                  setState(() {
                    currentIndex = index;
                  });
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Scaffold(
                        appBar: AppBar(
                          centerTitle: true,
                          automaticallyImplyLeading: false,
                          title: const Text(
                            'Downloads',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          elevation: 0,
                          backgroundColor: Colors.blue,
                        ),
                        body: Stack(
                          children: [
                            // List of PDF Documents.
                            Positioned.fill(
                              child: ListView.separated(
                                itemCount: pdfDocuments.length,
                                separatorBuilder: (context, index) =>
                                    const Divider(indent: 0, thickness: 2),
                                itemBuilder: (context, index) {
                                  final pdfDocument = pdfDocuments[index];
                                  return ListTile(
                                    title: Text(pdfDocument.title),
                                    onTap: () {},
                                  );
                                },
                              ),
                            ),
                            // AlertDialog overlay.
                            Positioned.fill(
                              child: Container(
                                color: Colors.transparent,
                                alignment: Alignment.center,
                                child: AlertDialog(
                                  backgroundColor: Colors.blue,
                                  title: const Text(
                                    'Download Feature',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  content: const SingleChildScrollView(
                                    child: Text(
                                      'The download feature is available to premium users only. '
                                      'Subscribe to access offline past questions.',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'OK',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up),
              label: 'Trend',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.topic),
              label: 'Topics',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.workspace_premium_outlined),
              label: 'Premium',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.download),
              label: 'Download',
            ),
          ],
        ),
      ),
    );
  }

  void showPersistentDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text(
            'Disclaimer',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: SingleChildScrollView(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void restoreSub() {
    iApEngine.inAppPurchase.restorePurchases();
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
