// ignore_for_file: unnecessary_import, prefer_const_constructors, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnhub/DataHelper/QuestionBasic.dart';
import 'package:learnhub/DataHelper/QuestionStringAndAnswers.dart';
import 'package:learnhub/DataHelper/QuestionStringAndFreeText.dart';
import 'package:learnhub/EditQuestion.dart';
import 'package:learnhub/Score.dart';

import 'DataHelper/QuestionStack.dart';
import 'DataHelper/QuestionTypes.dart';
import 'EditDeck.dart';
import 'Question.dart';

class TopicQuestion extends StatefulWidget {
  //false = Benutzereingabe; true= Multiple Choice
  //false = Home; true= EditDeck
  bool answerType = false;
  QuestionBasic questionBasic;
  TopicQuestion(
      {Key? key, required this.answerType, required this.questionBasic})
      : super(key: key);

  @override
  State<TopicQuestion> createState() => _TopicQuestionState();
}

class _TopicQuestionState extends State<TopicQuestion> {
  String questionName() {
    if (widget.questionBasic.questionType == QuestionTypes.stringAndAnswer) {
      QuestionStringAndAnswers questionStringAndAnswers =
          widget.questionBasic as QuestionStringAndAnswers;
      return questionStringAndAnswers.question;
    } else if (widget.questionBasic.questionType ==
        QuestionTypes.stringAndFreeText) {
      QuestionStringAndFreeText questionStringAndFreeText =
          widget.questionBasic as QuestionStringAndFreeText;
      return questionStringAndFreeText.question;
    } else {
      return "no title";
    }
  }

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
              questionName(),
              style: TextStyle(fontSize: 30),
            ),
            if (!widget.answerType) Icon(Icons.abc),
            if (widget.answerType) Icon(Icons.check_box_outline_blank),
          ],
        ));
  }
}