// ignore_for_file: unused_local_variable, unnecessary_null_comparison, prefer_null_aware_operators, unused_element, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/models/user.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Fuser? _userfromfirebase(User? firebaseuser) {
    return firebaseuser != null ? Fuser(firebaseuser.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? firebaseuser = result.user;
      return _userfromfirebase(firebaseuser);
    } catch (e) {
      print(e);
    }
  }

  Future signUpWithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? firebaseuser = result.user;
      return _userfromfirebase(firebaseuser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetpass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> signout() async{
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
