import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:the_middlemen_garage/pages/login_screen.dart';
import 'package:the_middlemen_garage/pages/messages.dart';
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
      navigateRoute: const LoginScreen(),
      duration: 4000,
      imageSize: 150,
      imageSrc: 'assets/images/splash.png',
      text: "The Middlemen Garage",
      textType: TextType.NormalText,
      textStyle: TextStyle(
        fontSize: 30.0,
      ),
      backgroundColor: Color.fromARGB(255, 68, 32, 32),
    );

    return MaterialApp(
      title: 'Splash screen Demo',
      home: example1,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'The Garage';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      initialRoute: '/',
      routes: {
        '/': (context) => const MyStatefulWidget(),
      },
    );
  }
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
    setState(() {
      currentIndex = index;
    });
  }
  // int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // static const List<Widget> _widgetOptions = <Widget>[
  //   HomeScreen(),
  //   Messages(),
  //   Profile(),

  // ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

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
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('The Middlemen Garage'),
    //     automaticallyImplyLeading: false,
    //     backgroundColor: Color.fromARGB(255, 179, 57, 57), // appbar color.
    //     foregroundColor: Colors.black, // appbar text color.
    //   ),
    //   body: Center(
    //     child: _widgetOptions.elementAt(_selectedIndex),
    //   ),
    //   bottomNavigationBar: BottomNavigationBar(
    //     items: const <BottomNavigationBarItem>[
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.home),
    //         label: 'Home',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.message),
    //         label: 'Messages',
    //       ),
    //        BottomNavigationBarItem(
    //         icon: Icon(Icons.contact_page),
    //         label: 'Profile',
    //       ),
    //     ],
    //     currentIndex: _selectedIndex,
    //     selectedItemColor: Color.fromARGB(255, 201, 61, 26),
    //     onTap: _onItemTapped,
    //   ),
    // );
  }
}
