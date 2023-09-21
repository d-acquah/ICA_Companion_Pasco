
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ica_companion_pasco/home_page.dart';
//import 'package:ica_companion_pasco/pages/premium_page.dart';
import 'package:ica_companion_pasco/pages/topics_page.dart';
import 'package:ica_companion_pasco/pages/trend_page.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int currentIndex = 0;
  InterstitialAd? interstitialAd;
  final screens = [
    HomePage(),
    TrendPage(),
    TopicsPage(),
   //PremiumPage(),
    

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
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
                ? "ca-app-pub-2530239307985191/4001386461"
                : "ca-app-pub-3940256099942544/4411468910",
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
              }, onAdFailedToShowFullScreenContent: (ad, err) {
                ad.dispose();
                interstitialAd?.dispose();
              });
            }, onAdFailedToLoad: (err) {
              debugPrint(err.message);

              // ignore: dead_code
              // Navigator.push(context,MaterialPageRoute(builder: (context){
              //                return NextPage();
            }));
          }
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            // backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Trend',
            // backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.topic),
            label: 'Topics',
            // backgroundColor: Colors.blue,
          ),
          //BottomNavigationBarItem(
           // icon: Icon(Icons.attach_money),
          //  label: 'Premium',
            // backgroundColor: Colors.blue,
         // ),
        ],
      ),
    );
  }
}
