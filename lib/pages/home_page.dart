import 'package:flutter/material.dart';
import 'package:notes_app/model/notes.dart';
import 'package:notes_app/pages/note_display_page.dart';
import 'package:notes_app/pages/notes_add_page.dart';
import 'package:notes_app/repository/app_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Notes>? notes;
  @override
  void initState() {
    super.initState();
    // addNotes();
    getAllNotes();
  }

  void getAllNotes() async {
    var db = AppDatabase.db;
    notes = await db.fetchAllNotes();
    setState(() {});
  }

  // void addNotes() async {
  //   var db = AppDatabase.db;
  //   await db.addNotes(title: "Test TITLE", desc: "Test DESC");
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return notes == null
        ? Scaffold(
            floatingActionButton: FloatingActionButton(onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return NotesAddPage();
                  },
                ),
              );
            }),
            body: Center(child: Text('No Notes')),
          )
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return NotesAddPage();
                    },
                  ),
                );
              },
              child: Icon(
                Icons.add,
              ),
            ),
            appBar: AppBar(
              actions: [],
              title: const Text('All Notes'),
            ),
            body: Container(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: notes!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return NoteDisplayPage(
                              title: notes![index].title.toString(),
                              desc: notes![index].desc.toString());
                        },
                      ));
                    },
                    child: GridTile(
                      child: Container(
                        color: Colors.primaries[index],
                        child: Center(
                          child: Text(
                            notes![index].title.toString(),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}
