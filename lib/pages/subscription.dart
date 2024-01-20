import 'dart:io';

import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
//import 'package:ica_companion_pasco/pages/bottom_navigation_page.dart';
// ignore: depend_on_referenced_packages
import 'package:in_app_purchase/in_app_purchase.dart';
// ignore: depend_on_referenced_packages
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

import 'package:onepref/onepref.dart';

import '../../components/snackbar.dart';
import '../../main.dart';
import '../utils/constants.dart';

class Subscriptions extends StatefulWidget {
  const Subscriptions({super.key});

  @override
  State<Subscriptions> createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
  late final List<ProductDetails> _products = <ProductDetails>[];
  IApEngine iApEngine = IApEngine();
  bool isSubscribed = false;
  bool isRestore = false;

  final List<ProductId> _productsIds = [
    ProductId(id: "monthly_sub", isConsumable: false),
    //ProductId(id: "quarterly_sub", isConsumable: false),
  ];

  late BannerAd _bannerAd;
  bool _isLoaded = false;

  bool subExisting = false;

  late PurchaseDetails oldPurchaseDetails;

  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  @override
  void initState() {
    super.initState();
    restoreSub();

    isSubscribed = OnePref.getPremium()!;

    iApEngine.inAppPurchase.purchaseStream.listen((purchaseDetailsList) {
      //listen to the purchase

      if (purchaseDetailsList.isNotEmpty) {
        setState(() {
          subExisting = true;
          oldPurchaseDetails = purchaseDetailsList[0];
          OnePref.setPremium(true);
        });
      } else {
        //do nothing or deactivate the subscription if the user is premium
        OnePref.setPremium(false);
      }

      listenPurchasedActivities(purchaseDetailsList);

      if (purchaseDetailsList.isEmpty && isRestore) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          openSnackBar(
            context: context,
            btnName: "OK",
            title: "Restore",
            message: "Oops! You do not have a subscription to restore",
            color: Colors.accents,
            bgColor: Constants.txtColor,
          );
        });
      } else if (purchaseDetailsList.isNotEmpty && isRestore) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          openSnackBar(
            context: context,
            btnName: "OK",
            title: "Restore",
            message:
                "Congrats! You got a purchase to restore, it will be restored in a sec.",
            color: Colors.accents,
            bgColor: Colors.green,
          );
        });
      }
    }, onDone: () {
      print("onDone");
    }, onError: (Object error) {
      print("onError");
    });

    //get products
    getProducts();
    loadAd();
  }

  void getProducts() async {
    await iApEngine.getIsAvailable().then((value) async => {
          if (value)
            {
              await iApEngine.queryProducts(_productsIds).then((value) {
                _products.clear();
                setState(() {
                  _products.addAll(value.productDetails);
                });
                if (value.notFoundIDs.isNotEmpty) {}
              })
            }
        });
  }

  void loadAd() {
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }

  Future<void> listenPurchasedActivities(List<PurchaseDetails> list) async {
    if (list.isNotEmpty) {
      for (var purchaseDetails in list) {
        if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          //This is for the android
          if (Platform.isAndroid &&
              iApEngine
                  .getProductIdsOnly(_productsIds)
                  .contains(purchaseDetails.productID) &&
              _productsIds
                      .where(
                          (element) => element.id == purchaseDetails.productID)
                      .first
                      .isConsumable ==
                  true) {
            final InAppPurchaseAndroidPlatformAddition androidPlatformAddition =
                iApEngine.inAppPurchase.getPlatformAddition<
                    InAppPurchaseAndroidPlatformAddition>();

            //
            //
            await androidPlatformAddition.consumePurchase(purchaseDetails).then(
                  (value) => setState(() => {
                        OnePref.setPremium(true),
                        isSubscribed = OnePref.getPremium() ?? false,
                      }),
                );
          }

          //handles pending purchases
          if (purchaseDetails.pendingCompletePurchase) {
            await iApEngine.inAppPurchase
                .completePurchase(purchaseDetails)
                .then(
                  (value) => setState(() => {
                        OnePref.setPremium(true),
                        isSubscribed = OnePref.getPremium() ?? false,
                      }),
                );
          }
        }
      }
    } else {
      setState(() {
        OnePref.setPremium(false);
        isSubscribed = OnePref.getPremium() ?? false;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                const Text(
                  "${Constants.appName} ",
                  style: TextStyle(
                    fontSize: 24, // Adjust the font size as needed
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isSubscribed ? Colors.green : Colors.blue,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(7.0), // Adjust as needed
                    child: Text(
                      "PRO",
                      style: TextStyle(
                        fontSize: 14, // Adjust the font size as needed
                        fontWeight: FontWeight.w400,
                        color: isSubscribed ? Colors.white : Colors.blue,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          backgroundColor: Colors.blue,
          // elevation: 0.0, // Set elevation to zero
        ),
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 0.0),
                  child: SizedBox(
                    
                    height:MediaQuery.of(context).size.height * 0.36,
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const ListTile(
                          title: Text(
                            'Upgrade to Premium',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          subtitle: Text(
                            "Here's what you get:",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: Color(0xff333333)),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.12,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 12.0),
                            child: const Card(
                              color: Colors.white,
                              child: ListTile(
                                title: Text(
                                  'Downloads',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                subtitle: Text(
                                  "Download and view past questions offline",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      color: Color(0xff333333)),
                                ),
                                leading: Icon(Icons.download),
                                iconColor: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        //const SizedBox(
                        //height: 0,
                        //  ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.12,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 12.0),
                            child: Card(
                              color: Colors.white,
                              child: ListTile(
                                title: Text(
                                  'No Ads',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                subtitle: Text(
                                  "Enjoy ICA Companion without Ads",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      color: Color(0xff333333)),
                                ),
                                leading: Image.asset(
                                  'asset/No Ads1.jpg', // Replace with the path to your image
                                  width: 60, // Adjust the width as needed
                                  height: 60, // Adjust the height as needed
                                ),
                              ),
                            ),
                          )
                        ),
                        const SizedBox(
                          height: 0,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Visibility(
                  visible: !_products.isNotEmpty,
                  child: const SizedBox(
                    height: 90,
                    width: 90,
                    child: CircularProgressIndicator(),
                  ),
                ),
                Flexible(
                  child: Visibility(
                    visible: _products.isNotEmpty,
                    child: ListView.builder(
                      itemBuilder: ((context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 17.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0,
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        _products[index].price,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      subtitle: Text(
                                        _products[index].description,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      trailing: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  8.0), // Adjust the border radius as needed
                                            ),
                                            foregroundColor: Colors.white,
                                            backgroundColor: Colors.blue,
                                            minimumSize: const Size(40, 40),
                                            textStyle:
                                                const TextStyle(fontSize: 14)),
                                        onPressed: () async {
                                          setState(() {
                                            isRestore = false;
                                          });
                                          iApEngine.handlePurchase(
                                              _products[index], _productsIds);
                                        },
                                        child: const Text(
                                          "Subscribe",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                              ],
                            ),
                          )),
                      itemCount: _products.length,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: Container(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8.0), // Adjust the border radius as needed
                            ),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            minimumSize: const Size(50, 50),
                            textStyle: const TextStyle(fontSize: 14)),
                        onPressed: () async => {
                          await InAppPurchase.instance.restorePurchases().then(
                            (value) {
                              isRestore = true;
                              _products.clear();
                              getProducts();
                            },
                          ),
                        },
                        child: const Text(
                          "Restore Subscription",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    child: Text(
                      "If subscription is successful, a premium badge(PRO) appears at top right corner of this screen.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                //const SizedBox(
                //height: 5,
                // ),
                SizedBox(
                  height: 40,
                  child: Container(
                    child: Visibility(
                      visible: _isLoaded && OnePref.getPremium() == false,
                      child: _isLoaded
                          ? Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                // width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: AdWidget(ad: _bannerAd),
                              ),
                            )
                          : Container(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  void restoreSub() {
    iApEngine.inAppPurchase.restorePurchases();
  }
}
