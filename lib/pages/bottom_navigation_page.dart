import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ica_companion_pasco/home_page.dart';
import 'package:ica_companion_pasco/models/AppOpenAdManager.dart';
import 'package:ica_companion_pasco/models/PdfDocument.dart';
import 'package:ica_companion_pasco/pages/download_page.dart';
import 'package:ica_companion_pasco/pages/pdfviewerscreen.dart';
import 'package:ica_companion_pasco/pages/premium_page.dart';
import 'package:ica_companion_pasco/pages/subscription.dart';
import 'package:ica_companion_pasco/pages/topics_page.dart';
import 'package:ica_companion_pasco/pages/trend_page.dart';
import 'package:ica_companion_pasco/utils/topics_page_locked.dart';
import 'package:ica_companion_pasco/utils/trend_page_locked.dart';
import 'package:onepref/onepref.dart';
import 'package:path_provider/path_provider.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage>
    with WidgetsBindingObserver {
  List<PdfDocument> pdfDocuments = [];
  AppOpenAdManager appOpenAdManager = AppOpenAdManager();
  bool premiumPageVisible = false;
  bool isPaused = false;
  IApEngine iApEngine = IApEngine();
  bool _isLoaded = true;
  int currentIndex = 0;
  InterstitialAd? interstitialAd;
  final screens = [
    HomePage(),
    TrendPage(),
    TopicsPage(),
    Subscriptions(),
    PdfListScreen(),
    PremiumPage(),
  ];
  @override
  void initState() {
    //implement initState
    super.initState();
    premiumPageVisible = false;
    appOpenAdManager.loadAd();
    WidgetsBinding.instance.addObserver(this);
    restoreSub();
    _loadPdfDocuments();

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
  void dispose() {
    //implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      isPaused = true;
    }
    if (state == AppLifecycleState.resumed && isPaused) {
      print("Resumed==========================");
      if (_isLoaded && OnePref.getPremium() == false) {
        appOpenAdManager.showAdIfAvailable();
        isPaused = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Close the app without showing an ad
          SystemNavigator.pop();

          // Return true to indicate that the back button press is handled
          return true;
        },
        child: Scaffold(
          body: screens[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.blue,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            currentIndex: currentIndex,
            onTap: (index) async {
              switch (index) {
                case 0:
                case 3:
                  setState(() {
                    currentIndex = index;
                  });
                  break;
                case 1:
                  restoreSub(); // Start restoring the subscription
                  // You may need to wait for some time here if restoreSub() performs asynchronous operations internally.
                  await Future.delayed(
                      Duration(milliseconds: 500)); // Example: Wait for 1 second
                  if (_isLoaded && OnePref.getPremium() == true) {
                    setState(() {
                      currentIndex = index;
                    });

                    showPersistentDialog(context,
                        'Trend analysis provides insight into the pattern of questions asked over a relevant period of time based on an analysis of the topics examined during those periods. Certain subjects do not necessarily follow any predictable pattern and as such the trend analysis provides the frequently examined topics in such cases. This is meant to be a guide for preparation towards the ICA examination and does not necessarily represent the topics that will be examined.');
                  } else {
                    showTrendLockedDialog(context);
                  }
                  break;
                case 2:
                  restoreSub(); // Start restoring the subscription
                  // You may need to wait for some time here if restoreSub() performs asynchronous operations internally.
                  await Future.delayed(
                      Duration(milliseconds: 500)); // Example: Wait for 1 second
                  if (_isLoaded && OnePref.getPremium() == true) {
                    setState(() {
                      currentIndex = index;
                    });
                  } else {
                    showTopicsLockedDialog(context);
                  }

                  break;
                case 4:
                  restoreSub(); // Start restoring the subscription
                  // You may need to wait for some time here if restoreSub() performs asynchronous operations internally.
                  await Future.delayed(
                      Duration(seconds: 1)); // Example: Wait for 1 second
                  if (_isLoaded && OnePref.getPremium() == true) {
                    setState(() {
                      currentIndex = index;
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Scaffold(
                          appBar: AppBar(
                            centerTitle: true,
                            automaticallyImplyLeading: false,
                            title: Text(
                              'Downloads',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            elevation: 0,
                            backgroundColor: Colors.blue,
                          ),
                          body: Stack(
                            children: [
                              // ListView.separated
                              Positioned.fill(
                                child: ListView.separated(
                                  itemCount: pdfDocuments.length,
                                  separatorBuilder: (context, index) => Divider(
                                    indent: 0,
                                    thickness: 2,
                                  ),
                                  itemBuilder: (context, index) {
                                    final pdfDocument = pdfDocuments[index];
                                    return ListTile(
                                      title: Text(pdfDocument.title),
                                      onTap: () {},
                                    );
                                  },
                                ),
                              ),
                              // AlertDialog
                              Positioned.fill(
                                child: Container(
                                    color: Colors.transparent,
                                    alignment: Alignment.center,
                                    child: AlertDialog(
                                      backgroundColor:
                                          Colors.blue, // Set background color
                                      title: Text(
                                        'Download Feature',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white, fontSize: 24,
                                          fontWeight: FontWeight
                                              .w600, // Set font weight
                                        ), // Set title text color
                                      ),
                                      content: SingleChildScrollView(
                                        child: Text(
                                          'The download feature is available to premium users only. Subscribe to the premium version to get access to download and view past questions offline.',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ), // Set content text color
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'OK',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight
                                                  .w600, // Set font weight
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.trending_up),
                label: 'Trend',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.topic),
                label: 'Topics',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.workspace_premium_outlined),
                label: 'Premium',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.download),
                label: 'Download',
              ),
            ],
          ),
        ));
  }

  void showPersistentDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue, // Set background color
          title: Text(
            'Disclaimer', textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white, fontSize: 24,
              fontWeight: FontWeight.w600, // Set font weight
            ), // Set title text color
          ),
          content: SingleChildScrollView(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ), // Set content text color
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.white, fontSize: 20,
                  fontWeight: FontWeight.w600, // Set font weight
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void restoreSub() {
    iApEngine.inAppPurchase.restorePurchases();
  }

  Future<void> _loadPdfDocuments() async {
    try {
      // Replace with your logic to load PDF documents from storage
      final directory = await getApplicationDocumentsDirectory();
      final files = Directory(directory.path).listSync();

      pdfDocuments.clear(); // Clear existing documents (if any)

      for (var file in files) {
        if (file is File && file.path.endsWith('.pdf')) {
          pdfDocuments.add(PdfDocument(
            title: file.uri.pathSegments.last,
            localPath: file.path,
            id: 1,
          ));
        }
      }

      setState(() {}); // Update the UI with loaded documents
    } catch (e) {
      // Handle any errors during loading
      print('Error loading PDF documents: $e');
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 65,
          title: Text('Non-Dismissible AlertDialog Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AbsorbPointer(
                    absorbing: true,
                    child: AlertDialog(
                      title: Text('Non-Dismissible Alert'),
                      content:
                          Text('This alert cannot be dismissed by the user.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                                context); // Close the dialog if needed
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Text('Show Non-Dismissible AlertDialog'),
          ),
        ),
      ),
    );
  }
}

class StaticDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Static Dialog'),
      content: Text('This dialog cannot be dismissed by the user.'),

      // Set barrierDismissible to false to make the dialog not dismissible
    );
  }
}
