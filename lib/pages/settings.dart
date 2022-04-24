import 'package:carbon_icons/carbon_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_middlemen_garage/pages/about_us_page.dart';
import 'login_screen.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

_signOut() async {
  await _firebaseAuth.signOut();
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      
      body: Container(
       
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.start,
    
          //Login out
          children: [
             
            ListTile(
                leading: const Icon(CarbonIcons.enterprise),
              title: const Text("About Us"),
              onTap: ()  {
                
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AboutUsPage()),
                  );
                }
              },
              
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Log out"),
              onTap: () async {
                await _signOut();
                if (_firebaseAuth.currentUser == null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
