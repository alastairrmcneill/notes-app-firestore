import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app_firebase/models/note_model.dart';

class NotesDatabase {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create

  static Future<void> addNote(Note note) async {
    DocumentReference ref = _db.collection('Notes').doc();

    Note newNote = note.copy(id: ref.id);

    await ref
        .set(
          newNote.toJSON(),
        )
        .then((value) => print("Added item"))
        .catchError(
          (error) => print("Failed to add item: $error"),
        );
  }

  // Update
  static Future<void> updateNote(Note note) async {
    await _db
        .collection('Notes')
        .doc(note.id)
        .update(
          note.toJSON(),
        )
        .then((value) => print("Added item"))
        .catchError(
          (error) => print("Failed to add item: $error"),
        );
  }

  // Read one
  static Future<DocumentSnapshot<Object?>> readNote(String noteID) {
    return FirebaseFirestore.instance.collection('Notes').doc(noteID).get();
  }

  // Read all
  static Stream<QuerySnapshot<Map<String, dynamic>>> readAllNotes() {
    return FirebaseFirestore.instance.collection('Notes').snapshots();
  }

  // Delete
  static Future<void> deleteNote(String id) async {
    await _db
        .collection('Notes')
        .doc(
          id,
        )
        .delete()
        .then((value) => print("Added item"))
        .catchError(
          (error) => print("Failed to add item: $error"),
        );
  }
}
