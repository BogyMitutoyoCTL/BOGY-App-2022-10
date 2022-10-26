// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_import, file_names

import 'package:flutter/material.dart';
import 'package:learnhub/Answer.dart';
import 'package:learnhub/DataHelper/CurrentlyPlaying.dart';
import 'package:learnhub/Question.dart';
import 'package:learnhub/Score.dart';

import 'DataHelper/QuestionStack.dart';

class Answer extends StatefulWidget {
  CurrentlyPlaying playing;

  Answer({Key? key, required this.playing}) : super(key: key);

  @override
  State<Answer> createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  final TextEditingController _inputControl = TextEditingController();

  bool _isMultipleChoice = true;

  String _input = "";
  @override
  void initState() {
    super.initState();

    _inputControl.text = _input;
    _inputControl.addListener(() {
      setState(() {
        _input = _inputControl.text;
      });
    });
  }

  @override
  void dispose() {
    _inputControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.playing.stack.name)),
      body: ListView(
        children: [
          Column(
            children: [
              Image.asset("assets/images/Logo.png"),
              Padding(padding: EdgeInsets.all(10)),
              Text("Beantworte", style: TextStyle(fontSize: 40)),
              if (!_isMultipleChoice)
                TextField(
                  controller: _inputControl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Eingabe...",
                  ),
                ),
              if (_isMultipleChoice)
                Row(children: [
                  Padding(padding: EdgeInsets.all(10)),
                  SizedBox(
                      width: 166.0,
                      height: 100.0,
                      child: ElevatedButton(
                          onPressed: () {}, child: Text("A:________"))),
                  Padding(padding: EdgeInsets.all(10)),
                  SizedBox(
                      width: 166.0,
                      height: 100.0,
                      child: ElevatedButton(
                          onPressed: () {}, child: Text("B:________"))),
                ]),
              if (_isMultipleChoice) Padding(padding: EdgeInsets.all(10)),
              if (_isMultipleChoice)
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              width: 166.0,
                              height: 100.0,
                              child: ElevatedButton(
                                  onPressed: () {}, child: Text("C:________"))),
                          Padding(padding: EdgeInsets.all(10)),
                          SizedBox(
                              width: 166.0,
                              height: 100.0,
                              child: ElevatedButton(
                                  onPressed: () {}, child: Text("D:________"))),
                        ],
                      ),
                    ],
                  ),
                ),
              if ((widget.playing.questionIndex + 1) <
                  widget.playing.stack.getAmountOfQuestions())
                ElevatedButton(
                    onPressed: nextQuestion, child: Text("Zur nächsten Frage")),
              if ((widget.playing.questionIndex + 1) ==
                  widget.playing.stack.getAmountOfQuestions())
                ElevatedButton(
                    onPressed: showResult, child: Text("Ergebnis anzeigen")),
            ],
          ),
        ],
      ),
    );
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
