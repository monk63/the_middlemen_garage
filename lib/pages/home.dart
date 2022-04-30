import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_middlemen_garage/main.dart';
import 'package:the_middlemen_garage/pages/about_us_page.dart';
import 'package:the_middlemen_garage/pages/messages.dart';
import 'package:the_middlemen_garage/pages/profile.dart';
import '../model/user_model.dart';
import 'login_screen.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

_signOut() async {
  await _firebaseAuth.signOut();
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
  }

  bool homeColor = true;

  bool cartColor = false;

  bool aboutColor = false;

  bool contactUsColor = false;

  bool logOut = false;

  Widget _myDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 190, 61, 61)),
            accountName: Text(
              user!.displayName ?? "user name",
              style: const TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              user!.email!,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            selected: homeColor,
            onTap: () {
              setState(
                () {
                  homeColor = true;
                  cartColor = false;
                  aboutColor = false;
                  contactUsColor = false;
                  logOut = false;
                },
              );
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyStatefulWidget()),
              );
            },
            leading: const Icon(Icons.home),
            title: const Text("Home"),
          ),
          ListTile(
            selected: cartColor,
            onTap: () {
              setState(
                () {
                  cartColor = true;
                  homeColor = false;
                  aboutColor = false;
                  contactUsColor = false;
                  logOut = false;
                },
              );

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Messages()),
              );
            },
            leading: const Icon(Icons.message_outlined),
            title: const Text("Messages"),
          ),
          ListTile(
            selected: aboutColor,
            onTap: () {
              setState(
                () {
                  aboutColor = true;
                  homeColor = false;
                  cartColor = false;
                  contactUsColor = false;
                  logOut = false;
                },
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );
            },
            leading: const Icon(Icons.info),
            title: const Text("About"),
          ),
          ListTile(
            selected: contactUsColor,
            onTap: () {
              setState(
                () {
                  contactUsColor = true;
                  homeColor = false;
                  cartColor = false;
                  aboutColor = false;
                  logOut = false;
                },
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            },
            leading: const Icon(Icons.contact_page_outlined),
            title: const Text("Profile"),
          ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: const Text(
          "The Middlemen Garage",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.1,
        backgroundColor: Color.fromARGB(255, 182, 58, 58),
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {
            _key.currentState?.openDrawer();
          },
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              )),
        ],
        automaticallyImplyLeading: false,
      ),
      drawer: _myDrawer(),
    );
  }
}
