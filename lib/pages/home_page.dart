import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notes_app/constant.dart';
import 'package:notes_app/model/notes.dart';
import 'package:notes_app/pages/note_display_page.dart';
import 'package:notes_app/pages/notes_add_page.dart';
import 'package:notes_app/providers/note_provider.dart';
import 'package:notes_app/repository/app_database.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
    await Provider.of<NoteData>(context, listen: false).fetchAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    final notes = context.watch<NoteData>().noteList;
    return notes.isEmpty
        ? Scaffold(
            backgroundColor: Constants.backGroundColor,
            floatingActionButton: FloatingActionButton(
                backgroundColor: Constants.backGroundColor,
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const NotesAddPage();
                      },
                    ),
                  );
                }),
            body: const Center(
                child: Text(
              'No Notes',
              style: TextStyle(
                color: Constants.textColor,
                fontSize: 30,
              ),
            )),
          )
        : Scaffold(
            backgroundColor: Constants.backGroundColor,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Constants.backGroundColor,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const NotesAddPage();
                    },
                  ),
                );
              },
              child: const Icon(
                Icons.add,
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 60,
                      bottom: 20,
                    ),
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Notes',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Constants.tabColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: notes.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return NoteDisplayPage(index: index);
                              },
                            ));
                          },
                          child: Stack(
                            children: [
                              GridTile(
                                footer: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 25, left: 20),
                                  child: Text(
                                    DateFormat.yMMMMd()
                                        .format(notes[index].dateTime),
                                    style: TextStyle(
                                      color: Constants.backGroundColor
                                          .withOpacity(0.3),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  height: 400,
                                  padding: const EdgeInsets.all(10),
                                  alignment: Alignment.topLeft,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        Constants.listColors[Random().nextInt(
                                      Constants.listColors.length,
                                    )],
                                  ),
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    notes[index].title.toString(),
                                    style: const TextStyle(
                                      fontSize: 30,
                                      color: Constants.backGroundColor,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor:
                                                Constants.backGroundColor,
                                            content: const Text(
                                              'Delete This Note!!!!',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  'No',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  context
                                                      .read<NoteData>()
                                                      .deleteNote(notes[index]
                                                          .note_id!);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'Yes',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.delete_forever_sharp,
                                      color: Constants.tabColor,
                                      size: 25,
                                    )),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
