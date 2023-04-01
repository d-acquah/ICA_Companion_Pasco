import 'package:flutter/material.dart';
import 'package:ica_companion_pasco/models/pasco_model.dart';
import 'package:ica_companion_pasco/widgets/year_list_tile.dart';

class TopicsYearsPage extends StatelessWidget {
  TopicsYearsPage({Key? key, required this.monthYear, required this.title}) : super(key: key);
  final List<MonthYear> monthYear;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 55,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.blue,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
            ),
        ),
      ),
      body: SafeArea(
          child: ListView.builder(
              itemCount: monthYear.length,
              itemBuilder: (context, index) {
                return YearListTile(
                  monthYear: monthYear[index],
                );
              })),
    );
  }
}
