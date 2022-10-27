// ignore_for_file: unnecessary_import, prefer_const_constructors, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnhub/DataHelper/QuestionBasic.dart';
import 'package:learnhub/DataHelper/QuestionStringAndAnswers.dart';
import 'package:learnhub/DataHelper/QuestionStringAndFreeText.dart';
import 'package:learnhub/EditQuestion.dart';

import 'DataHelper/QuestionTypes.dart';
import 'package:http/http.dart';
import 'package:learnhub/DataHelper/DataHelper.dart';
import 'package:learnhub/DataHelper/QuestionStack.dart';
import 'package:learnhub/DataHelper/QuestionStringAndAnswers.dart';
import 'package:learnhub/DataHelper/QuestionStringAndFreeText.dart';
import 'package:learnhub/EditDeck.dart';
import 'package:learnhub/EditQuestion.dart';

import 'DataHelper/QuestionTypes.dart';

class TopicQuestion extends StatefulWidget {
  bool isMultipleChoice = false;
  QuestionBasic questionBasic;
  DataHelper datahelper;
  Function(QuestionBasic) changedCard;
  QuestionStack questionstack;
  TopicQuestion(
      {Key? key,
      required this.isMultipleChoice,
      required this.questionBasic,
      required this.changedCard,
      required this.datahelper,
      required this.questionstack})
      : super(key: key);

  @override
  State<TopicQuestion> createState() => _TopicQuestionState();
}

class _TopicQuestionState extends State<TopicQuestion> {
  String questionName() {
    if (widget.questionBasic.questionType == QuestionTypes.stringAndAnswers) {
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
    return Container(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            onPressed: editQuestion,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    questionName(),
                    overflow: TextOverflow.visible,
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                Icon(widget.isMultipleChoice
                    ? Icons.check_box_outline_blank
                    : Icons.abc),
                IconButton(
                  onPressed: Loeschen,
                  icon: Icon(Icons.delete_forever),
                )
              ],
            )),
      ),
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
    widget.questionstack.removeQuestion(widget.questionBasic);

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => EditDeck(
                  datahelper: widget.datahelper,
                  questionStack: widget.questionstack,
                )),
        (route) => false);
  }
}
