// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/constant.dart';
import 'package:notes_app/pages/note_update_page.dart';
import 'package:notes_app/pages/notes_add_page.dart';
import 'package:notes_app/providers/note_provider.dart';
import 'package:provider/provider.dart';

class NoteDisplayPage extends StatefulWidget {
  final int index;
  const NoteDisplayPage({Key? key, required this.index}) : super(key: key);

  @override
  _NoteDisplayPageState createState() => _NoteDisplayPageState();
}

class _NoteDisplayPageState extends State<NoteDisplayPage> {
  @override
  Widget build(BuildContext context) {
    var notes = context.watch<NoteData>().noteList[widget.index];
    return Scaffold(
      backgroundColor: Constants.backGroundColor,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 60,
                bottom: 20,
              ),
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: 60,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Constants.tabColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Constants.tabColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return NoteUpdatePage(
                                notes: notes,
                              );
                            },
                          ));
                        },
                        icon: Icon(
                          Icons.edit_note_rounded,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ),
            Text(
              notes.title!,
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              DateFormat.yMMMMd().format(notes.dateTime),
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              notes.desc!,
              style: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
