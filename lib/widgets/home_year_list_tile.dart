import 'package:flutter/material.dart';
import 'package:ica_companion_pasco/models/pasco_model.dart';
import 'package:ica_companion_pasco/pdf_viewer.dart';

class HomeYearListTile extends StatelessWidget {
  final MonthYear monthYear;

  const HomeYearListTile({Key? key, required this.monthYear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        title: Text(monthYear.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal,color: Colors.black),
                ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return PDFViewer( monthYear: monthYear);
          }));
          // open the pdf link using url_launcher package (monthYear.link)
        },
      ),
      
      const Divider(
                indent: 0,
                thickness: 1.5,
                color: Colors.grey,
              ),
    ]);
  }
}
