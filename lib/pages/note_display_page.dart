// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:notes_app/pages/notes_add_page.dart';

class NoteDisplayPage extends StatefulWidget {
  final String title;
  final String desc;
  const NoteDisplayPage({
    Key? key,
    required this.title,
    required this.desc,
  }) : super(key: key);

  @override
  _NoteDisplayPageState createState() => _NoteDisplayPageState();
}

class _NoteDisplayPageState extends State<NoteDisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit,
            ),
          )
        ],
        title: const Text('Title'),
      ),
      body: Container(
        child: Column(
          children: [Text(widget.title), Text(widget.desc)],
        ),
      ),
    );
  }
}
