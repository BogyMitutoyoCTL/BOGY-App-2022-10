// ignore_for_file: unnecessary_import, prefer_const_constructors, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DataHelper/QuestionStack.dart';
import 'EditDeck.dart';
import 'Question.dart';

class Topic extends StatefulWidget {
  QuestionStack questionStack;
  Topic({Key? key, required this.questionStack}) : super(key: key);

  @override
  State<Topic> createState() => _TopicState();
}

class _TopicState extends State<Topic> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: askQuestion,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.questionStack.name,
              style: TextStyle(fontSize: 30),
            ),
            IconButton(onPressed: editDeck, icon: Icon(Icons.edit))
          ],
        ));
  }

  void askQuestion() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => Question(
                  questionStack: widget.questionStack,
                  questionNumber: 0,
                )),
        (route) => false);
  }

  void editDeck() {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => EditDeck(widget.questionStack)))
        .then(refresh);
  }

  void refresh(value) {
    setState(() {});
  }
}
