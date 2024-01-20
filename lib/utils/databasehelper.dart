import 'package:ica_companion_pasco/models/PdfDocument.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';  // Import the path package and alias it as 'path'

class DatabaseHelper {
  late Database _database;

  Future<void> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final dbPath = path.join(databasesPath, 'pdf_database.db');  // Use the 'path' alias

    _database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE pdf_documents(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            localPath TEXT
          )
        ''');
    });
  }

  Future<void> insertPdfDocument(PdfDocument document) async {
    await _database.insert('pdf_documents', document.toMap());
  }

  Future<List<PdfDocument>> getPdfDocuments() async {
    final List<Map<String, dynamic>> maps = await _database.query('pdf_documents');
    return List.generate(maps.length, (i) {
      return PdfDocument(
        id: maps[i]['id'],
        title: maps[i]['title'],
        localPath: maps[i]['localPath'],
      );
    });
  }
}
