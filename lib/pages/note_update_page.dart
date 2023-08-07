// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:notes_app/model/notes.dart';
import 'package:provider/provider.dart';

import 'package:notes_app/constant.dart';
import 'package:notes_app/providers/note_provider.dart';

class NoteUpdatePage extends StatefulWidget {
  final Notes notes;
  const NoteUpdatePage({
    Key? key,
    required this.notes,
  }) : super(key: key);

  @override
  _NoteUpdatePageState createState() => _NoteUpdatePageState();
}

class _NoteUpdatePageState extends State<NoteUpdatePage> {
  var _titleController = TextEditingController();
  var _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.notes.title!;
    _descController.text = widget.notes.desc!;
  }

  Future<bool> updateNotes(Notes note) async {
    print('Called');
    bool isUpdated =
        await Provider.of<NoteData>(context, listen: false).updateNote(note);
    return isUpdated;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backGroundColor,
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
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
                      padding: const EdgeInsets.all(10),
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
                    child: TextButton(
                      onPressed: () async {
                        if (_titleController.text.isNotEmpty &&
                            _descController.text.isNotEmpty) {
                          var isCreatd = await updateNotes(
                            Notes(
                                title: _titleController.text.toString(),
                                desc: _descController.text.toString(),
                                note_id: widget.notes.note_id),
                          );

                          if (isCreatd) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Constants.backGroundColor,
                                  content: const Text(
                                    'Note Updated',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Ok',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                      child: const Text(
                        'Update',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              cursorColor: Constants.textColor,
              cursorWidth: 4,
              style: const TextStyle(
                fontSize: 35,
                color: Constants.textColor,
              ),
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: "Title",
                hintStyle: TextStyle(
                  color: Constants.textColor,
                  fontSize: 35,
                ),
                border: InputBorder.none,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              maxLines: 5,
              cursorColor: Constants.textColor,
              cursorWidth: 4,
              style: const TextStyle(
                fontSize: 35,
                color: Constants.textColor,
              ),
              controller: _descController,
              decoration: const InputDecoration(
                hintText: "Type Something....",
                hintStyle: TextStyle(
                  color: Constants.textColor,
                  fontSize: 20,
                ),
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
