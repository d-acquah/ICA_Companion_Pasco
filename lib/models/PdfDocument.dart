class PdfDocument {
  int id;
  String title;
  String localPath;
  

  PdfDocument({
    required this.id,
    required this.title,
    required this.localPath,
  });

  // Convert PdfDocument to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'localPath': localPath,
    };
  }
}
