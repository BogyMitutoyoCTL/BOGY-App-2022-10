import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
            child: SizedBox(
              height: 75,
              width: 150,
              child: ElevatedButton(
                onPressed: () {},
                child: (Text("Spielen", style: TextStyle(fontSize: 30))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
