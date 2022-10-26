// ignore_for_file: unnecessary_import, prefer_const_constructors, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnhub/DataHelper/QuestionBasic.dart';
import 'package:learnhub/EditQuestion.dart';
import 'package:learnhub/Score.dart';

import 'DataHelper/QuestionStack.dart';
import 'EditDeck.dart';
import 'Question.dart';

class TopicQuestion extends StatefulWidget {
  //false = Benutzereingabe; true= Multiple Choice
  bool isMultipleChoice = false;
  QuestionBasic questionBasic;

  TopicQuestion(
      {Key? key, required this.isMultipleChoice, required this.questionBasic})
      : super(key: key);

  @override
  State<TopicQuestion> createState() => _TopicQuestionState();
}

class _TopicQuestionState extends State<TopicQuestion> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => EditQuestion()),
              (route) => false);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Frage",
              style: TextStyle(fontSize: 30),
            ),
            if (!widget.isMultipleChoice) Icon(Icons.abc),
            if (widget.isMultipleChoice) Icon(Icons.check_box_outline_blank),
          ],
        ));
  }
}
