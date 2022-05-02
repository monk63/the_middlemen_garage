//References : https://github.com/backslashflutter/email_password_flutter_firebase/tree/main/lib
//References : https://www.youtube.com/watch?v=1k-gITZA9CI&t=851s
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:the_middlemen_garage/pages/messages.dart';
import 'package:the_middlemen_garage/pages/onboarding.dart';
import 'package:the_middlemen_garage/pages/profile.dart';
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
  List pages = [
    const HomeScreen(),
    const Messages(),
    const Profile(),
  ];
  int currentIndex = 0;
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
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_sharp),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
