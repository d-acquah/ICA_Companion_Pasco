
import 'package:flutter/material.dart';
import 'package:ica_companion_pasco/models/pasco_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class PDFViewer extends StatefulWidget {
  final MonthYear monthYear;

  const PDFViewer({Key? key, required this.monthYear}) : super(key: key);

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
           backgroundColor: Colors.blue,
          content: Text('Make sure you have internet connection'),
          duration: Duration(seconds: 4),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
    body: SfPdfViewer.network(widget.monthYear.link),
    ));
  }
}
