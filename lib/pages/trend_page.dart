// // @dart=2.9
//import 'package:ica_companion_pasco/home_year_page.dart';
// import 'package:ica_companion_pasco/pasco_model.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ica_companion_pasco/models/pasco_model.dart';
import 'package:ica_companion_pasco/trend_topics_page.dart';
import 'package:onepref/onepref.dart';

class TrendPage extends StatefulWidget {
  TrendPage({Key? key}) : super(key: key);

  @override
  State<TrendPage> createState() => _TrendPageState();
}

class _TrendPageState extends State<TrendPage> {
  IApEngine iApEngine = IApEngine();
  bool _isLoaded = true;
  final BannerAd myBanner = BannerAd(
      size: AdSize.banner,
      adUnitId: Platform.isAndroid
          ? "ca-app-pub-3940256099942544/6300978111"
          : "ca-app-pub-2530239307985191/4273991819",
      listener: BannerAdListener(),
      request: AdRequest());

  @override
  void initState() {
    super.initState();
    myBanner.load();
    restoreSub();

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
    return WillPopScope(
       onWillPop: () async {
        // Close the app without showing an ad
        SystemNavigator.pop();

        // Return true to indicate that the back button press is handled
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true, automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Trend Analysis',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
          ),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TrendTopicsPage(
                        trend: Trend(
                          name: "Financial Accounting",
                          trendTopics: [
                            "1. Introduction to Accounting",
                            "2. Tangible Non-Current Asset",
                            "3. Partnerships",
                            "4. Correction of Errors",
                            "5. The Qualitative Characteristics of Financial Information",
                            "6. Control Accounts",
                            "7. Interpretation of Financial Statements"
                          ],
                        ),
                        name: '',
                        trendTopics: [],
                      );
                    }));
                  },
                  title: const Text(
                    'Financial Accounting',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                ),
                const Divider(
                  indent: 0,
                  thickness: 2,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TrendTopicsPage(
                        trend: Trend(
                          name: "Business Management & Information System",
                          trendTopics: [
                            "1. The Information Systems & Information Technology",
                            "2. Marketing Management",
                            "3. Organisational Culture & Management Environment",
                            "4. Organisations & The Business Environment"
                          ],
                        ),
                        name: '',
                        trendTopics: [],
                      );
                    }));
                  },
                  title: const Text(
                    'Business Management & Information System',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                ),
                const Divider(
                  indent: 0,
                  thickness: 2,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TrendTopicsPage(
                        trend: Trend(
                          name: "Business & Corporate Law",
                          trendTopics: [
                            "1. Human Rights",
                            "2. Sale of Goods",
                            "3. Partnership Law",
                            "4. Employment Law",
                            "5. Contract Law",
                            "6. Company Law"
                          ],
                        ),
                        name: '',
                        trendTopics: [],
                      );
                    }));
                  },
                  title: const Text(
                    'Business & Corporate Law',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                ),
                const Divider(
                  indent: 0,
                  thickness: 2,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TrendTopicsPage(
                        trend: Trend(
                          name: "Introduction to Management Accounting",
                          trendTopics: [
                            "1. Budgeting",
                            "2. Standard Costing & Variance Analysis",
                            "3. Accounting for Inventory & Labour",
                            "4. Scope of Management Accounting",
                            "5. Cost-Volume-Profit Analysis",
                          ],
                        ),
                        name: '',
                        trendTopics: [],
                      );
                    }));
                  },
                  title: const Text(
                    'Introduction to Management Accounting',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TrendTopicsPage(
                        trend: Trend(
                          name: "Financial Reporting",
                          trendTopics: [
                            "1. Consolidated Financial Statements",
                            "2. Accounting Standards",
                            "3. Preparation of Financial Statements(Published Accounts)",
                            "4. Interpretation of Financial Statements",
                            "5. Ethical Framework/Conceptual & Regulatory Framework/Accounting Standards",
                          ],
                        ),
                        name: '',
                        trendTopics: [],
                      );
                    }));
                  },
                  title: const Text(
                    'Financial Reporting',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                ),
                const Divider(
                  indent: 0,
                  thickness: 2,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TrendTopicsPage(
                        trend: Trend(
                          name: "Management Accounting",
                          trendTopics: [
                            "1. Standard Costing & Variance Analysis",
                            "2. Models of Evaluation",
                            "3. Budgetary Control/Cash & Master Budgets",
                            "4. Discounted Cash Flow",
                           
                              ],
                        ),
                        name: '',
                        trendTopics: [],
                      );
                    }));
                  },
                  title: const Text(
                    'Management Accounting',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                ),
                const Divider(
                  indent: 0,
                  thickness: 2,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TrendTopicsPage(
                        trend: Trend(
                          name: "Audit & Assurance",
                          trendTopics: [
                            "1. Professional Ethics",
                            "2. Reporting",
                            "3. Audit Review & Finalisation",
                            "4. Risk Assessment",
                            "5. Audit Procedures & Sampling",
                            "6. Internal Audit",
                           
                              ],
                        ),
                        name: '',
                        trendTopics: [],
                      );
                    }));
                  },
                  title: const Text(
                    'Audit & Assurance',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                ),
                const Divider(
                  indent: 0,
                  thickness: 2,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TrendTopicsPage(
                        trend: Trend(
                          name: "Financial Management",
                          trendTopics: [
                            "1. Introduction to Financial Management",
                            "2. Simple Interest & Compound Interest",
                            "3. Foreign Currency Risk",
                            "4. Investment Appraisals",
                           
                              ],
                        ),
                        name: '',
                        trendTopics: [],
                      );
                    }));
                  },
                  title: const Text(
                    'Financial Management',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                ),
                const Divider(
                  indent: 0,
                  thickness: 2,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TrendTopicsPage(
                        trend: Trend(
                          name: "Public Sector Accounting & Finance",
                          trendTopics: [
                            "1. Accounting Policies for Cash & Accruals Based Accounting System  /  General Purpose Financial Reporting Framework",
                            "2. Preparation & Presentation of Financial Statements for Central Government, Covered Entities or Local Governments",
                            "3. Public Expenditure and Financial Accountability Framework  & Financial Statements Discussion & Analysis",
                            "4. Public Procurement & Public Sector Financial Initiatives",
                            "5. Public Sector Fiscal Planning & Budgeting & The Context of Public Financial Management in Ghana",
                           
                              ],
                        ),
                        name: '',
                        trendTopics: [],
                      );
                    }));
                  },
                  title: const Text(
                    'Public Sector Accounting & Finance',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Colors.black),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TrendTopicsPage(
                        trend: Trend(
                          name: "Principles of Taxation",
                          trendTopics: [
                            "1. Fiscal Policy, Tax Administration in Ghana & Ghana Tax System",
                            "2. Value Added Tax and Social Security & Pensions",
                            "3. Employment Income",
                            "4. Business Income - Corporate Tax",
                            "5. Withholding Tax and Gains on Realisation of Assets & Gift Tax",
                           
                              ],
                        ),
                        name: '',
                        trendTopics: [],
                      );
                    }));
                  },
                  title: const Text(
                    'Principles of Taxation',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                ),
                const Divider(
                  indent: 0,
                  thickness: 2,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TrendTopicsPage(
                        trend: Trend(
                          name: "Corporate Reporting",
                          trendTopics: [
                            "1. Group Financial Statements (Conso)",
                            "2. Accounting Standards",
                            "3. Professional and Ethical Duty of the Accountant  & Accounting Standards",
                            "4. Business Valuations  / Capital Reduction Schemes",
                            "5. Interpretation of Financial Statements",
                           
                              ],
                        ),
                        name: '',
                        trendTopics: [],
                      );
                    }));
                  },
                  title: const Text(
                    'Corporate Reporting',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                ),
                const Divider(
                  indent: 0,
                  thickness: 2,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TrendTopicsPage(
                        trend: Trend(
                          name: "Advanced Audit & Assurance",
                          trendTopics: [
                            "1. Evidence",
                            "2. Rules of Professional Conduct",
                            "3. Public Sector Audit",
                            "4. Planning",
                            "5. Reporting",
                            "6. Evaluation & Review",
                            "7. The Regulatory Environment", 
                              ],
                        ),
                        name: '',
                        trendTopics: [],
                      );
                    }));
                  },
                  title: const Text(
                    'Advanced Audit & Assurance',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                ),
                const Divider(
                  indent: 0,
                  thickness: 2,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TrendTopicsPage(
                        trend: Trend(
                          name: "Advanced Taxation",
                          trendTopics: [
                            "1. Tax Planning",
                            "2. Business Income",
                            "3. Tax Administration",
                            "4. Petroleum Operations",
                            "5. Minerals & Mining",
                            "6. International Taxation",

                              ],
                        ),
                        name: '',
                        trendTopics: [],
                      );
                    }));
                  },
                  title: const Text(
                    'Advanced Taxation',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                ),
                const Divider(
                  indent: 0,
                  thickness: 2,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TrendTopicsPage(
                        trend: Trend(
                          name: "Strategic Case Study",
                          trendTopics: [
                            "1. Strategy Implementation",
                            "2. Corporate Governance",
                            "3. Ethics",
                            "4. Methods of Development",
                            "5. Identifying & Assessing Risks / Controlling Risks",
                             
                              ],
                        ),
                        name: '',
                        trendTopics: [],
                      );
                    }));
                  },
                  title: const Text(
                    'Strategic Case Study',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                ),
                const Divider(
                  indent: 0,
                  thickness: 2,
                ),
                ListTile()
              ],
            ),
            Visibility(
            visible: _isLoaded && OnePref.getPremium() == false,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: _isLoaded
                      ? Container(
                  height: 50,
                  child: AdWidget(ad: myBanner),
                )
                    : Container(),
          ),
        ),
          ],
        ),
      ),
    );
  }
  
  void restoreSub() {
    iApEngine.inAppPurchase.restorePurchases();
  }
}
