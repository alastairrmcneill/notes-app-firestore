import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_firebase/models/note_model.dart';
import 'package:notes_app_firebase/services/database_service.dart';

class EditNoteScreen extends StatefulWidget {
  final String noteID;

  const EditNoteScreen({Key? key, required this.noteID}) : super(key: key);

  @override
  _TestNoteState createState() => _TestNoteState();
}

class _TestNoteState extends State<EditNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Widget _buildPage(Map<String, dynamic> data) {
    _titleController.text = data['title'];
    _descriptionController.text = data['body'];
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              updateNote();
            },
            icon: const Icon(Icons.check),
          ),
          IconButton(
            onPressed: () {
              deleteNote();
            },
            icon: const Icon(
              Icons.delete,
            ),
          ),
        ],
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

  Widget _buildIssueScreen(String message) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 28,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: NotesDatabase.readNote(widget.noteID),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return _buildIssueScreen("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return _buildIssueScreen("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return _buildPage(data);
        }

        return _buildIssueScreen("loading");
      },
    );
  }

  Future updateNote() async {
    final Note note = Note(
      id: widget.noteID,
      title: _titleController.text,
      body: _descriptionController.text,
      createdTime: Timestamp.fromDate(DateTime.now()),
    );

    NotesDatabase.updateNote(note);
    Navigator.of(context).pop();
  }

  Future deleteNote() async {
    NotesDatabase.deleteNote(widget.noteID);
    Navigator.of(context).pop();
  }
}
