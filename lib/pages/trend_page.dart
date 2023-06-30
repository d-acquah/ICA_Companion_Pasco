
// // @dart=2.9
 //import 'package:ica_companion_pasco/home_year_page.dart';
// import 'package:ica_companion_pasco/pasco_model.dart';
 import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class TrendPage extends StatefulWidget {
TrendPage({Key? key}) : super(key: key);

  @override
  State<TrendPage> createState() => _TrendPageState();
}

class _TrendPageState extends State<TrendPage> {
 final BannerAd myBanner = BannerAd(
      size: AdSize.banner,
      adUnitId: Platform.isAndroid
          ? "ca-app-pub-3940256099942544/6300978111"
          : "ca-app-pub-3940256099942544/2934735716",
      listener: BannerAdListener(),
      request: AdRequest());

  @override
  void initState() {
    super.initState();
    myBanner.load();
  }

InterstitialAd? interstitialAd;

  bool _canPop = false;

@override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async { {
        if (_canPop) {
          return true;
        } else {
          await Future.delayed(Duration(milliseconds: 500));
          setState(() {
            _canPop = true;
          });
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blue,
            content: Text('Press back button again to exit'),
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );  
        }
      }
        await InterstitialAd.load(
            adUnitId: Platform.isAndroid
                ? "ca-app-pub-2530239307985191/5038971352"
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
                         SystemNavigator.pop();
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
            return false; 
             
        
            
      },
      child: Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Trend Analysis',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
body: Center(
  child:   SafeArea(
  
         child: Text("This feature is under development and not accessible at the moment",style: TextStyle(
               fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
         ),
  
               ),
),
            ),
            ); 
 }
}