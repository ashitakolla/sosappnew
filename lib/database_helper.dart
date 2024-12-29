// lib/database_helper.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize database
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, 'family_help.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE medications(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            time TEXT
          )
          ''',
        );
      },
      version: 1,
    );
  }

  // Insert medication
  Future<int> insertMedication(Map<String, String> medication) async {
    final db = await database;
    return await db.insert(
      'medications',
      medication,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all medications
  Future<List<Map<String, dynamic>>> getMedications() async {
    final db = await database;
    return await db.query('medications');
  }

  // Delete medication
  Future<int> deleteMedication(int id) async {
    final db = await database;
    return await db.delete('medications', where: 'id = ?', whereArgs: [id]);
  }
}
