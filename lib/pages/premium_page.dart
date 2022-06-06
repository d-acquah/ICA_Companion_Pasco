// @dart=2.9
import 'package:ica_companion_pasco/home_year_page.dart';
import 'package:ica_companion_pasco/pasco_model.dart';
import 'package:flutter/material.dart';

class PremiumPage extends StatelessWidget {
  PremiumPage({Key key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'ICA Companion: Pasco',
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
                  return HomeYearView(
                      homeYear: HomeYear(
                    name: "",
                    monthYear: "",
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
                  return HomeYearView(
                      homeYear: HomeYear(
                    name: "",
                    monthYear: "",
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
                  return HomeYearView(
                      homeYear: HomeYear(
                    name: "",
                    monthYear: "",
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
                  return HomeYearView(
                      homeYear: HomeYear(
                    name: "",
                    monthYear: "",
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
                  return HomeYearView(
                      homeYear: HomeYear(
                    name: "",
                    monthYear: "",
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
                  return HomeYearView(
                      homeYear: HomeYear(
                    name: "",
                    monthYear: "",
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
                  return HomeYearView(
                      homeYear: HomeYear(
                    name: "",
                    monthYear: "",
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
                  return HomeYearView(
                      homeYear: HomeYear(
                    name: "",
                    monthYear: "",
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
                  return HomeYearView(
                      homeYear: HomeYear(
                    name: "",
                    monthYear: "",
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
                  return HomeYearView(
                      homeYear: HomeYear(
                    name: "",
                    monthYear: "",
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
                  return HomeYearView(
                      homeYear: HomeYear(
                    name: "",
                    monthYear: "",
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
                  return HomeYearView(
                      homeYear: HomeYear(
                    name: "",
                    monthYear: "",
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
                  return HomeYearView(
                      homeYear: HomeYear(
                    name: "",
                    monthYear: "",
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
                  return HomeYearView(
                      homeYear: HomeYear(
                    name: "",
                    monthYear: "",
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
