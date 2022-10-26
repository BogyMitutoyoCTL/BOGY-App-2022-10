// ignore_for_file: unnecessary_import, prefer_const_constructors, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnhub/EditQuestion.dart';
import 'package:learnhub/Score.dart';

import 'DataHelper/QuestionStack.dart';
import 'EditDeck.dart';
import 'Question.dart';

class Topic extends StatefulWidget {
  //false = Home; true= EditDeck
  bool isMultipleChoice = false;
  bool cannotEdit;
  QuestionStack questionStack;
  Topic(
      {Key? key,
      required this.isMultipleChoice,
      required this.cannotEdit,
      required this.questionStack})
      : super(key: key);

  @override
  State<Topic> createState() => _TopicState();
}

class _TopicState extends State<Topic> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: askOrEditQuestion,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.questionStack.name,
              style: TextStyle(fontSize: 30),
            ),
            Column(
              children: [
                if (!widget.isMultipleChoice && widget.cannotEdit)
                  Icon(Icons.abc),
                if (widget.isMultipleChoice)
                  Icon(Icons.check_box_outline_blank),
                if (!widget.cannotEdit)
                  IconButton(onPressed: editDeck, icon: Icon(Icons.edit))
              ],
            ),
          ],
        ));
  }

  void askOrEditQuestion() {
    if (widget.cannotEdit) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const EditQuestion()));
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const Question()),
          (route) => false);
    }
  }

  void editDeck() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditDeck(widget.questionStack)));
  }
}
