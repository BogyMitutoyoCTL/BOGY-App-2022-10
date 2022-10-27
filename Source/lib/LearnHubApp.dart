import 'package:flutter/material.dart';
import 'package:learnhub/DataHelper/QuestionStack.dart';
import 'package:learnhub/EditQuestion.dart';
import 'package:learnhub/Home.dart';
import 'package:learnhub/ImageProcessing.dart';
import 'package:learnhub/Question.dart';
import 'package:learnhub/Score.dart';
import 'WelcomePage.dart';

class LearnHubApp extends StatelessWidget {
  const LearnHubApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learnhub',
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          textStyle: TextStyle(fontSize: 30),
          padding: EdgeInsets.all(5),
        )),
        primarySwatch: Colors.amber,
      ),
      home: WelcomePage(),
    );
  }
}
