import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

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
            decoration: const BoxDecoration(color: Color(0xfff2f2f2)),
            accountName: Text(
              "Michael Odori",
              style: const TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              "michael@gmail.con",
              style: const TextStyle(color: Colors.black),
            ),
          ),
          ListTile(
            selected: homeColor,
            onTap: () {
              setState(() {
                homeColor = true;
                cartColor = false;
                aboutColor = false;
                contactUsColor = false;
                logOut = false;
              });
            },
            leading: const Icon(Icons.home),
            title: const Text("Home"),
          ),
          ListTile(
            selected: cartColor,
            onTap: () {
              setState(() {
                cartColor = true;
                homeColor = false;
                aboutColor = false;
                contactUsColor = false;
                logOut = false;
              });

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Update()),
              // );
            },
            leading: const Icon(Icons.account_circle_outlined),
            title: const Text("Update Info"),
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
              // Navigator.pushNamed(context, "/profile");
            },
            leading: const Icon(Icons.info),
            title: const Text("About"),
          ),
          ListTile(
            selected: contactUsColor,
            onTap: () {
              setState(() {
                contactUsColor = true;
                homeColor = false;
                cartColor = false;
                aboutColor = false;
                logOut = false;
              });
              Navigator.pushNamed(context, "/contactus");
            },
            leading: const Icon(Icons.phone),
            title: const Text("Contact"),
          ),
          ListTile(
            selected: logOut,
            onTap: () {
              setState(() {
                logOut = true;
                homeColor = false;
                cartColor = false;
                aboutColor = false;
                contactUsColor = false;
              });
              // Navigator.pushNamed(context, "/login");
            },
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_key,
      appBar: AppBar(
      title: const Text(
        "Rojo's Shop",
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      elevation: 0.1,
      backgroundColor: Colors.grey[100],
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
            onPressed: () {
              // showSearch(context: context, delegate: Search());
            },
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            )),
  
      ],
    ),
    drawer: _myDrawer(),
    );

  }
}
