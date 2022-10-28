import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learnhub/DataHelper/CurrentlyPlaying.dart';
import 'package:learnhub/DataHelper/DataHelper.dart';
import 'package:learnhub/Home.dart';

class Score extends StatefulWidget {
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  CurrentlyPlaying playing;

  DataHelper datahelper;

  Score({required this.playing, Key? key, required DataHelper this.datahelper})
      : super(key: key);

  @override
  State<Score> createState() => _ScoreState();
}

class _ScoreState extends State<Score> {
  @override
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  Widget build(BuildContext context) {
    int score = widget.playing.correctAnswers;

    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            appBar: AppBar(
              title: Text(widget.playing.stack.name),
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
                    Image.asset("assets/images/Pokal.png",
                        height: 300, width: 200, fit: BoxFit.fitWidth),
                    Text(
                      "Du hast $score von ${widget.playing.getMaxPoints()}",
                      style: TextStyle(fontSize: 50),
                    ),
                    Text(
                      "Punkten erreicht!",
                      style: TextStyle(fontSize: 50),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(75),
                      child: ElevatedButton(
                        onPressed: play,
                        child: Text("Zurück zum Menu"),
                      ),
                    ),
                  ],
                ),
              ],
            )));
  }

  void play() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => Home(datahelper: widget.datahelper)),
        (route) => false);
  }
}
