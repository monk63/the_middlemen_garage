import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_middlemen_garage/Components/google_sign_in.dart';

import '../main.dart';

class GoogleSignIn extends StatefulWidget {
  const GoogleSignIn({Key? key}) : super(key: key);

  @override
  State<GoogleSignIn> createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignIn> {

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(
            255, 193, 204, 214),
        onPrimary: Color.fromARGB(
            255, 238, 232, 232),
        maximumSize:
            Size(double.infinity, 50),
      ),
      icon: FaIcon(FontAwesomeIcons.google,
          color: Colors.red),
      label: Text('Sign Up with Google'),
      onPressed: () async {
        googleLogin().then((value){
          if (value) {// if the sign in was successful
          Navigator.pushReplacement( context, MaterialPageRoute(builder: (context)=> MyStatefulWidget()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("We couldn't sign you in")));
          }
        });
      },
    );
  }
}
