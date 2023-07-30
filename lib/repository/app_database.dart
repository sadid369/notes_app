import 'dart:io';

import 'package:notes_app/model/notes.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();
  static final AppDatabase db = AppDatabase._();
  Database? _database;
  static final NOTE_TABLE = "note";
  static final NOTE_COLOUM_ID = "note_id";
  static final NOTE_COLOUM_TITLE = "title";
  static final NOTE_COLOUM_DESC = "desc";
  var sqlCreateTable =
      "Create table $NOTE_TABLE ($NOTE_COLOUM_ID integer PRIMARY KEY autoincrement, $NOTE_COLOUM_TITLE text, $NOTE_COLOUM_DESC text)";

  Future<Database> getDB() async {
    if (_database != null) {
      return _database!;
    } else {
      return await initDB();
    }
  }

  Future<bool> addNotes({required String title, required String desc}) async {
    var db = await getDB();
    var rowsEffected =
        await db.insert(NOTE_TABLE, Notes(title: title, desc: desc).toMap());
    print(rowsEffected);
    if (rowsEffected > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Notes>> fetchAllNotes() async {
    List<Notes>? notes;

    var db = await getDB();
    var notesList = await db.query(NOTE_TABLE);

    notes = notesList.map((e) => Notes.fromMap(e)).toList();
    print(notes[0].toString());
    return notes;
  }

  Future<Database> initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    var dbPath = join(documentDirectory.path, "noteDB.db");
    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute(sqlCreateTable);
      },
    );
  }
}
