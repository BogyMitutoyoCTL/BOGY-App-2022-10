// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_import, file_names

import 'package:flutter/material.dart';
import 'package:learnhub/Answer.dart';
import 'package:learnhub/DataHelper/CurrentlyPlaying.dart';
import 'package:learnhub/Question.dart';
import 'package:learnhub/Score.dart';

import 'DataHelper/DataHelper.dart';
import 'DataHelper/QuestionStack.dart';

class Answer extends StatefulWidget {
  CurrentlyPlaying playing;

  DataHelper datahelper;

  Answer({Key? key, required this.playing, required this.datahelper})
      : super(key: key);
  bool isMultipleChoice;
  String input;
  List<String> answers = [];
  String question;
  Answer(
      {Key? key,
      required this.playing,
      required this.answers,
      required this.input,
      required this.question,
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
              Text(widget.question, style: TextStyle(fontSize: 40)),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              if (!widget.isMultipleChoice)
                TextField(
                  enabled: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    //labelText: widget.input,
                  ),
                ),
              if (!widget.isMultipleChoice)
                Padding(
                  padding: EdgeInsets.all(10),
                ),
              if (widget.isMultipleChoice)
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Column(
                    children: [
                      SizedBox(
                          width: 166.0,
                          height: 100.0,
                          child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  border: Border.all(
                                    color: Colors.green,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Text(widget.answers[0],
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white)))),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      SizedBox(
                          width: 166.0,
                          height: 100.0,
                          child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(
                                    color: Colors.red,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Text(widget.answers[2],
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white)))),
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
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(
                                    color: Colors.red,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Text(widget.answers[1],
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white)))),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      SizedBox(
                          width: 166.0,
                          height: 100.0,
                          child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(
                                    color: Colors.red,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Text(widget.answers[3],
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                  )))),
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
                  datahelper: widget.datahelper,
                  playing: widget.playing,
                )),
        (route) => false);
  }

  void showResult() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => Score(
                  datahelper: widget.datahelper,
                  playing: widget.playing,
                )),
        (route) => false);
  }
}
