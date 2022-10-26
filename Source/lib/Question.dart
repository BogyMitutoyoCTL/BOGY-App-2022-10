// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:learnhub/Answer.dart';
import 'package:learnhub/DataHelper/QuestionStack.dart';

import 'DataHelper/QuestionBasic.dart';
import 'DataHelper/QuestionStringAndAnswers.dart';
import 'DataHelper/QuestionStringAndFreeText.dart';
import 'DataHelper/QuestionTypes.dart';

class Question extends StatefulWidget {
  QuestionStack questionStack;
  int questionNumber;
  bool isMultipleChoice = false;
  Question(
      {Key? key, required this.questionStack, required this.questionNumber})
      : super(key: key) {}

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  final TextEditingController _inputControl = TextEditingController();
  String _input = "";
  @override
  void initState() {
    super.initState();

    State<Question> createState() => _QuestionState();
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
    String question = questionName();
    List<String> answers = ["", "", "", ""];
    if (widget.isMultipleChoice) {
      answers = getanswers();
    }
    return Scaffold(
        appBar: AppBar(title: Text(widget.questionStack.name)),
        body: ListView(
          children: [
            Column(children: [
              /*if (_questionType) Image.asset("assets/images/Logo.png"),*/
              Padding(padding: EdgeInsets.all(10)),
              Text(question, style: TextStyle(fontSize: 40)),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              if (!widget.isMultipleChoice)
                TextField(
                  controller: _inputControl,
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
                    onPressed: mcPressed, child: Icon(Icons.check)),
              if (widget.isMultipleChoice)
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Column(
                    children: [
                      SizedBox(
                          width: 166.0,
                          height: 100.0,
                          child: ElevatedButton(
                              onPressed: mcPressed, child: Text(answers[0]))),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      SizedBox(
                          width: 166.0,
                          height: 100.0,
                          child: ElevatedButton(
                              onPressed: mcPressed, child: Text(answers[2]))),
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
                              onPressed: mcPressed, child: Text(answers[1]))),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      SizedBox(
                          width: 166.0,
                          height: 100.0,
                          child: ElevatedButton(
                              onPressed: mcPressed, child: Text(answers[3]))),
                    ],
                  ),
                ]),
            ]),
          ],
        ));
  }

  void mcPressed() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => Answer(
                  questionStack: widget.questionStack,
                  questionNumber: widget.questionNumber,
                )),
        (route) => false);
  }

  String questionName() {
    QuestionBasic questionBasic =
        widget.questionStack.getQuestion(widget.questionNumber);
    if (questionBasic.questionType == QuestionTypes.stringAndAnswer) {
      widget.isMultipleChoice = true;
      QuestionStringAndAnswers questionStringAndAnswers =
          questionBasic as QuestionStringAndAnswers;
      return questionStringAndAnswers.question;
    } else if (questionBasic.questionType == QuestionTypes.stringAndFreeText) {
      widget.isMultipleChoice = false;
      QuestionStringAndFreeText questionStringAndFreeText =
          questionBasic as QuestionStringAndFreeText;
      return questionStringAndFreeText.question;
    } else {
      return "Ordne zu";
    }
  }

  List<String> getanswers() {
    QuestionBasic questionBasic =
        widget.questionStack.getQuestion(widget.questionNumber);
    QuestionStringAndAnswers questionStringAndAnswers =
        questionBasic as QuestionStringAndAnswers;
    List<String> answer = questionStringAndAnswers.answers;
    answer.shuffle();
    print(answer);
    return answer;
  }
}
