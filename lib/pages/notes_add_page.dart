import 'package:flutter/material.dart';
import 'package:notes_app/pages/home_page.dart';
import 'package:notes_app/repository/app_database.dart';

class NotesAddPage extends StatefulWidget {
  const NotesAddPage({Key? key}) : super(key: key);

  @override
  _NotesAddPageState createState() => _NotesAddPageState();
}

class _NotesAddPageState extends State<NotesAddPage> {
  var _titleController = TextEditingController();
  var _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> addNotes(String title, String desc) async {
    bool isNoteCreated = false;
    var db = AppDatabase.db;
    isNoteCreated = await db.addNotes(title: title, desc: desc);
    return isNoteCreated;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              var isCreated = await addNotes(_titleController.text.toString(),
                  _descController.text.toString());
              if (isCreated) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return HomePage();
                    },
                  ),
                );
              }
            },
            icon: Icon(Icons.arrow_back)),
        title: const Text('Add notes'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return HomePage();
                  },
                ),
              );
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  hintText: "Enter Title",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _descController,
              decoration: InputDecoration(
                  hintText: "Enter Description",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
          ],
        ),
      ),
    );
  }
}
