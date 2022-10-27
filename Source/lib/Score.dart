import 'package:flutter/material.dart';
import 'package:learnhub/DataHelper/CurrentlyPlaying.dart';
import 'package:learnhub/DataHelper/DataHelper.dart';
import 'package:learnhub/Home.dart';

class Score extends StatefulWidget {
  CurrentlyPlaying playing;

  DataHelper datahelper;

  Score({required this.playing, Key? key, required DataHelper this.datahelper})
      : super(key: key);

  @override
  State<Score> createState() => _ScoreState();
}

class _ScoreState extends State<Score> {
  @override
  Widget build(BuildContext context) {
    var score = widget.playing.correctAnswers;
    var numberOfQuestions = widget.playing.stack.getAmountOfQuestions();

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
                Image.asset("assets/images/PokalbeiScore.png"),
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
        MaterialPageRoute(
            builder: (context) => Home(datahelper: widget.datahelper)),
        (route) => false);
  }
}
