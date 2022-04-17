import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';

// Reference : https://github.com/AminullahTajMuhammad/login_ui_design/tree/master/lib

void main() {
  runApp(SplashScreen());
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 10);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 14, 67, 167),
                gradient: LinearGradient(
                    // ignore: prefer_const_literals_to_create_immutables
                    colors: [(Color.fromARGB(255, 184, 30, 19)), Color.fromARGB(255, 192, 22, 22)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
          ),
          Center(
            // ignore: avoid_unnecessary_containers
            child: Container(
              child: Image.asset("assets/images/splash.png"),
            ),
          )
        ],
      ),
    );
  }
}
