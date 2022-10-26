import 'package:flutter/material.dart';
import 'package:learnhub/EditQuestion.dart';
import 'package:learnhub/Home.dart';
import 'package:learnhub/ImageProcessing.dart';
import 'package:learnhub/Question.dart';
import 'package:learnhub/Score.dart';
import 'package:learnhub/Typing.dart';
import 'package:learnhub/multiplechoice.dart';
import 'WelcomePage.dart';
import 'package:learnhub/EditDeck.dart';

class LearnHubApp extends StatelessWidget {
  const LearnHubApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learnhub',
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          textStyle: TextStyle(fontSize: 30),
          padding: EdgeInsets.all(5),
        )),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.amber,
      ),
      home: const WelcomePage(),
    );
  }
}
