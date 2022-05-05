/**
 * @author Michael Ofori
 */
//References : https://github.com/backslashflutter/email_password_flutter_firebase/tree/main/lib
//References : https://www.youtube.com/watch?v=1k-gITZA9CI&t=851s
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:the_middlemen_garage/model/user_model.dart';
import 'package:the_middlemen_garage/pages/login_screen.dart';
import 'package:the_middlemen_garage/pages/messages.dart';
import 'package:the_middlemen_garage/pages/onboarding.dart';
import 'package:the_middlemen_garage/pages/profile.dart';
import 'package:the_middlemen_garage/pages/settings.dart';
import 'package:the_middlemen_garage/pages/upload_cars.dart';
import 'pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Splash());
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget example1 = SplashScreenView(
      navigateRoute: const Onboarding(),
      duration: 4000,
      imageSize: 150,
      imageSrc: 'assets/images/splash.png',
      text: "The Middlemen",
      textType: TextType.NormalText,
      textStyle: TextStyle(
        color: Color.fromARGB(255, 42, 23, 207),
        fontSize: 30.0,
      ),
      backgroundColor: Color.fromARGB(255, 14, 13, 13),
    );

    return MaterialApp(
      title: 'Splash screen Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: example1,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'The Garage';
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: _title,
        theme: ThemeData(
          fontFamily: 'Roboto',
        ),
      );
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  List pages = [
    const HomeScreen(),
    //const Messages(),
    const Profile(),
  ];

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  bool homeColor = true;
  bool cartColor = false;
  bool aboutColor = false;
  bool contactUsColor = false;
  bool logOut = false;
  int currentIndex = 0;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  _signOut() async {
    await _firebaseAuth.signOut();
  }

  void onTap(int index) {
    setState(
      () {
        currentIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: [
        AppBar(
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
        //second app
        // AppBar(
        //   title: const Text(
        //     "The Middlemen Garage",
        //     style: TextStyle(color: Colors.black),
        //   ),
        //   centerTitle: true,
        //   elevation: 0.1,
        //   backgroundColor: Color.fromARGB(255, 182, 58, 58),
        //   leading: IconButton(
        //     icon: const Icon(
        //       Icons.menu,
        //       color: Colors.black,
        //     ),
        //     onPressed: () {
        //       _key.currentState?.openDrawer();
        //     },
        //   ),
        //   actions: <Widget>[
        //     IconButton(
        //         onPressed: () {},
        //         icon: const Icon(
        //           Icons.search,
        //           color: Colors.black,
        //         )),
        //   ],
        //   automaticallyImplyLeading: false,
        // ),
        //profile app
        AppBar(
          title: const Text("Profile"),
          // automaticallyImplyLeading: false,
          // centerTitle: true,\
          backgroundColor: Color.fromARGB(255, 182, 58, 58),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            )
          ],
        ),
      ][currentIndex],
      drawer: _myDrawer(),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        elevation: 0,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.message),
          //   label: 'Messages',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_sharp),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

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
          // ListTile(
          //   selected: cartColor,
          //   onTap: () {
          //     Navigator.pop(context);
          //     setState(
          //       () {
          //         currentIndex = 1;
          //         cartColor = true;
          //         homeColor = false;
          //         aboutColor = false;
          //         contactUsColor = false;
          //         logOut = false;
          //       },
          //     );
          //   },
          //   leading: const Icon(Icons.message_outlined),
          //   title: const Text("Messages"),
          // ),
          ListTile(
            selected: aboutColor,
            onTap: () {
              Navigator.pop(context);
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
                MaterialPageRoute(builder: (context) => uploadCars()),
              );
            },
            leading: const Icon(Icons.upload_rounded),
            title: const Text("Upload Cars"),
          ),
          // ListTile(
          //   selected: contactUsColor,
          //   onTap: () {
          //     setState(
          //       () {
          //         contactUsColor = true;
          //         homeColor = false;
          //         cartColor = false;
          //         aboutColor = false;
          //         logOut = false;
          //       },
          //     );
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => Profile()),
          //     );
          //   },
          //   leading: const Icon(Icons.contact_page_outlined),
          //   title: const Text("Profile"),
          // ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Log out"),
            onTap: () async {
              await _signOut();
              if (_firebaseAuth.currentUser == null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
