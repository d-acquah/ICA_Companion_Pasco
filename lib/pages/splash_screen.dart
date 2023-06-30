
//import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'bottom_navigation_page.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavigationPage()),
      );
    });

//InterstitialAd.load(
           // adUnitId: Platform.isAndroid
             //   ? "ca-app-pub-3940256099942544/1033173712"
             //   : "ca-app-pub-3940256099942544/4411468910",
            //request: const AdRequest(),
           // adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
           //   ad.show();
               
          //  }, onAdFailedToLoad: (err) {
//              debugPrint(err.message);

              
              // ignore: dead_code
              // Navigator.push(context,MaterialPageRoute(builder: (context){
              //                return NextPage();
           // }));
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Container( width: 150.0,
        height: 150.0,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage('asset/app_logo.png'),
          ),
          
               
            
          
        
          ),
        ),
      ),
    );
  }
}

