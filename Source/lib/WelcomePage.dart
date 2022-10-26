// ignore_for_file: prefer_const_constructors, empty_statements

import 'package:flutter/material.dart';
import 'package:learnhub/Home.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 201, 14),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
              child: Center(
                child: Text(
                  "Willkommen bei ",
                  style: TextStyle(
                    fontSize: 50,
                  ),
                ),
              )),
          Image.asset("assets/images/Logo.png"),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: ElevatedButton(
              onPressed: play,
              child: (Text(
                "Spielen",
                style: TextStyle(fontSize: 51),
              )),
            ),
          )
        ],
      ),
    );
  }

  void play() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()), (route) => false);
  }
}
