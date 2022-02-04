import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with email and password
  static Future signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      print(_auth.currentUser);
      return result;
    } on FirebaseAuthException catch (error) {
      return error;
    }
  }

  // Sign up with email and password

  static Future registerWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result;
    } on FirebaseAuthException catch (error) {
      return error;
    }
  }

  // Sign out
  static signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (error) {
      return error;
    }
  }
}
