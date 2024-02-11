import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ica_companion_pasco/models/PdfDocument.dart';
import 'package:ica_companion_pasco/pages/pdfviewerscreen.dart';
// Replace with the actual path to your PdfViewer screen
import 'package:path_provider/path_provider.dart';

class PdfListScreen extends StatefulWidget {
  @override
  _PdfListScreenState createState() => _PdfListScreenState();
}

class _PdfListScreenState extends State<PdfListScreen> {
  List<PdfDocument> pdfDocuments = [];

  @override
  void initState() {
    super.initState();
    _loadPdfDocuments();
  }

  Future<void> _loadPdfDocuments() async {
    try {
      // Replace with your logic to load PDF documents from storage
      final directory = await getApplicationDocumentsDirectory();
      final files = Directory(directory.path).listSync();

      pdfDocuments.clear(); // Clear existing documents (if any)

      for (var file in files) {
        if (file is File && file.path.endsWith('.pdf')) {
          pdfDocuments.add(PdfDocument(
            title: file.uri.pathSegments.last,
            localPath: file.path,
            id: 1,
          ));
        }
      }

      setState(() {}); // Update the UI with loaded documents
    } catch (e) {
      // Handle any errors during loading
      print('Error loading PDF documents: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight:65,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Downloads',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: ListView.separated(
        itemCount: pdfDocuments.length,
        separatorBuilder: (context, index) => Divider(
          indent: 0,
          thickness: 2,
        ), // Add a Divider between ListTiles
        itemBuilder: (context, index) {
          final pdfDocument = pdfDocuments[index];
          return ListTile(
            title: Text(pdfDocument.title),
            onTap: () {
              // Navigate to the PdfViewer screen with the selected PDF document
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PdfViewerScreen(pdfDocument: pdfDocument),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
