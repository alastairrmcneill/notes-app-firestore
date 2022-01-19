import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_app_firebase/models/note_model.dart';
import 'package:notes_app_firebase/pages/create_note_screen.dart';
import 'package:notes_app_firebase/pages/edit_note_scren.dart';
import 'package:notes_app_firebase/services/database_service.dart';
import 'package:notes_app_firebase/widgets/note_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Transform.translate(
          offset: const Offset(8, 0),
          child: const Text(
            'Notes App',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 28,
            ),
          ),
        ),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateNoteScreen()));
        },
      ),
      body: StreamBuilder(
        stream: NotesDatabase.readAllNotes(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map(
              (DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                Note note = Note.fromJSON(data);

                return GestureDetector(
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditNoteScreen(
                          noteID: note.id!,
                        ),
                      ),
                    );
                  },
                  child: NoteTile(note),
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
