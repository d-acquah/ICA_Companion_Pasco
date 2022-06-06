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
                          MonthYear(name: "1.1 May 2021 Q3 A", link: "google.com"),
                          MonthYear(name: "1.1 Nov 2020 Q3 B", link: "google.com"),
                        ]
                      ),
                      Topic(
                        name: "Tangible Non-Current Asset", 
                        monthYear: [
                          MonthYear(name: "1.1 May 2021 Q3 A", link: "google.com"),
                          MonthYear(name: "1.1 Nov 2020 Q3 B", link: "google.com"),
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
