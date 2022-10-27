// ignore_for_file: unnecessary_import, prefer_const_constructors, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnhub/DataHelper/CurrentlyPlaying.dart';
import 'package:learnhub/DataHelper/DataHelper.dart';

import 'DataHelper/QuestionStack.dart';
import 'EditDeck.dart';
import 'Question.dart';

class Topic extends StatefulWidget {
  QuestionStack questionStack;
  int index;
  Topic({Key? key, required this.questionStack, required this.index})
      : super(key: key);

  @override
  State<Topic> createState() => _TopicState();
}

class _TopicState extends State<Topic> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: askQuestion,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                widget.questionStack.name,
                style: TextStyle(fontSize: 17),
              ),
            ),
            IconButton(onPressed: editDeck, icon: Icon(Icons.edit)),
            IconButton(
              onPressed: Loeschen,
              icon: Icon(Icons.delete),
            )
          ],
        ));
  }

  void askQuestion() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => Question(
                  playing: CurrentlyPlaying(widget.questionStack),
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

  void Loeschen() {
    setState(() {
      DataHelper dataHelper = DataHelper();
      dataHelper.removeQuestionStack(widget.index);
    });
  }
}
//TODO
