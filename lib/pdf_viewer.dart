// @dart=2.11
import 'package:flutter/material.dart';
import 'package:ica_companion_pasco/models/pasco_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class PDFViewer extends StatelessWidget {
  final MonthYear monthYear;

  const PDFViewer({Key key, this.monthYear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
    body: SfPdfViewer.network(monthYear.link),
    ));
  }
}
