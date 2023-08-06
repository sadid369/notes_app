import 'package:flutter/foundation.dart';
import 'package:notes_app/model/notes.dart';
import 'package:notes_app/repository/app_database.dart';

class NoteData extends ChangeNotifier {
  var db = AppDatabase.db;
  List<Notes> _noteList = [];
  List<Notes> get noteList {
    return _noteList;
  }

  //Add notes to Sqflite Database & then fetch all data & add to provider list
  Future<bool> addNotes(String title, String desc) async {
    bool? isCreated;
    try {
      isCreated = await db.addNotes(title: title, desc: desc);
      await fetchAllNotes();
    } catch (e) {
      print(e.toString());
    }
    // notifyListeners();
    return isCreated!;
  }

  Future<void> fetchAllNotes() async {
    _noteList = await db.fetchAllNotes();
    notifyListeners();
  }

  Future<bool> deleteNote(int id) async {
    bool? isDelete;
    try {
      isDelete = await db.deleteNote(id);
      await fetchAllNotes();
    } catch (e) {
      print(e.toString());
    }
    return isDelete!;
  }
}
