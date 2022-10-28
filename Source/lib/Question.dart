// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learnhub/Answer.dart';
import 'package:learnhub/DataHelper/QuestionImageAndFreeText.dart';
import 'package:learnhub/DataHelper/QuestionImageAndSingleChoice.dart';

import 'DataHelper/CurrentlyPlaying.dart';
import 'DataHelper/DataHelper.dart';
import 'DataHelper/QuestionBasic.dart';
import 'DataHelper/QuestionStringAndAnswers.dart';
import 'DataHelper/QuestionStringAndFreeText.dart';
import 'DataHelper/QuestionTypes.dart';

class Question extends StatefulWidget {
  CurrentlyPlaying playing;
  bool isMultipleChoice = false;
  bool isPictureQuestion = false;

  DataHelper datahelper;

  Question({Key? key, required this.playing, required this.datahelper})
      : super(key: key);

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  List<String> answers = ["", "", "", ""];
  String question = "";
  final TextEditingController _inputControl = TextEditingController();
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
    question = questionName();

    if (widget.isMultipleChoice) {
      answers = getAnswers();
    }
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.playing.stack.name),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${widget.playing.questionIndex + 1}/${widget.playing.getMaxPoints()}",
                  style: TextStyle(fontSize: 30),
                ),
              )
            ],
          ),
          floatingActionButton: FAB(),
          body: ListView(
            children: [
              Column(children: [
                /*if (_questionType) Image.asset("assets/images/Logo.png"),*/
                if (!widget.isPictureQuestion)
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(question, style: TextStyle(fontSize: 40)),
                  ),
                if (widget.isPictureQuestion && !widget.isMultipleChoice)
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Image(
                        width: 250,
                        image: Image.memory(base64Decode((widget.playing.stack
                                        .getQuestion(
                                            widget.playing.questionIndex)
                                    as QuestionImageAndFreeText)
                                .imageString))
                            .image),
                  ),
                if (widget.isPictureQuestion && widget.isMultipleChoice)
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Image(
                        width: 250,
                        image: Image.memory(base64Decode((widget.playing.stack
                                        .getQuestion(
                                            widget.playing.questionIndex)
                                    as QuestionImageAndSingleChoice)
                                .imageString))
                            .image),
                  ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                if (!widget.isMultipleChoice)
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: _inputControl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Eingabe...",
                      ),
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
                            child: ElevatedButton(
                                onPressed: () {
                                  mcPressed(answers[0], 0);
                                },
                                child: Text(answers[0]))),
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        SizedBox(
                            width: 166.0,
                            height: 100.0,
                            child: ElevatedButton(
                                onPressed: () {
                                  mcPressed(answers[2], 2);
                                },
                                child: Text(answers[2]))),
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
                            child: ElevatedButton(
                                onPressed: () {
                                  mcPressed(answers[1], 1);
                                },
                                child: Text(answers[1]))),
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        SizedBox(
                            width: 166.0,
                            height: 100.0,
                            child: ElevatedButton(
                                onPressed: () {
                                  mcPressed(answers[3], 3);
                                },
                                child: Text(answers[3]))),
                      ],
                    ),
                  ]),
              ]),
            ],
          ),
        ));
  }

  void mcPressed(String input, int ID) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => Answer(
                  ID: ID,
                  datahelper: widget.datahelper,
                  question: question,
                  isMultipleChoice: widget.isMultipleChoice,
                  playing: widget.playing,
                  input: input,
                  answers: answers,
                )),
        (route) => false);
  }

  String questionName() {
    QuestionBasic questionBasic =
        widget.playing.stack.getQuestion(widget.playing.questionIndex);
    if (questionBasic.questionType == QuestionTypes.stringAndAnswers) {
      widget.isMultipleChoice = true;
      widget.isPictureQuestion = false;
      QuestionStringAndAnswers questionStringAndAnswers =
          questionBasic as QuestionStringAndAnswers;
      return questionStringAndAnswers.question;
    } else if (questionBasic.questionType == QuestionTypes.stringAndFreeText) {
      widget.isMultipleChoice = false;
      widget.isPictureQuestion = false;
      QuestionStringAndFreeText questionStringAndFreeText =
          questionBasic as QuestionStringAndFreeText;
      return questionStringAndFreeText.question;
    } else if (questionBasic.questionType == QuestionTypes.imageAndFreeText) {
      widget.isMultipleChoice = false;
      widget.isPictureQuestion = true;
      return "Ordne zu";
    } else {
      widget.isMultipleChoice = true;
      widget.isPictureQuestion = true;
      return "Ordne zu";
    }
  }

  Widget? FAB() {
    if (!widget.isMultipleChoice) {
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            child: Icon(Icons.check),
            onPressed: () {
              mcPressed(_input, 4);
            },
          ));
    } else {
      return null;
    }
  }

  List<String> getAnswers() {
    QuestionBasic questionBasic =
        widget.playing.stack.getQuestion(widget.playing.questionIndex);
    List<String> answer;
    if (questionBasic.isPictureQuestion) {
      QuestionImageAndSingleChoice questionImageAndSingleChoice =
          questionBasic as QuestionImageAndSingleChoice;
      answer = [...questionImageAndSingleChoice.answers];
    } else {
      QuestionStringAndAnswers questionStringAndAnswers =
          questionBasic as QuestionStringAndAnswers;
      answer = [...questionStringAndAnswers.answers];
    }
    answer.shuffle();
    return answer;
  }
}
