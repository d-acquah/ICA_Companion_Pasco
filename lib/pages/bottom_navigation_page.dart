import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ica_companion_pasco/home_page.dart';
import 'package:ica_companion_pasco/models/AppOpenAdManager.dart';
//import 'package:ica_companion_pasco/pages/premium_page.dart';
import 'package:ica_companion_pasco/pages/topics_page.dart';
import 'package:ica_companion_pasco/pages/trend_page.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> with WidgetsBindingObserver {
  AppOpenAdManager appOpenAdManager = AppOpenAdManager();
  bool isPaused = false;
  int currentIndex = 0;
  InterstitialAd? interstitialAd;
  final screens = [
    HomePage(),
    TrendPage(),
    TopicsPage(),
    //PremiumPage(),
  ];
  @override
  void initState() {
    //implement initState
    super.initState();
    appOpenAdManager.loadAd();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    //implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      isPaused = true;
    }
    if (state == AppLifecycleState.resumed && isPaused) {
      print("Resumed==========================");
      appOpenAdManager.showAdIfAvailable();
      isPaused = false;
    }
  }

 @override
  Widget build(BuildContext context) {
    return WillPopScope(
       onWillPop: () async {
        // Close the app without showing an ad
        SystemNavigator.pop();

        // Return true to indicate that the back button press is handled
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
          if (index != 0 && index != 1) {
            await InterstitialAd.load(
              adUnitId: Platform.isAndroid
                  ? "ca-app-pub-2530239307985191/40013864611"
                  : "ca-app-pub-2530239307985191/56291901061",
              request: const AdRequest(),
              adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
                interstitialAd = ad;
                ad.show();
                interstitialAd?.fullScreenContentCallback =
                    FullScreenContentCallback(
                  onAdDismissedFullScreenContent: (ad) {
                    interstitialAd?.dispose();
                    ad.dispose();
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  onAdFailedToShowFullScreenContent: (ad, err) {
                    ad.dispose();
                    interstitialAd?.dispose();
                  },
                );
              }, onAdFailedToLoad: (err) {
                debugPrint(err.message);
                // Handle ad load failure
              }),
            );
          } else if (index != 0 && index != 2) {
            showPersistentDialog(context,
                'Trend analysis provides insight into the pattern of questions asked over a relevant period of time based on an analysis of the topics examined during those periods. Certain subjects do not necessarily follow any predictable pattern and as such the trend analysis provides the frequently examined topics in such cases. This is meant to be a guide for preparation towards the ICA examination and does not necessarily represent the topics that will be examined.');
          }
          setState(() {
            currentIndex = index;
          });
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
        ],
      ),
    ));
  }

 void showPersistentDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.blue, // Set background color
        title: Text(
          'Disclaimer', textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600, // Set font weight
          ),// Set title text color
        ),
        content: SingleChildScrollView(
          child: Text(
            message,
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400,), // Set content text color
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK', style: TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.w600, // Set font weight
          ),
           ),
          ),
        ],
      );
    },
  );
}
}
