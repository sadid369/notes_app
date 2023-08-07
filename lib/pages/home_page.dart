import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notes_app/constant.dart';
import 'package:notes_app/model/notes.dart';
import 'package:notes_app/pages/note_display_page.dart';
import 'package:notes_app/pages/notes_add_page.dart';
import 'package:notes_app/providers/note_provider.dart';
import 'package:notes_app/repository/app_database.dart';
import 'package:notes_app/widgets/gridTile.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
                    child: GridView.custom(
                      gridDelegate: SliverStairedGridDelegate(
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        // startCrossAxisDirectionReversed: true,
                        pattern: [
                          StairedGridTile(0.5, 1),
                          StairedGridTile(0.5, 1),
                          StairedGridTile(1.0, 10 / 4),
                        ],
                      ),
                      childrenDelegate: SliverChildBuilderDelegate(
                        childCount: notes.length,
                        (context, index) =>
                            MyGridTile(notes: notes[index], index: index),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
