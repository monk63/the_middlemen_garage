import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_middlemen_garage/Components/google_sign_in.dart';

import '../main.dart';

class GoogleSignIn extends StatefulWidget {
  const GoogleSignIn({ Key? key }) : super(key: key);

  @override
  State<GoogleSignIn> createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignIn> {
  // Firebase
  final _auth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isloading = false;


  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder(
     stream: FirebaseAuth.instance.authStateChanges(),
   
    builder: (context, snapshot) {
   
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return MyStatefulWidget();
            } else if (snapshot.hasError) {
              return Center(child: Text('Something is wrong!'));
            } else {
              return Scaffold(
                body: isloading
                 ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Form(   key: formkey,
                        child: AnnotatedRegion<SystemUiOverlayStyle>(
                          value: SystemUiOverlayStyle.light,
                          child: Stack(
                            children: [
                              Container(
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                 //Google sign in

                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 193, 204, 214),
                        onPrimary: Color.fromARGB(255, 238, 232, 232),
                        maximumSize: Size(double.infinity, 50),
                      ),
                      icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
                      label: Text('Sign Up with Google'),
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.googleLogin();
                      },
               
               
                    ),
                                    ]
                    ),
              )],),),), );
            }
    },
    ),
    );
  
  
}