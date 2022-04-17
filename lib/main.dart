
import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/splash.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'API CMS';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      initialRoute: '/',
      routes: {
        '/': (context) => const MyStatefulWidget(),
       // '/update_con': (context) => const updateContact(),
       // '/view_con': (context) => const ViewContact()
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
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
  //   AddContact(),
  //  servicepage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) { 
    child:  MaterialApp(
       debugShowCheckedModeBanner: false,
      home: SplashScreen(),
     );
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Management System'),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 179, 57, 57), // appbar color.
        foregroundColor: Colors.black, // appbar text color.
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_page),
            label: 'Add Contact',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 201, 61, 26),
        onTap: _onItemTapped,
      ),
    );
  }
}
