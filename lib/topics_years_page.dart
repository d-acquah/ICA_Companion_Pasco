// @dart=2.9
import 'package:ica_companion_pasco/home_year_page.dart';
import 'package:ica_companion_pasco/pasco_model.dart';
import 'package:flutter/material.dart';

class TopicsYearsPage extends StatelessWidget {
  TopicsYearsPage({Key key, this.subTopics}) : super(key: key);
  final ScrollController _scrollController = ScrollController();
  final SubTopics subTopics;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          subTopics.name,
          style: const TextStyle(
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
                  hintText: 'Search by year',
                  prefixIcon: const Icon(Icons.search)),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          controller: _scrollController,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomeYearView(
                      homeYear: HomeYear(
                    name: "",
                    // Open the pdf document
                  ));
                }));
              },
              title: const Text(
                'Nov 2012 Q1',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}