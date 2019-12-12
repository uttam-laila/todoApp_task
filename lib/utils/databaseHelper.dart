import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/notes.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  String noteTable = 'noteTable';
  String id = 'id';
  String title = 'title';
  String description = 'description';
  String date = 'date';

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    var database = await openDatabase(path, version: 1, onCreate: _createDb);
    return database;
  }

  void _createDb(Database database, int newVersion) async {
    await database.execute(
        'CREATE TABLE $noteTable($id INTEGER PRIMARY KEY AUTOINCREMENT, $title TEXT, $description TEXT, $date TEXT)');
  }

  Future<List<Map<String, dynamic>>> getNotesMapList() async {
    Database db = await this.database;

    var result = await db.rawQuery('SELECT * FROM $noteTable');
    return result;
  }

  Future<int> insertNote(Notes notes) async {
    Database db = await this.database;

    var result = await db.insert(noteTable, notes.toMap());
    return result;
  }

  Future<int> updateNote(Notes notes) async {
    Database db = await this.database;

    var result = await db.update(noteTable, notes.toMap(),
        where: '$id = ?', whereArgs: [notes.id]);
    return result;
  }

  Future<int> deleteNote(int rowId) async {
    Database db = await this.database;

    var result =
        await db.rawDelete('DELETE FROM $noteTable WHERE $id = $rowId');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;

    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) FROM $noteTable');
    var result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Notes>> getNoteList() async {
    var noteToMap = await getNotesMapList();
    int length = noteToMap.length;

    List<Notes> noteList = List<Notes>();

    for (int i = 0; i < length; i++) {
      noteList.add(Notes.fromMapObject(noteToMap[i]));
    }
    return noteList;
  }
}
