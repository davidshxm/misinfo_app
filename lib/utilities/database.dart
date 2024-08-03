import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';  // Make sure this import is present
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<Database> initializeDB() async {
    // Get the application documents directory
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "data.db");

    // Check if the database already exists
    if (!await File(path).exists()) {
      // Copy the database from assets if it doesn't exist
      ByteData data = await rootBundle.load(join('assets', 'data.db'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }

    // Open the database
    return openDatabase(path);
  }

  static Future<List<String>> fetchData() async {
    final db = await initializeDB();
    // Replace 'YourTableName' and 'columnName' with actual table and column names
    final List<Map<String, dynamic>> queryResult = await db.query('YourTableName');
    return queryResult.map((e) => e['columnName'].toString()).toList();
  }
}
