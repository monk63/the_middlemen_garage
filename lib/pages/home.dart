import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_middlemen_garage/main.dart';
import 'package:the_middlemen_garage/pages/about_us_page.dart';
import 'package:the_middlemen_garage/pages/carItem.dart';
import 'package:the_middlemen_garage/pages/details.dart';
import 'package:the_middlemen_garage/pages/messages.dart';
import 'package:the_middlemen_garage/pages/profile.dart';
import 'package:the_middlemen_garage/pages/upload_cars.dart';
import '../model/user_model.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
        
            SizedBox(height: 10,),
            Text('Choose a Car'),
          
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, i) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: CarItem(
                    // carDetails: ve[i],
                    press: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => details(
                            // carDetails: carDetails[i],
                          )
                        )
                      );
                    },
                  ),
                ),
                // itemCount: carDetails.length,
                scrollDirection: Axis.horizontal,
            )
            ),
            Text('Top Delars'),
          ]
       )  
       );
  }
}
