import 'package:flutter/material.dart';
import 'package:ica_companion_pasco/models/pasco_model.dart';
import 'package:ica_companion_pasco/widgets/trend_topics_list_tile.dart';

//import 'package:ica_companion_pasco/widgets/year_list_tile.dart';

class TrendTopicsPage extends StatefulWidget {
  TrendTopicsPage(
      {Key? key,
      required this.trend,
      required this.trendTopics,
      required this.name})
      : super(key: key);
  final List<dynamic> trendTopics;
  final String name;
  final Trend trend;

  @override
  State<TrendTopicsPage> createState() => _TrendTopicsPageState();
}

class _TrendTopicsPageState extends State<TrendTopicsPage> {


  @override
  void initState() {
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight:65,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          widget.trend.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
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
              itemCount: widget.trend.trendTopics.length,
              itemBuilder: (context, index) {
                return TrendTopicsListTile(
                 trendTopics: widget.trend.trendTopics[index],
                );
              })),
    );
  }
}
