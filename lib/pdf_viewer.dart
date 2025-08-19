import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ica_companion_pasco/models/pasco_model.dart';
import 'package:ica_companion_pasco/pages/download_page.dart';
import 'package:onepref/onepref.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class PDFViewer extends StatefulWidget {
  final MonthYear monthYear;

  const PDFViewer({Key? key, required this.monthYear}) : super(key: key);

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  IApEngine iApEngine = IApEngine();
  bool isLoading = false;
  bool _isLoaded = true;
  late InterstitialAd? _interstitialAd;
  bool _interstitialShown = false;

  final BannerAd myBanner = BannerAd(
    size: AdSize.banner,
    adUnitId: Platform.isAndroid
        ? "ca-app-pub-2530239307985191/4923044950"
        : "ca-app-pub-2530239307985191/4273991819",
    listener: BannerAdListener(
      onAdLoaded: (Ad ad) => print('$BannerAd loaded.'),
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
        print('$BannerAd failedToLoad: $error');
      },
    ),
    request: AdRequest(),
  );

  @override
  void initState() {
    super.initState();
    myBanner.load();
    restoreSub();
    validatePremiumFromDatabase();
    _loadInterstitialAd();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.blue,
          content: Text('Make sure you have an internet connection'),
          duration: Duration(seconds: 3),
        ),
      );
    });

    iApEngine.inAppPurchase.purchaseStream.listen((list) {
      OnePref.setPremium(list.isNotEmpty);
    });
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: Platform.isAndroid
          ? "ca-app-pub-2530239307985191/4612100836"
          : "ca-app-pub-2530239307985191/5454409211",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          if (!_interstitialShown && OnePref.getPremium() == false) {
            _interstitialAd!.show();
            _interstitialShown = true;
          }
        },
        onAdFailedToLoad: (err) => debugPrint('Ad failed to load: ${err.message}'),
      ),
    );
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  Future<void> validatePremiumFromDatabase() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final DatabaseReference ref =
            FirebaseDatabase.instance.ref().child('users/${user.uid}');
        final DataSnapshot snapshot = await ref.get();

        if (snapshot.exists) {
          final data = Map<String, dynamic>.from(snapshot.value as Map);
          final isPremium = data['isPremium'] == true;
          final subscriptionEnd = data['subscriptionEnd'] ?? 0;
          final now = DateTime.now().millisecondsSinceEpoch;

          if (isPremium && now < subscriptionEnd) {
            await OnePref.setPremium(true);
            print("✅ Premium user with valid subscription");
          } else {
            await OnePref.setPremium(false);
            print("⚠️ Subscription expired or user is not premium");
          }
        }
      }
    } catch (e) {
      print('Error checking premium status from database: $e');
      OnePref.setPremium(false);
    }
    setState(() {}); // Rebuild UI
  }

  Future<void> _downloadAndSavePdf() async {
    try {
      final url = widget.monthYear.link;
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final uri = Uri.parse(url);
        final fileName = capitalizeWords(uri.pathSegments.last);

        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/$fileName';
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PdfListScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to download PDF'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  String capitalizeWords(String input) {
    final words = input.split('_');
    for (int i = 0; i < words.length; i++) {
      if (i > 0 && (words[i] == 'to' || words[i] == 'of')) {
        continue;
      } else {
        words[i] = capitalizeFirstLetter(words[i]);
      }
    }
    return words.join('_');
  }

  String capitalizeFirstLetter(String input) {
    return input[0].toUpperCase() + input.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 65,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            widget.monthYear.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              onPressed: () async {
                if (_isLoaded && OnePref.getPremium() == true) {
                  try {
                    setState(() => isLoading = true);
                    await _downloadAndSavePdf();
                  } catch (error) {
                    print("Error during download: $error");
                  } finally {
                    setState(() => isLoading = false);
                  }
                } else {
                  showPersistentDialog(
                    context,
                    "The download feature is available to premium users only. Subscribe to the premium version to get access to download and view past questions offline.",
                  );
                }
              },
              icon: const Icon(Icons.download),
              color: Colors.white,
            ),
          ],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SfPdfViewer.network(widget.monthYear.link),
        bottomNavigationBar: Visibility(
          visible: _isLoaded && OnePref.getPremium() == false,
          child: _isLoaded
              ? Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: myBanner.size.height.toDouble(),
                  child: AdWidget(ad: myBanner),
                )
              : Container(),
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
          title: Text(
            'Download Feature',
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
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
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
}
