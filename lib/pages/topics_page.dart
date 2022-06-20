import 'package:flutter/material.dart';
import 'package:ica_companion_pasco/models/pasco_model.dart';
import 'package:ica_companion_pasco/topic_subjects_page.dart';

class TopicsPage extends StatelessWidget {
  TopicsPage({Key key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Categorisation By Topics',
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hintText: 'Search by course or subject name',
                  prefixIcon: const Icon(Icons.search)),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          controller: _scrollController,
          children: [
            const SizedBox(
              height: 15,
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
                  return TopicsSubjectsPage(
                      topicsSubjects: TopicsSubjects(
                    name: 'Financial Accounting',
                    topics: [
                      Topic(
                        name: "Bank Reconciliation", 
                        monthYear: [
                           MonthYear(name: "May 2021 Q3 A", link: "https://mypascoblog.files.wordpress.com/2021/07/may-2021_1.1_financial_accounting.pdf"),
                           MonthYear(name: "Nov 2020 Q3 B", link: "https://mypascoblog.files.wordpress.com/2021/03/nov-2020-_1.1_financial_accounting.pdf"),
                           MonthYear(name: "May 2020 Q3", link: "https://mypascoblog.files.wordpress.com/2020/08/may-2020_1.1_financial_accounting.pdf"),
                           MonthYear(name: "Nov 2019 Q3", link: "https://mypascoblog.files.wordpress.com/2020/08/nov-2019-_1.1_financial_accounting-2.pdf"),
                           MonthYear(name: "May 2019 Q2 A & B", link: "https://mypascoblog.files.wordpress.com/2020/08/may_2019_1.1_financial_accounting-2.pdf"),
                           MonthYear(name: "Nov 2018 Q1 C", link: "https://mypascoblog.files.wordpress.com/2020/08/nov-2018-_1.1_financial_accounting-2.pdf"),
                           MonthYear(name: "May 2018 Q3 B", link: "https://mypascoblog.files.wordpress.com/2020/08/may-2018-_1.1_financial_accounting-2.pdf"),
                           MonthYear(name: "Nov 2017 Q3 B", link: "https://mypascoblog.files.wordpress.com/2020/08/nov-2017_1.1_financial_accounting-2.pdf"),
                           MonthYear(name: "May 2017 Q3", link: "https://mypascoblog.files.wordpress.com/2020/08/may-2017-_1.1_financial_accounting-2.pdf"),
                           MonthYear(name: "May 2016 Q3", link: "https://mypascoblog.files.wordpress.com/2020/08/may-2016_1.1_financial_accounting-2.pdf"),
                           MonthYear(name: "Nov 2015 Q1 D", link: "https://mypascoblog.files.wordpress.com/2020/08/nov-2015-_1.1_financial_accounting-2.pdf"),
                        ]
                      ),
                      Topic(
                        name: "Tangible Non-Current Asset", 
                        monthYear: [
                          MonthYear(name: "May 2021 Q1 B", link: ""),
                          MonthYear(name: "May 2020 Q1 B", link: ""),
                          MonthYear(name: "May 2019 Q4 B", link: ""),
                          MonthYear(name: "May 2019 Q3 B & C(IV)", link: ""),
                          MonthYear(name: "May 2018 Q2", link: ""),
                          MonthYear(name: "May 2017 Q4 C", link: ""),
                          MonthYear(name: "Nov 2016 Q1", link: ""),
                          MonthYear(name: "Nov 2015 Q7 A", link: ""),
                          MonthYear(name: "Nov 2015 Q1 A, B & C", link: ""),                          
                        ]
                      ),
                       Topic(
                        name: "The Regulatory Framework", 
                        monthYear: [
                          MonthYear(name: "Nov 2015 Q2 A", link: ""),                                                    
                        ]
                      ),
                       Topic(
                        name: "Not-for-Profit Entities", 
                        monthYear: [
                          MonthYear(name: "May 2021 Q5 B", link: ""),
                          MonthYear(name: "Nov 2017 Q6", link: ""),
                          MonthYear(name: "Nov 2016 Q5", link: ""),
                          MonthYear(name: "May 2016 Q6", link: ""),
                          MonthYear(name: "Nov 2015 Q2 B", link: ""),                                                    
                        ]
                      ),
                       Topic(
                        name: "Statement of Cash Flows", 
                        monthYear: [
                          MonthYear(name: "Nov 2020 Q5 C", link: ""),
                          MonthYear(name: "Nov 2018 Q2", link: ""),
                          MonthYear(name: "May 2018 Q4", link: ""),
                          MonthYear(name: "May 2017 Q5", link: ""),
                          MonthYear(name: "May 2016 Q4", link: ""),
                          MonthYear(name: "Nov 2015 Q3 A", link: ""),                                                 
                        ]
                      ),
                       Topic(
                        name: "Interpretation of Financial Statements", 
                        monthYear: [
                          MonthYear(name: "May 2021 Q5 A", link: ""),
                          MonthYear(name: "Nov 2020 Q5 A & B", link: ""),
                          MonthYear(name: "May 2020 Q5", link: ""),
                          MonthYear(name: "Nov 2019 Q5 A & B", link: ""),
                          MonthYear(name: "May 2019 Q7", link: ""),
                          MonthYear(name: "Nov 2018 Q6", link: ""),
                          MonthYear(name: "May 2018 Q6", link: ""),
                          MonthYear(name: "Nov 2017 Q4", link: ""),
                          MonthYear(name: "May 2017 Q6", link: ""),
                          MonthYear(name: "Nov 2016 Q7 B", link: ""),
                          MonthYear(name: "May 2016 Q5", link: ""),
                          MonthYear(name: "Nov 2015 Q3 B", link: ""),                          
                        ]
                      ),
                      Topic(
                        name: "Sources, Records & Books of Prime Entry", 
                        monthYear: [
                          MonthYear(name: "May 2021 Q3 B", link: ""),
                          MonthYear(name: "Nov 2017 Q5 A", link: ""),                                                                            
                        ]
                      ),
                      Topic(
                        name: "Ledger Accounts & Double Entry", 
                        monthYear: [
                          MonthYear(name: "Nov 2019 Q1 B", link: ""),                                                    
                        ]
                      ),
                    ]
                  ));
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
                  return TopicsSubjectsPage(
                      topicsSubjects: TopicsSubjects(
                    name: "",
                    topics: [],
                  ));
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
                  return TopicsSubjectsPage(
                      topicsSubjects: TopicsSubjects(
                    name: "",
                    topics: [],
                  ));
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
                  return TopicsSubjectsPage(
                      topicsSubjects: TopicsSubjects(
                    name: "",
                    topics: [],
                  ));
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
              height: 15,
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
                  return TopicsSubjectsPage(
                      topicsSubjects: TopicsSubjects(
                    name: "",
                    topics: [],
                  ));
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
                  return TopicsSubjectsPage(
                      topicsSubjects: TopicsSubjects(
                    name: "",
                    topics: [],
                  ));
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
                  return TopicsSubjectsPage(
                      topicsSubjects: TopicsSubjects(
                    name: "",
                    topics: [],
                  ));
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
                  return TopicsSubjectsPage(
                      topicsSubjects: TopicsSubjects(
                    name: "",
                    topics: [],
                  ));
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
                  return TopicsSubjectsPage(
                      topicsSubjects: TopicsSubjects(
                    name: "",
                    topics: [],
                  ));
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
                  return TopicsSubjectsPage(
                      topicsSubjects: TopicsSubjects(
                    name: "",
                    topics: [],
                  ));
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
              height: 15,
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
                  return TopicsSubjectsPage(
                      topicsSubjects: TopicsSubjects(
                    name: "",
                    topics: [],
                  ));
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
                  return TopicsSubjectsPage(
                       topicsSubjects: TopicsSubjects(
                    name: "",
                    topics: [],
                  ));
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
                  return TopicsSubjectsPage(
                      topicsSubjects: TopicsSubjects(
                    name: "",
                    topics: [],
                  ));
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
                  return TopicsSubjectsPage(
                      topicsSubjects: TopicsSubjects(
                    name: "",
                    topics: [],
                  ));
                }));
              },
              title: const Text(
                'Strategic Case Study',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
