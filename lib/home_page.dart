import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ica_companion_pasco/data/menu_items.dart';
import 'package:ica_companion_pasco/home_year_page.dart';
import 'package:flutter/material.dart';
import 'package:ica_companion_pasco/models/menu_item.dart';
import 'package:ica_companion_pasco/models/pasco_model.dart';
//import 'package:ica_companion_pasco/pages/next_page.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final ScrollController _scrollController = ScrollController();
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

  InterstitialAd? interstitialAd;
  bool _canPop = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        {
          if (_canPop) {
            return true;
          } else {
            await Future.delayed(Duration(milliseconds: 500));
            setState(() {
              _canPop = true;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.blue,
                content: Text('Press back button again to exit'),
                duration: Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        }
        await InterstitialAd.load(
            adUnitId: Platform.isAndroid
                ? "ca-app-pub-2530239307985191/5038971352"
                : "ca-app-pub-3940256099942544/4411468910",
            request: const AdRequest(),
            adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
              interstitialAd = ad;
              ad.show();
              interstitialAd?.fullScreenContentCallback =
                  FullScreenContentCallback(
                      onAdDismissedFullScreenContent: (ad) {
                interstitialAd?.dispose();
                ad.dispose();
                SystemNavigator.pop();
              }, onAdFailedToShowFullScreenContent: (ad, err) {
                ad.dispose();
                interstitialAd?.dispose();
              });
            }, onAdFailedToLoad: (err) {
              debugPrint(err.message);

              // ignore: dead_code
              // Navigator.push(context,MaterialPageRoute(builder: (context){
              //                return NextPage();
            }));
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'ICA Companion : Pasco',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          actions: [
            PopupMenuButton<MenuItem>(
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                ...MenuItems.itemsFirst.map(buildItem).toList(),
              ],
            ), // IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
          elevation: 0,
          backgroundColor: Colors.blue,
        ),
        body: Stack(
          children: [
            ListView(
            children: [ 
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Level 1',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeYearPage(
                      homeYear: HomeYear(
                        name: "Financial Accounting",
                        monthYear: [
                          MonthYear(
                              name: "1.1 Mar 2023",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/06/mar-2023-_1.1_financial_accounting.pdf"),
                          MonthYear(
                              name: "1.1 Dec 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/05/dec-2022-_1.1_financial_accounting.pdf"),
                          MonthYear(
                              name: "1.1 Aug 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/aug-2022-_1.1_financial_accounting.pdf"),
                          MonthYear(
                              name: "1.1 Apr 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/apr-2022-_1.1_financial_accounting.pdf"),
                          MonthYear(
                              name: "1.1 Nov 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/10/nov-2021-_1.1_financial_accounting.pdf"),
                          MonthYear(
                              name: "1.1 May 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/07/may-2021_1.1_financial_accounting.pdf"),
                          MonthYear(
                              name: "1.1 Nov 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/03/nov-2020-_1.1_financial_accounting.pdf"),
                          MonthYear(
                              name: "1.1 May 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2020_1.1_financial_accounting.pdf"),
                          MonthYear(
                              name: "1.1 Nov 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2019-_1.1_financial_accounting-2.pdf"),
                          MonthYear(
                              name: "1.1 May 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may_2019_1.1_financial_accounting-2.pdf"),
                          MonthYear(
                              name: "1.1 Nov 2018",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2018-_1.1_financial_accounting-2.pdf"),
                          MonthYear(
                              name: "1.1 May 2018",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2018-_1.1_financial_accounting-2.pdf"),
                          MonthYear(
                              name: "1.1 Nov 2017",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2017_1.1_financial_accounting-2.pdf"),
                          MonthYear(
                              name: "1.1 May 2017",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2017-_1.1_financial_accounting-2.pdf"),
                          MonthYear(
                              name: "1.1 Nov 2016",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2016-_1.1_financial_accounting-2.pdf"),
                          MonthYear(
                              name: "1.1 May 2016",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2016_1.1_financial_accounting-2.pdf"),
                          MonthYear(
                              name: "1.1 Nov 2015",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2015-_1.1_financial_accounting-2.pdf"),
                        ],
                      ),
                      monthYear: [],
                      name: '',
                    );
                  }));
                },
                title: const Text(
                  'Financial Accounting',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
              const Divider(
                indent: 0,
                thickness: 2,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeYearPage(
                      homeYear: HomeYear(
                        name: "Business Management & Information System",
                        monthYear: [
                          MonthYear(
                              name: "1.2 Mar 2023",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/06/mar-2023-_1.2_business_management_info_systems.pdf"),
                          MonthYear(
                              name: "1.2 Dec 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/05/dec-2022-_1.2_business_management_info_systems.pdf"),
                          MonthYear(
                              name: "1.2 Aug 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/aug-2022-_1.2_business_management_info_systems.pdf"),
                          MonthYear(
                              name: "1.2 Apr 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/apr-2022-_1.2_business_management_info_systems.pdf"),
                          MonthYear(
                              name: "1.2 Nov 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/10/nov-2021-_1.2_business_management_info_systems.pdf"),
                          MonthYear(
                              name: "1.2 May 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/07/may-2021-_1.2_business_management_info_systems.pdf"),
                          MonthYear(
                              name: "1.2 Nov 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/03/nov-2020-_1.2_business_management_info_systems.pdf"),
                          MonthYear(
                              name: "1.2 May 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/10/may-2020-_1.2_business_management_info_systems.pdf"),
                          MonthYear(
                              name: "1.2 Nov 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2019-_1.2_business_management_info_systems-3.pdf"),
                          MonthYear(
                              name: "1.2 May 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2019-_1.2_business_management_info_systems-3.pdf"),
                          MonthYear(
                              name: "1.2 Nov 2018",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2018-_1.2_business_management_info_systems-3.pdf"),
                          MonthYear(
                              name: "1.2 May 2018",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2018-_1.2_business_management_info_systems-3.pdf"),
                          MonthYear(
                              name: "1.2 Nov 2017",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2017-_1.2_business_management_info_systems-3.pdf"),
                          MonthYear(
                              name: "1.2 May 2017",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2017-_1.2_business_management_info_systems-3.pdf"),
                          MonthYear(
                              name: "1.2 Nov 2016",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2016-_1.2_business_management_info_systems-3.pdf"),
                          MonthYear(
                              name: "1.2 May 2016",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2016-_1.2_business_management_info_systems-3.pdf"),
                          MonthYear(
                              name: "1.2 Nov 2015",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2015-_1.2_business_management_info_systems-3.pdf"),
                        ],
                      ),
                      monthYear: [],
                      name: '',
                    );
                  }));
                },
                title: const Text(
                  'Business Management & Information System',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
              const Divider(
                indent: 0,
                thickness: 2,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeYearPage(
                      homeYear: HomeYear(
                        name: "Business & Corporate Law",
                        monthYear: [
                          MonthYear(
                              name: "1.3 Mar 2023",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/06/mar-2023-_1.3_business-corporate-law.pdf"),
                          MonthYear(
                              name: "1.3 Dec 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/05/dec-2022-_1.3_business-corporate-law.pdf"),
                          MonthYear(
                              name: "1.3 Apr 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/apr-2022-_1.3_business-corporate-law.pdf"),
                          MonthYear(
                              name: "1.3 Nov 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/10/nov-2021-_1.3_business-corporate-law.pdf"),
                          MonthYear(
                              name: "1.3 May 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/07/may-2021-_1.3_business-corporate-law.pdf"),
                          MonthYear(
                              name: "1.3 Nov 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/03/nov-2020-_1.3_business-corporate-law.pdf"),
                          MonthYear(
                              name: "1.3 May 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/10/may-2020-_1.3_business-corporate-law.pdf"),
                          MonthYear(
                              name: "1.3 Nov 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2019-_1.3_business-corporate-law-1.pdf"),
                          MonthYear(
                              name: "1.3 May 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2019-_1.3_business-corporate-law-1.pdf"),
                          MonthYear(
                              name: "1.3 Nov 2018",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2018-_1.3_business-corporate-law-1.pdf"),
                          MonthYear(
                              name: "1.3 May 2018",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2018-_1.3_business-corporate-law-1.pdf"),
                          MonthYear(
                              name: "1.3 Nov 2017",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2017-_1.3_business-corporate-law-1.pdf"),
                          MonthYear(
                              name: "1.3 May 2017",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2017_1.3_business-corporate-law-1.pdf"),
                          MonthYear(
                              name: "1.3 Nov 2016",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2016-_1.3_business-corporate-law-1.pdf"),
                          MonthYear(
                              name: "1.3 May 2016",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2016_1.3_business-corporate-law-1.pdf"),
                          MonthYear(
                              name: "1.3 Nov 2015",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2015-_1.3_business-corporate-law-1.pdf"),
                        ],
                      ),
                      monthYear: [],
                      name: '',
                    );
                  }));
                },
                title: const Text(
                  'Business & Corporate Law',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
              const Divider(
                indent: 0,
                thickness: 2,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeYearPage(
                      homeYear: HomeYear(
                        name: "Introduction to Management Accounting",
                        monthYear: [
                          MonthYear(
                              name: "1.4 Mar 2023",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/06/mar-2023_1.4_introduction_to_management_accounting.pdf"),
                          MonthYear(
                              name: "1.4 Dec 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/05/dec-2022_1.4_introduction_to_management_accounting.pdf"),
                          MonthYear(
                              name: "1.4 Aug 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/aug-2022_1.4_introduction_to_management_accounting.pdf"),
                          MonthYear(
                              name: "1.4 Apr 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/apr-2022_1.4_introduction_to_management_accounting.pdf"),
                          MonthYear(
                              name: "1.4 Nov 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/10/nov-2021_1.4_introduction_to_management_accounting.pdf"),
                          MonthYear(
                              name: "1.4 May 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/07/may-2021_1.4_introduction_to_management_accounting.pdf"),
                          MonthYear(
                              name: "1.4 Nov 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/03/nov-2020_1.4_introduction_to_management_accounting.pdf"),
                          MonthYear(
                              name: "1.4 May 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/10/may-2020_1.4_introduction_to_management_accounting.pdf"),
                          MonthYear(
                              name: "1.4 Nov 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2019_1.4_introduction_to_management_accounting-1.pdf"),
                        ],
                      ),
                      monthYear: [],
                      name: '',
                    );
                  }));
                },
                title: const Text(
                  'Introduction to Management Accounting',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
              const Divider(
                indent: 0,
                thickness: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Level 2',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeYearPage(
                      homeYear: HomeYear(
                        name: "Financial Reporting",
                        monthYear: [
                          MonthYear(
                              name: "2.1 Mar 2023",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/06/mar-2023_2.1_financial_reporting.pdf"),
                          MonthYear(
                              name: "2.1 Dec 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/05/dec-2022_2.1_financial_reporting.pdf"),
                          MonthYear(
                              name: "2.1 Aug 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/aug-2022_2.1_financial_reporting.pdf"),
                          MonthYear(
                              name: "2.1 Apr 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/apr-2022_2.1_financial_reporting.pdf"),
                          MonthYear(
                              name: "2.1 Nov 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/11/nov-2021_2.1_financial_reporting.pdf"),
                          MonthYear(
                              name: "2.1 May 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/07/may-2021_2.1_financial_reporting.pdf"),
                          MonthYear(
                              name: "2.1 Nov 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/03/nov-2020_2.1_financial_reporting.pdf"),
                          MonthYear(
                              name: "2.1 May 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/10/may-2020_2.1_financial_reporting.pdf"),
                          MonthYear(
                              name: "2.1 Nov 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2019_2.1_financial_reporting-2.pdf"),
                          MonthYear(
                              name: "2.1 May 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2019_2.1_financial_reporting-2.pdf"),
                          MonthYear(
                              name: "2.1 Nov 2018",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2018_2.1_financial_reporting-2.pdf"),
                          MonthYear(
                              name: "2.1 May 2018",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2018_2.1_financial_reporting-2.pdf"),
                          MonthYear(
                              name: "2.1 Nov 2017",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2017_2.1_financial_reporting-2.pdf"),
                          MonthYear(
                              name: "2.1 May 2017",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2017_2.1_financial_reporting-2.pdf"),
                          MonthYear(
                              name: "2.1 Nov 2016",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2016_2.1_financial_reporting-2.pdf"),
                          MonthYear(
                              name: "2.1 May 2016",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2016_2.1_financial_reporting-2.pdf"),
                          MonthYear(
                              name: "2.1 Nov 2015",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2015_2.1_financial_reporting-2.pdf"),
                        ],
                      ),
                      monthYear: [],
                      name: '',
                    );
                  }));
                },
                title: const Text(
                  'Financial Reporting',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
              const Divider(
                indent: 0,
                thickness: 2,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeYearPage(
                      homeYear: HomeYear(
                        name: "Management Accounting",
                        monthYear: [
                          MonthYear(
                              name: "2.2 Mar 2023",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/06/mar-2023_2.2_management_accounting.pdf"),
                          MonthYear(
                              name: "2.2 Dec 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/05/dec-2022_2.2_management_accounting.pdf"),
                          MonthYear(
                              name: "2.2 Aug 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/aug-2022_2.2_management_accounting.pdf"),
                          MonthYear(
                              name: "2.2 Apr 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/apr-2022_2.2_management_accounting.pdf"),
                          MonthYear(
                              name: "2.2 Nov 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/11/nov-2021_2.2_management_accounting.pdf"),
                          MonthYear(
                              name: "2.2 May 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/07/may-2021_2.2_management_accounting.pdf"),
                          MonthYear(
                              name: "2.2 Nov 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/03/nov-2020_2.2_management_accounting.pdf"),
                          MonthYear(
                              name: "2.2 May 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/10/may-2020_2.2_management_accounting.pdf"),
                          MonthYear(
                              name: "2.2 Nov 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/04/nov-2019_2.2_management_accounting.pdf"),
                          MonthYear(
                              name: "2.2 May 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/04/may-2019_2.2_management_accounting.pdf"),
                          MonthYear(
                              name: "2.2 Nov 2018",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2018_2.2_management_accounting-2.pdf"),
                          MonthYear(
                              name: "2.2 May 2018",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2018_2.2_management_accounting-2.pdf"),
                          MonthYear(
                              name: "2.2 Nov 2017",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2017_2.2_management_accounting-2.pdf"),
                          MonthYear(
                              name: "2.2 May 2017",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2017_2.2_management_accounting-2.pdf"),
                          MonthYear(
                              name: "2.2 Nov 2016",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2016_2.2_management_accounting-2.pdf"),
                          MonthYear(
                              name: "2.2 May 2016",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2016_2.2_management_accounting-2.pdf"),
                          MonthYear(
                              name: "2.2 Nov 2015",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2015-2.2_management_accounting-2.pdf"),
                        ],
                      ),
                      monthYear: [],
                      name: '',
                    );
                  }));
                },
                title: const Text(
                  'Management Accounting',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
              const Divider(
                indent: 0,
                thickness: 2,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeYearPage(
                      homeYear: HomeYear(
                        name: "Audit & Assurance",
                        monthYear: [
                          MonthYear(
                              name: "2.3 Mar 2023",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/06/mar-2023_2.3_audit_assurance.pdf"),
                          MonthYear(
                              name: "2.3 Dec 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/05/dec-2022_2.3_audit_assurance.pdf"),
                          MonthYear(
                              name: "2.3 Aug 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/aug-2022_2.3_audit_assurance.pdf"),
                          MonthYear(
                              name: "2.3 Apr 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/apr-2022_2.3_audit_assurance.pdf"),
                          MonthYear(
                              name: "2.3 Nov 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/11/nov-2021_2.3_audit_assurance.pdf"),
                          MonthYear(
                              name: "2.3 May 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/07/may-2021_2.3_audit_assurance.pdf"),
                          MonthYear(
                              name: "2.3 Nov 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/03/nov-2020_2.3_audit_assurance.pdf"),
                          MonthYear(
                              name: "2.3 May 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/10/may-2020_2.3_audit_assurance.pdf"),
                          MonthYear(
                              name: "2.3 Nov 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2019_2.3_audit_assurance-2.pdf"),
                          MonthYear(
                              name: "2.3 May 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2019_2.3_audit_assurance-2.pdf"),
                          MonthYear(
                              name: "2.3 Nov 2018",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2018_2.3_audit_assurance-2.pdf"),
                          MonthYear(
                              name: "2.3 May 2018",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2018_2.3_audit_assurance-2.pdf"),
                          MonthYear(
                              name: "2.3 Nov 2017",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2017_2.3_audit_assurance-2.pdf"),
                          MonthYear(
                              name: "2.3 May 2017",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2017_2.3_audit_assurance-2.pdf"),
                          MonthYear(
                              name: "2.3 Nov 2016",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2016_2.3_audit_assurance-2.pdf"),
                          MonthYear(
                              name: "2.3 May 2016",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2016_2.3_audit_assurance-2.pdf"),
                          MonthYear(
                              name: "2.3 Nov 2015",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2015_2.3_audit_assurance-2.pdf"),
                        ],
                      ),
                      monthYear: [],
                      name: '',
                    );
                  }));
                },
                title: const Text(
                  'Audit & Assurance',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
              const Divider(
                indent: 0,
                thickness: 2,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeYearPage(
                      homeYear: HomeYear(
                        name: "Financial Management",
                        monthYear: [
                          MonthYear(
                              name: "2.4 Mar 2023",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/06/mar-2023_2.4_financial_management.pdf"),
                          MonthYear(
                              name: "2.4 Dec 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/05/dec-2022_2.4_financial_management.pdf"),
                          MonthYear(
                              name: "2.4 Aug 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/aug-2022_2.4_financial_management.pdf"),
                          MonthYear(
                              name: "2.4 Apr 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/apr-2022_2.4_financial_management.pdf"),
                          MonthYear(
                              name: "2.4 Nov 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/11/nov-2021_2.4_financial_management.pdf"),
                          MonthYear(
                              name: "2.4 May 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/07/may_2021_2.4_financial_management.pdf"),
                          MonthYear(
                              name: "2.4 Nov 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/03/nov_2020_2.4_financial_management.pdf"),
                          MonthYear(
                              name: "2.4 May 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/10/may_2020_2.4_financial_management.pdf"),
                          MonthYear(
                              name: "2.4 Nov 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov_2019_2.4_financial_management-2.pdf"),
                          MonthYear(
                              name: "2.4 May 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may_2019_2.4_financial_management-2.pdf"),
                          MonthYear(
                              name: "2.4 Nov 2018",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov_2018_2.4_financial_management-2.pdf"),
                          MonthYear(
                              name: "2.4 May 2018",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may_2018_2.4_financial_management-2.pdf"),
                          MonthYear(
                              name: "2.4 Nov 2017",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov_2017_2.4_financial_management-2.pdf"),
                          MonthYear(
                              name: "2.4 May 2017",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may_2017_2.4_financial_management-2.pdf"),
                          MonthYear(
                              name: "2.4 Nov 2016",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov_2016_2.4_financial_management-2.pdf"),
                          MonthYear(
                              name: "2.4 May 2016",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may_2016_2.4_financial_management-2.pdf"),
                          MonthYear(
                              name: "2.4 Nov 2015",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov_2015_2.4_financial_management-2.pdf"),
                        ],
                      ),
                      monthYear: [],
                      name: '',
                    );
                  }));
                },
                title: const Text(
                  'Financial Management',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
              const Divider(
                indent: 0,
                thickness: 2,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeYearPage(
                      homeYear: HomeYear(
                        name: "Public Sector Accounting & Finance",
                        monthYear: [
                          MonthYear(
                              name: "2.5 Mar 2023",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/06/mar-2022_2.5_public_sector_accounting.pdf"),
                          MonthYear(
                              name: "2.5 Dec 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/05/dec-2022_2.5_public_sector_accounting.pdf"),
                          MonthYear(
                              name: "2.5 Aug 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/aug-2022_2.5_public_sector_accounting.pdf"),
                          MonthYear(
                              name: "2.5 Apr 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/apr-2022_2.5_public_sector_accounting.pdf"),
                          MonthYear(
                              name: "2.5 Nov 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/11/nov-2021_2.5_public_sector_accounting.pdf"),
                          MonthYear(
                              name: "2.5 May 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/07/may-2021_2.5_public_sector_accounting.pdf"),
                          MonthYear(
                              name: "2.5 Nov 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/03/nov-2020_2.5_public_sector_accounting.pdf"),
                          MonthYear(
                              name: "2.5 May 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/10/may-2020_2.5_public_sector_accounting.pdf"),
                          MonthYear(
                              name: "2.5 Nov 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2019_2.5_public_sector_accounting-2.pdf"),
                          MonthYear(
                              name: "2.5 May 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2019_2.5_public_sector_accounting-2.pdf"),
                          MonthYear(
                              name: "2.5 Nov 2018",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2018_2.5_public_sector_accounting-2.pdf"),
                          MonthYear(
                              name: "2.5 May 2018",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2018_2.5_public_sector_accounting-2.pdf"),
                          MonthYear(
                              name: "2.5 Nov 2017",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2017_2.5_public_sector_accounting-2.pdf"),
                          MonthYear(
                              name: "2.5 May 2017",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2017_2.5_public_sector_accounting-2.pdf"),
                          MonthYear(
                              name: "2.5 Nov 2016",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2016_2.5_public_sector_accounting-2.pdf"),
                          MonthYear(
                              name: "2.5 May 2016",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2016_2.5_public_sector_accounting-2.pdf"),
                          MonthYear(
                              name: "2.5 Nov 2015",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2015_2.5_public_sector_accounting-2.pdf"),
                        ],
                      ),
                      monthYear: [],
                      name: '',
                    );
                  }));
                },
                title: const Text(
                  'Public Sector Accounting & Finance',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
              const Divider(
                indent: 0,
                thickness: 2,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeYearPage(
                      homeYear: HomeYear(
                        name: "Principles of Taxation",
                        monthYear: [
                          MonthYear(
                              name: "2.6 Mar 2023",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/06/mar-2023_2.6_principles_of_taxation.pdf"),
                          MonthYear(
                              name: "2.6 Dec 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/05/dec-2022_2.6_principles_of_taxation.pdf"),
                          MonthYear(
                              name: "2.6 Aug 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/aug-2022_2.6_principles_of_taxation.pdf"),
                          MonthYear(
                              name: "2.6 Apr 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/apr-2022_2.6_principles_of_taxation.pdf"),
                          MonthYear(
                              name: "2.6 Nov 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/11/nov-2021_2.6_principles_of_taxation.pdf"),
                          MonthYear(
                              name: "2.6 May 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/07/may-2021_2.6_principles_of_taxation.pdf"),
                          MonthYear(
                              name: "2.6 Nov 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/03/nov-2020_2.6_principles_of_taxation.pdf"),
                          MonthYear(
                              name: "2.6 May 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/10/may-2020_2.6_principles_of_taxation.pdf"),
                          MonthYear(
                              name: "2.6 Nov 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2019_2.6_principles_of_taxation-2.pdf"),
                        ],
                      ),
                      monthYear: [],
                      name: '',
                    );
                  }));
                },
                title: const Text(
                  'Principles of Taxation',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
              const Divider(
                indent: 0,
                thickness: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Level 3',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeYearPage(
                      homeYear: HomeYear(
                        name: "Corporate Reporting",
                        monthYear: [
                          MonthYear(
                              name: "3.1 Mar 2023",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/06/mar-2023_3.1_corporate_reporting.pdf"),
                          MonthYear(
                              name: "3.1 Dec 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/05/dec-2022_3.1_corporate_reporting.pdf"),
                          MonthYear(
                              name: "3.1 Aug 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/aug-2022_3.1_corporate_reporting.pdf"),
                          MonthYear(
                              name: "3.1 Apr 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/apr-2022_3.1_corporate_reporting.pdf"),
                          MonthYear(
                              name: "3.1 Nov 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/11/nov-2021_3.1_corporate_reporting.pdf"),
                          MonthYear(
                              name: "3.1 May 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/07/may-2021_3.1_corporate-reporting.pdf"),
                          MonthYear(
                              name: "3.1 Nov 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/03/nov-2020_3.1_corporate_reporting.pdf"),
                          MonthYear(
                              name: "3.1 May 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/10/may-2020_3.1_corporate-reporting.pdf"),
                          MonthYear(
                              name: "3.1 Nov 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2019_3.1_corporate_reporting-2.pdf"),
                          MonthYear(
                              name: "3.1 May 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2019_3.1_corporate-reporting-2.pdf"),
                          MonthYear(
                              name: "3.1 Nov 2018",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2018_3.1_corporate_reporting-2.pdf"),
                          MonthYear(
                              name: "3.1 May 2018",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2018_3.1_corporate-reporting-2.pdf"),
                          MonthYear(
                              name: "3.1 Nov 2017",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2017_3.1_corporate_reporting-2.pdf"),
                          MonthYear(
                              name: "3.1 May 2017",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2017_3.1_corporate_reporting-2.pdf"),
                          MonthYear(
                              name: "3.1 Nov 2016",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2016_3.1_corporate_reporting-2.pdf"),
                          MonthYear(
                              name: "3.1 May 2016",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2016_3.1_corporate-reporting-2.pdf"),
                          MonthYear(
                              name: "3.1 Nov 2015",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2015_3.1_corporate_reporting-2.pdf"),
                        ],
                      ),
                      monthYear: [],
                      name: '',
                    );
                  }));
                },
                title: const Text(
                  'Corporate Reporting',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
              const Divider(
                indent: 0,
                thickness: 2,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeYearPage(
                      homeYear: HomeYear(
                        name: "Advanced Audit & Assurance",
                        monthYear: [
                          MonthYear(
                              name: "3.2 Mar 2023",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/06/mar-2023_3.2_advanced_audit_assurance.pdf"),
                          MonthYear(
                              name: "3.2 Dec 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/05/dec-2022_3.2_advanced_audit_assurance.pdf"),
                          MonthYear(
                              name: "3.2 Aug 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/aug-2022_3.2_advanced_audit_assurance.pdf"),
                          MonthYear(
                              name: "3.2 Apr 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/apr-2022_3.2_advanced_audit_assurance.pdf"),
                          MonthYear(
                              name: "3.2 Nov 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/11/nov-2021_3.2_advanced_audit_assurance.pdf"),
                          MonthYear(
                              name: "3.2 May 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/07/may-2021_3.2_advanced_audit_assurance.pdf"),
                          MonthYear(
                              name: "3.2 Nov 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/03/nov-2020_3.2_advanced_audit_assurance.pdf"),
                          MonthYear(
                              name: "3.2 May 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/10/may-2020_3.2_advanced_audit_assurance.pdf"),
                          MonthYear(
                              name: "3.2 Nov 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2019_3.2_advanced_audit_assurance-2.pdf"),
                          MonthYear(
                              name: "3.2 May 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2019_3.2_advanced_audit_assurance-2.pdf"),
                          MonthYear(
                              name: "3.2 Nov 2018",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2018_3.2_advanced_audit_assurance-2.pdf"),
                          MonthYear(
                              name: "3.2 May 2018",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2018_3.2_advanced_audit_assurance-2.pdf"),
                          MonthYear(
                              name: "3.2 Nov 2017",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2017_3.2_advanced_audit_assurance-2.pdf"),
                          MonthYear(
                              name: "3.2 May 2017",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2017_3.2_advanced_audit_assurance-2.pdf"),
                          MonthYear(
                              name: "3.2 Nov 2016",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2016_3.2_advanced_audit_assurance-2.pdf"),
                          MonthYear(
                              name: "3.2 May 2016",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2016_3.2_advanced_audit_assurance-2.pdf"),
                          MonthYear(
                              name: "3.2 Nov 2015",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2015_3.2_advanced_audit_assurance-2.pdf"),
                        ],
                      ),
                      monthYear: [],
                      name: '',
                    );
                  }));
                },
                title: const Text(
                  'Advanced Audit & Assurance',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
              const Divider(
                indent: 0,
                thickness: 2,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeYearPage(
                      homeYear: HomeYear(
                        name: "Advanced Taxation",
                        monthYear: [
                          MonthYear(
                              name: "3.3 Mar 2023",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/06/mar-2022_3.3_advanced_taxation.pdf"),
                          MonthYear(
                              name: "3.3 Dec 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/05/dec-2022_3.3_advanced_taxation.pdf"),
                          MonthYear(
                              name: "3.3 Aug 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/aug-2022_3.3_advanced_taxation.pdf"),
                          MonthYear(
                              name: "3.3 Apr 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/apr-2022_3.3_advanced_taxation.pdf"),
                          MonthYear(
                              name: "3.3 Nov 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/11/nov-2021_3.3_advanced_taxation.pdf"),
                          MonthYear(
                              name: "3.3 May 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/07/may-2021_3.3_advanced_taxation.pdf"),
                          MonthYear(
                              name: "3.3 Nov 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/03/nov-2020_3.3_advanced_taxation.pdf"),
                          MonthYear(
                              name: "3.3 May 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/10/may-2020_3.3_taxation_fiscal_policy.pdf"),
                          MonthYear(
                              name: "3.3 Nov 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2019_3.3_advanced_taxation-2.pdf"),
                          MonthYear(
                              name: "3.4 May 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2019_3.4_taxation_fiscal_policy-2.pdf"),
                          MonthYear(
                              name: "3.4 Nov 2018",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2018_3.4_taxation_fiscal_policy-2.pdf"),
                          MonthYear(
                              name: "3.4 May 2018",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2018_3.4_taxation_fiscal_policy-2.pdf"),
                          MonthYear(
                              name: "3.4 Nov 2017",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2017_3.4_taxation_fiscal_policy-2.pdf"),
                          MonthYear(
                              name: "3.4 May 2017",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2017_3.4_taxation_fiscal_policy-2.pdf"),
                          MonthYear(
                              name: "3.4 Nov 2016",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2016_3.4_taxation_fiscal_policy-2.pdf"),
                          MonthYear(
                              name: "3.4 May 2016",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/may-2016_3.4_taxation_fiscal_policy-2.pdf"),
                          MonthYear(
                              name: "3.4 Nov 2015",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2015_3.4_taxation_fiscal_policy-2.pdf"),
                        ],
                      ),
                      monthYear: [],
                      name: '',
                    );
                  }));
                },
                title: const Text(
                  'Advanced Taxation',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
              const Divider(
                indent: 0,
                thickness: 2,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeYearPage(
                      homeYear: HomeYear(
                        name: "Strategic Case Study",
                        monthYear: [
                          MonthYear(
                              name: "3.4 Mar 2023",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/06/mar-2023_3.4_strategic_case_study.pdf"),
                          MonthYear(
                              name: "3.4 Dec 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2023/05/dec-2022_3.4_strategic_case_study.pdf"),
                          MonthYear(
                              name: "3.4 Aug 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/aug-2022_3.4_strategic_case_study.pdf"),
                          MonthYear(
                              name: "3.4 Apr 2022",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/12/apr-2022_3.4_strategic_case_study.pdf"),
                          MonthYear(
                              name: "3.4 Nov 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2022/11/nov-2021_3.4_strategic_case_study.pdf"),
                          MonthYear(
                              name: "3.4 May 2021",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/07/may-2021_3.4_strategic_case_study.pdf"),
                          MonthYear(
                              name: "3.4 Nov 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2021/03/nov-2020_3.4_strategic_case_study.pdf"),
                          MonthYear(
                              name: "3.4 May 2020",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/10/may-2020_3.4_strategic_case_study.pdf"),
                          MonthYear(
                              name: "3.4 Nov 2019",
                              link:
                                  "https://mypascoblog.files.wordpress.com/2020/08/nov-2019_3.4_strategic_case_study.pdf"),
                        ],
                      ),
                      monthYear: [],
                      name: '',
                    );
                  }));
                },
                title: const Text(
                  'Strategic Case Study',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
              const Divider(
                indent: 0,
                thickness: 2,
              ),
              ListTile()
               ],
            
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50,
                child: AdWidget(ad: myBanner),
              )
        ),],
      ),
    ),);
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem<MenuItem>(
        value: item,
        child: Row(
          children: [
            Icon(item.icon, color: Colors.black, size: 20),
            const SizedBox(width: 12),
            Text(item.text),
          ],
        ),
      );

  Future<void> onSelected(BuildContext context, MenuItem item) async {
    switch (item) {
      case MenuItems.itemContactUs:
        {
          final Uri _emailLaunchUri = Uri(
              scheme: 'mailto',
              path: 'appymanstudio@gmail.com',
              queryParameters: {'subject': ''});
          launch(_emailLaunchUri.toString());
        }
        break;
      case MenuItems.itemShare:
        {
          final urlPreview =
              'https://play.google.com/store/apps/details?id=com.danielowusuacquah.ICA';
          await Share.share(urlPreview);
        }
        break;
      case MenuItems.itemRateApp:
        {
          final url =
              'https://play.google.com/store/apps/details?id=com.danielowusuacquah.ICA';
          if (await canLaunch(url)) {
            await launch(url);
          }
        }
    }
  }
}
