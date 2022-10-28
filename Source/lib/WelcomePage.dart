// ignore_for_file: prefer_const_constructors, empty_statements

import 'package:flutter/material.dart';
import 'package:learnhub/DataHelper/DataHelper.dart';
import 'package:learnhub/Home.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);

  DataHelper datahelper = DataHelper();

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

            /// Ein FutureBuilder zeigt etwas an während etwas läd.
            /// Wenn das etwas geladen hat, dann zeigt er etwas anderes an.
            /// Hier wird das benötigt, weil das Laden der Daten aus dem Speicher
            /// Zeit benötigt. Solange die Daten geladen werden, soll ein
            /// Ladekreis angezeigt werden. Erst danach soll der Button zum
            /// Spiel starten sichtbar sein.
            child: FutureBuilder<bool>(
              // Das ist die Methode, auf die gewartet wird
              future: widget.datahelper.load(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                // Hier wird gesagt, was wann angezeigt werden soll
                List<Widget> children;
                if (snapshot.hasData) {
                  // Wenn das Laden erfolgreich war -> Button zum Spielen
                  return ElevatedButton(
                    onPressed: play,
                    child: Text(
                      "Spielen",
                      style: TextStyle(fontSize: 50),
                    ),
                  );
                } else if (snapshot.hasError) {
                  // Wenn das Laden zu einem Fehler geführt hat
                  children = <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        'Fehler beim Laden der gespeicherten Daten:\n${snapshot.error}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ];
                } else {
                  // Solange gewartet wird -> Ladekreis
                  children = const <Widget>[
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Lade Daten...'),
                    ),
                  ];
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void play() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => Home(datahelper: widget.datahelper)),
        (route) => false);
  }
}
