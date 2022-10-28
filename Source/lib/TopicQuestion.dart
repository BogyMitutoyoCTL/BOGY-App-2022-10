// ignore_for_file: unnecessary_import, prefer_const_constructors, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnhub/DataHelper/QuestionBasic.dart';
import 'package:learnhub/DataHelper/QuestionStringAndAnswers.dart';
import 'package:learnhub/DataHelper/QuestionStringAndFreeText.dart';
import 'package:learnhub/EditQuestion.dart';

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
  String questionName() {
    if (widget.questionBasic.questionType == QuestionTypes.stringAndAnswers) {
      widget.isMultipleChoice = true;
      QuestionStringAndAnswers questionStringAndAnswers =
          widget.questionBasic as QuestionStringAndAnswers;
      return questionStringAndAnswers.question;
    } else if (widget.questionBasic.questionType ==
        QuestionTypes.stringAndFreeText) {
      widget.isMultipleChoice = false;
      QuestionStringAndFreeText questionStringAndFreeText =
          widget.questionBasic as QuestionStringAndFreeText;
      return questionStringAndFreeText.question;
    } else {
      return "no title";
    }
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
              Expanded(
                child: Text(
                  questionName(),
                  overflow: TextOverflow.visible,
                  style: TextStyle(fontSize: 17),
                ),
              ),
              if (widget.questionBasic.isMultipleChoiceQuestion)
                Icon(Icons.check_box_outlined),
              if (!widget.questionBasic.isMultipleChoiceQuestion)
                Icon(Icons.abc),
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
