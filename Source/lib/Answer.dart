// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_import, file_names

import 'package:flutter/material.dart';
import 'package:learnhub/Answer.dart';
import 'package:learnhub/DataHelper/CurrentlyPlaying.dart';
import 'package:learnhub/Question.dart';
import 'package:learnhub/Score.dart';

import 'DataHelper/QuestionStack.dart';

class Answer extends StatefulWidget {
  CurrentlyPlaying playing;
  bool isMultipleChoice;
  String input;
  List<String> answers = [];
  Answer(
      {Key? key,
      required this.playing,
      required this.answers,
      required this.input,
      required this.isMultipleChoice})
      : super(key: key);

  @override
  State<Answer> createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.playing.stack.name)),
        body: ListView(
          children: [
            Column(children: [
              /*if (_questionType) Image.asset("assets/images/Logo.png"),*/
              Padding(padding: EdgeInsets.all(10)),
              Text("Frage", style: TextStyle(fontSize: 40)),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              if (!widget.isMultipleChoice)
                TextField(
                  enabled: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Eingabe...",
                  ),
                ),
              if (!widget.isMultipleChoice)
                Padding(
                  padding: EdgeInsets.all(10),
                ),
              if (!widget.isMultipleChoice)
                FloatingActionButton(
                    onPressed: () {}, child: Icon(Icons.check)),
              if (widget.isMultipleChoice)
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Column(
                    children: [
                      SizedBox(
                          width: 166.0,
                          height: 100.0,
                          child: Container(
                              color: Colors.green,
                              child: Text(widget.answers[0]))),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      SizedBox(
                          width: 166.0,
                          height: 100.0,
                          child: Container(
                              color: Colors.red,
                              child: Text(widget.answers[2]))),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Column(
                    children: [
                      SizedBox(
                          width: 166.0,
                          height: 100.0,
                          child: Container(
                              color: Colors.red,
                              child: Text(widget.answers[1]))),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      SizedBox(
                          width: 166.0,
                          height: 100.0,
                          child: Container(
                              color: Colors.red,
                              child: Text(widget.answers[3]))),
                    ],
                  ),
                ]),
              if ((widget.playing.questionIndex + 1) <
                  widget.playing.stack.getAmountOfQuestions())
                ElevatedButton(onPressed: nextQuestion, child: Text("Weiter")),
              if ((widget.playing.questionIndex + 1) ==
                  widget.playing.stack.getAmountOfQuestions())
                ElevatedButton(
                    onPressed: showResult, child: Text("Zum Ergebnis")),
            ]),
          ],
        ));
  }

  void nextQuestion() {
    widget.playing.questionIndex++;

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => Question(
                  playing: widget.playing,
                )),
        (route) => false);
  }

  void showResult() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => Score(
                  playing: widget.playing,
                )),
        (route) => false);
  }
}
