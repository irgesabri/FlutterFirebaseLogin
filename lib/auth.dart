import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseUser = FirebaseAuth.instance;

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    FirebaseUser user = await _firebaseUser.signInWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    FirebaseUser user = await _firebaseUser.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  @override
  Future<String> currentUser() async {
    FirebaseUser user = await _firebaseUser.currentUser();
    return user.uid;
  }

  @override
  Future<void> signOut() async {
    return _firebaseUser.signOut();
  }
}
