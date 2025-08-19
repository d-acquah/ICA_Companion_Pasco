import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ica_companion_pasco/models/pasco_model.dart';
import 'package:ica_companion_pasco/widgets/year_list_tile.dart';
import 'package:onepref/onepref.dart';

class HomeYearPage extends StatefulWidget {
  HomeYearPage({Key? key, required this.homeYear, required this.monthYear, required this.name}) : super(key: key);
  final List<MonthYear> monthYear;
  final String name;
  final HomeYear homeYear;

  @override
  State<HomeYearPage> createState() => _HomeYearPageState();
}

class _HomeYearPageState extends State<HomeYearPage> {
bool _isLoaded = true;
IApEngine iApEngine = IApEngine();

final BannerAd myBanner = BannerAd(
      size: AdSize.banner,
      adUnitId: Platform.isAndroid
          ? "ca-app-pub-2530239307985191/4923044950"
          : "ca-app-pub-3940256099942544/2934735716",
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('$BannerAd failedToLoad: $error');
        },),
      
      request: AdRequest());
      

  @override
  void initState() {
    super.initState();
    myBanner.load();
    restoreSub();
    validatePremiumFromDatabase();

    iApEngine.inAppPurchase.purchaseStream.listen((list) {
      if (list.isNotEmpty) {
        OnePref.setPremium(true);
        //restore the subscription
      } else {
        //do nothing or deactivate the subscription if the user is premium
        OnePref.setPremium(false);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(toolbarHeight:65,
        centerTitle: true, automaticallyImplyLeading: false,
          title: Text(
          widget.homeYear.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white, 
                    ),
        ),
       
         elevation: 0,
        backgroundColor: Colors.blue,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
            ),
        ),
      ),
      body: SafeArea(
          child: ListView.builder(
              itemCount: widget.homeYear.monthYear.length,
              itemBuilder: (context, index) {
                return YearListTile(
                  monthYear: widget.homeYear.monthYear[index],
                );
              })),
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
    );
  }
  
  void restoreSub() {
    iApEngine.inAppPurchase.restorePurchases();
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
}