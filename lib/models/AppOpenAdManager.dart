import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppOpenAdManager {
  static final AppOpenAdManager _instance = AppOpenAdManager._internal();
  factory AppOpenAdManager() => _instance;
  AppOpenAdManager._internal();

  AppOpenAd? _appOpenAd;
  bool _isLoaded = false;

  void loadAd({VoidCallback? onAdLoaded}) {
    AppOpenAd.load(
      adUnitId: "ca-app-pub-2530239307985191/4035068069",
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _isLoaded = true;
          onAdLoaded?.call();

          _appOpenAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              _appOpenAd = null;
              _isLoaded = false;
              loadAd(); // Preload next ad
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              _appOpenAd = null;
              _isLoaded = false;
              loadAd(); // Retry loading
            },
          );
        },
        onAdFailedToLoad: (error) {
          print('Failed to load AppOpenAd: $error');
          _isLoaded = false;
        },
      ),
      orientation: AppOpenAd.orientationPortrait,
    );
  }

  void showAdIfAvailable() {
    if (_isLoaded && _appOpenAd != null) {
      _appOpenAd!.show();
    } else {
      print('AppOpenAd not ready');
    }
  }
}
