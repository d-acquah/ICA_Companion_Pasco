import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ica_companion_pasco/models/AppOpenAdManager.dart';
import 'package:ica_companion_pasco/pages/bottom_navigation_page.dart';
import 'package:onepref/onepref.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AppOpenAdManager appOpenAdManager = AppOpenAdManager();
  IApEngine iApEngine = IApEngine();
  bool _isLoaded = true;

  @override
  void initState() {
    super.initState();
    restoreSub();

    iApEngine.inAppPurchase.purchaseStream.listen((list) {
      if (list.isNotEmpty) {
        int i = 0;
        for (var element in list) {
          print(list[i].verificationData.localVerificationData);
        }
        i++;
        OnePref.setPremium(true);
        //restore the subscription
      } else {
        //do nothing or deactivate the subscription if the user is premium
        OnePref.setPremium(false);
      }
    });

    //Load AppOpen Ad
    appOpenAdManager.loadAd();

    //Show AppOpen Ad After 8 Seconds
    Future.delayed(const Duration(milliseconds: 5000)).then((value) {
      if (_isLoaded && OnePref.getPremium() == false) {
        //Here we will wait for 8 seconds to load our ad
        //After 8 second it will go to HomePage
        appOpenAdManager.showAdIfAvailable();
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavigationPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Container(
          width: 150.0,
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

  void restoreSub() {
    iApEngine.inAppPurchase.restorePurchases();
  }
}
