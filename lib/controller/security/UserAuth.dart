import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> userAuth(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

}