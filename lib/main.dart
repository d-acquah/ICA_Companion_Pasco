import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ica_companion_pasco/pages/splash_screen.dart';
// ignore: import_of_legacy_library_into_null_safe
//import 'package:ica_companion_pasco/pages/bottom_navigation_page.dart';
//import 'package:ica_companion_pasco/pages/splash_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  static final String oneSignalAppId = "ddaa4dce-88d2-4450-9f80-60c0881fe5e9";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ICA Companion: Pasco',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }

  Future<void> initPlatformState() async {
    OneSignal.shared.setAppId(oneSignalAppId);
  }
}
