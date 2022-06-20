import 'package:flutter/material.dart';
import 'package:ica_companion_pasco/models/pasco_model.dart';
import 'package:ica_companion_pasco/widgets/year_list_tile.dart';

class HomeYearPage extends StatelessWidget {
  HomeYearPage({Key key, this.homeYear, this.monthYear, this.name})
      : super(key: key);
  final ScrollController _scrollController = ScrollController();
  final List<MonthYear> monthYear;
  final String name;
  final HomeYear homeYear;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          homeYear.name,
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
          child: ListView.builder(
              itemCount: homeYear.monthYear.length,
              itemBuilder: (context, index) {
                return YearListTile(
                  monthYear: homeYear.monthYear[index],
                );
              })),
    );
  }
}
