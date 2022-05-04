import 'package:cloud_firestore/cloud_firestore.dart';
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
      child: StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
        stream: FirebaseFirestore.instance
        .collection('cars').snapshots(),
        builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );

            }else{

              
              List<DocumentSnapshot<Map<String,dynamic>>> docs =
                  snapshot.hasData ? snapshot.data!.docs : [];

       return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
        
            SizedBox(height: 10,),
            Text('Choose a Car'),
          
            Expanded(
              child: ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, i) => Padding(

                  padding: EdgeInsets.symmetric(horizontal: 15),
                  //car carousel
                  child: CarItem(
                    carDetails: VehicleUser.fromMap(docs[i].data()!),
                   
                  ),
                ),
                // itemCount: carDetails.length,
                // scrollDirection: Axis.horizontal,
            )
            ),
            Text('Top Delars'),
          ]
            
       ); 
            }
        }
      ),
       );
  }
}
