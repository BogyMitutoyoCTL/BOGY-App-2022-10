// ignore_for_file: unnecessary_import, prefer_const_constructors, must_be_immutable

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnhub/DataHelper/QuestionBasic.dart';
import 'package:learnhub/DataHelper/QuestionImageAndSingleChoice.dart';
import 'package:learnhub/DataHelper/QuestionStringAndAnswers.dart';
import 'package:learnhub/DataHelper/QuestionStringAndFreeText.dart';
import 'package:learnhub/EditQuestion.dart';

import 'DataHelper/QuestionImageAndFreeText.dart';
import 'DataHelper/QuestionTypes.dart';
import 'package:learnhub/DataHelper/DataHelper.dart';
import 'package:learnhub/DataHelper/QuestionStack.dart';

class TopicQuestion extends StatefulWidget {
  bool isMultipleChoice = false;
  QuestionBasic questionBasic;
  DataHelper datahelper;
  Function(QuestionBasic) changedCard;
  Function removeCard;
  QuestionStack questionstack;

  TopicQuestion(
      {Key? key,
      required this.questionBasic,
      required this.changedCard,
      required this.removeCard,
      required this.datahelper,
      required this.questionstack})
      : super(key: key);

  @override
  State<TopicQuestion> createState() => _TopicQuestionState();
}

class _TopicQuestionState extends State<TopicQuestion> {
  Widget questionName() {
    if (widget.questionBasic.questionType == QuestionTypes.stringAndAnswers) {
      widget.isMultipleChoice = true;
      QuestionStringAndAnswers questionStringAndAnswers =
          widget.questionBasic as QuestionStringAndAnswers;
      return Text(questionStringAndAnswers.question,
          overflow: TextOverflow.visible, style: TextStyle(fontSize: 17));
    } else if (widget.questionBasic.questionType ==
        QuestionTypes.stringAndFreeText) {
      widget.isMultipleChoice = false;
      QuestionStringAndFreeText questionStringAndFreeText =
          widget.questionBasic as QuestionStringAndFreeText;
      return Text(questionStringAndFreeText.question,
          overflow: TextOverflow.visible, style: TextStyle(fontSize: 17));
    } else if (widget.questionBasic.questionType ==
        QuestionTypes.imageAndFreeText) {
      return Image(
          height: 100,
          image: Image.memory(base64Decode(
                  (widget.questionBasic as QuestionImageAndFreeText)
                      .imageString))
              .image);
    } else if (widget.questionBasic.questionType ==
        QuestionTypes.imageAndSingleChoice) {
      return Image(
          height: 100,
          image: Image.memory(base64Decode(
                  (widget.questionBasic as QuestionImageAndSingleChoice)
                      .imageString))
              .image);
    } else {
      return Text("Dies sollten Sie nicht lesen");
    }
  }

  Image? imageload() {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: editQuestion,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: questionName()),
              if (widget.isMultipleChoice) Icon(Icons.check_box_outlined),
              if (!widget.isMultipleChoice) Icon(Icons.abc),
              IconButton(
                onPressed: Loeschen,
                icon: Icon(Icons.delete_forever),
              )
            ],
          )),
    );
  }

  void editQuestion() {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => EditQuestion(widget.questionBasic)))
        .then((rueckgabeFrage) {
      if (rueckgabeFrage != null) {
        widget.changedCard(rueckgabeFrage);
      }
    });
  }

  void Loeschen() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Löschen?"),
          content: Text("Diese Aktion löscht die Karte unwiderruflich."),
          actions: <Widget>[
            TextButton(
                child: Text('Abbrechen'),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            TextButton(
              child: Text('Bestätigen'),
              onPressed: () {
                Navigator.of(context).pop();
                widget.removeCard();
              },
            ),
          ],
        );
      },
    );
  }
}
