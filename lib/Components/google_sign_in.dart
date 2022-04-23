

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<bool> googleLogin() async {
  GoogleSignIn google = GoogleSignIn();

  final GoogleSignInAccount? googleUser = await google.signIn();
  if (googleUser != null) {
    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential cred = await FirebaseAuth.instance.signInWithCredential(credential);
    
    return true;
  }
  return false;

}
