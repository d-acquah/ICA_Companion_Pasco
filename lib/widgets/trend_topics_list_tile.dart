import 'package:flutter/material.dart';
//import 'package:ica_companion_pasco/models/pasco_model.dart';
//import 'package:ica_companion_pasco/pdf_viewer.dart';

class TrendTopicsListTile extends StatelessWidget {
  final dynamic trendTopics;

  const TrendTopicsListTile({Key? key, required this.trendTopics}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        title: Text(trendTopics, style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal,color: Colors.black)
                ),
        onTap: () {
          
        },
      ),
      
      const Divider(
                indent: 0,
                thickness: 2,
              ),
    ]);
  }
}
