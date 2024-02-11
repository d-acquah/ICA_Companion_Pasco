import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:ica_companion_pasco/models/PdfDocument.dart';

class PdfViewerScreen extends StatelessWidget {
  final PdfDocument pdfDocument;
  PdfViewerScreen({required this.pdfDocument});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight:65,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          pdfDocument.title,
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: PDFView(
        filePath: pdfDocument.localPath,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: false,
        pageSnap: true,
        pageFling: false,
        onRender: (pages) {
          // PDF document is rendered successfully
          print("Pages: $pages");
        },
        onError: (error) {
          // Handle any errors during PDF loading
          print("Error: $error");
        },
      ),
    );
  }
}
