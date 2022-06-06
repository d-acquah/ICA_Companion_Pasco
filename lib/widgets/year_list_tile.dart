import 'package:flutter/material.dart';
import 'package:ica_companion_pasco/models/pasco_model.dart';

class YearListTile extends StatelessWidget {
  final MonthYear monthYear;

  const YearListTile({Key key, this.monthYear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        title: Text(monthYear.name),
        onTap: () {
          // open the pdf link using url_launcher package (monthYear.link)
        },
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
        height: 1,
        color: Colors.grey,
      )
    ]);
  }
}
