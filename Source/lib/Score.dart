import 'package:flutter/material.dart';
import 'package:learnhub/Home.dart';

import 'DataHelper/QuestionStack.dart';
import 'DataHelper/QuestionStack.dart';

class Score extends StatefulWidget {
  QuestionStack questionStack;

  Score(this.questionStack, {Key? key}) : super(key: key);

  @override
  State<Score> createState() => _ScoreState(questionStack);
}

class _ScoreState extends State<Score> {
  QuestionStack questionStack;
  _ScoreState(this.questionStack);

  @override
  Widget build(BuildContext context) {
    // TODO: durch echte Anzahl austauschen
    var score = 4;
    var numberOfQuestions = questionStack.getAmountOfQuestions();

    return Scaffold(
        appBar: AppBar(
          title: Text("Name des Stapels"),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Center(
                  child: Text(
                    "Glückwunsch!",
                    style: TextStyle(fontSize: 50),
                  ),
                ),
                Image.asset("assets/images/Pokal.png"),
                Text(
                  "Du hast $score von $numberOfQuestions",
                  style: TextStyle(fontSize: 50),
                ),
                Text(
                  "Punkte erreicht!",
                  style: TextStyle(fontSize: 50),
                ),
                Padding(
                  padding: const EdgeInsets.all(75),
                  child: ElevatedButton(
                    onPressed: play,
                    child: Text("Neues Spiel"),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  void play() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()), (route) => false);
  }
}
