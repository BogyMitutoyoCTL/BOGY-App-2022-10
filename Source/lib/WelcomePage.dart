import 'package:flutter/material.dart';
import 'package:learnhub/Home.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

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
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
            child: (Text("Spielen")),
          )
        ],
      ),
    );
  }
}
