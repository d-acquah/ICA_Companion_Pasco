import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ica_companion_pasco/models/pasco_model.dart';
import 'package:ica_companion_pasco/widgets/year_list_tile.dart';
import 'package:onepref/onepref.dart';

class TopicsYearsPage extends StatefulWidget {
  TopicsYearsPage({Key? key, required this.monthYear, required this.title}) : super(key: key);
  final List<MonthYear> monthYear;
  final String title;

  @override
  State<TopicsYearsPage> createState() => _TopicsYearsPageState();
}

class _TopicsYearsPageState extends State<TopicsYearsPage> {
bool _isLoaded = true;
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
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight:65,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          widget.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
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
              itemCount: widget.monthYear.length,
              itemBuilder: (context, index) {
                return YearListTile(
                  monthYear: widget.monthYear[index],
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
}
