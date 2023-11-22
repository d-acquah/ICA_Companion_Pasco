
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ica_companion_pasco/models/pasco_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class PDFViewer extends StatefulWidget {
  final MonthYear monthYear;

  const PDFViewer({Key? key, required this.monthYear}) : super(key: key);

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
final BannerAd myBanner = BannerAd(
      size: AdSize.banner,
      adUnitId: Platform.isAndroid
          ? "ca-app-pub-3940256099942544/6300978111"
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
           backgroundColor: Colors.blue,
          content: Text('Make sure you have internet connection'),
          duration: Duration(seconds: 3),
        ),
      );
    });
  }
@override
  Widget build(BuildContext context) {
    

InterstitialAd.load(
            adUnitId: Platform.isAndroid
                ? "ca-app-pub-3940256099942544/1033173712"
                : "ca-app-pub-2530239307985191/5454409211",
            request: const AdRequest(),
           adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
              ad.show();
               
            }, onAdFailedToLoad: (err) {
             debugPrint(err.message);

           }));
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
    body: SfPdfViewer.network(widget.monthYear.link),
    bottomNavigationBar: Container(
    height: 50,
    child: AdWidget(ad: myBanner),
              ),
    ));
  }
}
