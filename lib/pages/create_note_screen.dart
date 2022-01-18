import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_firebase/models/note_model.dart';
import 'package:notes_app_firebase/services/database_service.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({Key? key}) : super(key: key);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<CreateNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: addNote, icon: Icon(Icons.check))],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 100,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  TextField(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                    maxLines: 1,
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'Title',
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Description',
                      ),
                      maxLines: 35,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future addNote() async {
    final Note note = Note(
      title: _titleController.text,
      body: _descriptionController.text,
      createdTime: Timestamp.fromDate(DateTime.now()),
    );

    NotesDatabase.addNote(note);
    Navigator.of(context).pop();
  }
}
