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
  Function removeStack;

  DataHelper datahelper;
  Topic(
      {Key? key,
      required this.questionStack,
      required this.index,
      required DataHelper this.datahelper,
      required this.removeStack})
      : super(key: key);

  @override
  State<Topic> createState() => _TopicState();
}

class _TopicState extends State<Topic> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
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
                icon: Icon(Icons.delete_forever),
              )
            ],
          )),
    );
  }

  void askQuestion() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => Question(
                  datahelper: widget.datahelper,
                  playing: CurrentlyPlaying(widget.questionStack),
                )),
        (route) => false);
  }

  void editDeck() {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => EditDeck(
                  datahelper: widget.datahelper,
                  questionStack: widget.questionStack,
                )))
        .then(refresh);
  }

  void refresh(value) {
    setState(() {});
  }

  void Loeschen() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Löschen?"),
          content: Text(
              "Diese Aktion löscht unwiderruflich den gesamten Stapel ${widget.questionStack.name}."),
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
                widget.removeStack();
              },
            ),
          ],
        );
      },
    );
  }
}
