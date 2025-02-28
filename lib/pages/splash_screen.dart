import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ica_companion_pasco/models/AppOpenAdManager.dart';
import 'package:ica_companion_pasco/pages/bottom_navigation_page.dart';
import 'package:onepref/onepref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String subscriptionKey = 'subscriptionStatus';
  final String subscriptionDateKey = 'subscriptionStartDate';
  AppOpenAdManager appOpenAdManager = AppOpenAdManager();
  IApEngine iApEngine = IApEngine();
  bool _isLoaded = true;

    // Set subscription status in shared_preferences
  Future<void> setSubscriptionStatus(bool status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (status) {
      // Store subscription status and start date when successful
      await prefs.setBool(subscriptionKey, true);
      await prefs.setString(subscriptionDateKey, DateTime.now().toIso8601String());
    } else {
      // Clear subscription status on failure
      await prefs.setBool(subscriptionKey, false);
      await prefs.remove(subscriptionDateKey);
    }
  }
  
// Check if subscription is still valid (within 30 days)
  Future<bool> isSubscriptionValid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isSubscribed = prefs.getBool(subscriptionKey);
    final String? subscriptionDateStr = prefs.getString(subscriptionDateKey);

    if (isSubscribed != null && isSubscribed && subscriptionDateStr != null) {
      final DateTime subscriptionStartDate = DateTime.parse(subscriptionDateStr);
      final DateTime currentDate = DateTime.now();
      final int minutesElapsed = currentDate.difference(subscriptionStartDate).inDays;

      if (minutesElapsed <= 5) {
        return true; // Subscription is still valid
      } else {
        // Subscription expired
        await setSubscriptionStatus(false);
        return false;
      }
    }
    return false;
  }


  @override
  void initState() {
    super.initState();
    restoreSub();
    // Check subscription status on app start
    


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
      isSubscriptionValid().then((valid) {
      if (_isLoaded && valid) {
        print('Subscription is still active.');
      } else {
        print('Subscription has expired.');
        appOpenAdManager.showAdIfAvailable();
      }
    });
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
