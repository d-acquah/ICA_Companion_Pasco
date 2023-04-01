import 'package:flutter/material.dart';
import 'package:ica_companion_pasco/models/pasco_model.dart';
import 'package:ica_companion_pasco/pdf_viewer.dart';

class YearListTile extends StatelessWidget {
  final MonthYear monthYear;

  const YearListTile({Key? key, required this.monthYear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        title: Text(monthYear.name),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PDFViewer(monthYear: monthYear);
          }));
          // open the pdf link using url_launcher package (monthYear.link)
        },
      ),
      const SizedBox(
        height: 10,
      ),
      const Divider(
        indent: 0,
        thickness: 2,
      ),
    ]);
  }
}
