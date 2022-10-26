import 'package:flutter/material.dart';
import 'package:learnhub/Home.dart';

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
    var ErreichtePunkte = 4;
    var AnzahlFragen = questionStack.getAmountOfQuestions();

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
                Image.asset("assets/images/Feuerwerk.png"),
                Text(
                  "Du hast $ErreichtePunkte von $AnzahlFragen",
                  style: TextStyle(fontSize: 50),
                ),
                Text(
                  "Punkte erreicht!",
                  style: TextStyle(fontSize: 50),
                ),
                Padding(
                  padding: const EdgeInsets.all(75),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Home()),
                          (route) => false);
                    },
                    child: Text("Neues Spiel"),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
