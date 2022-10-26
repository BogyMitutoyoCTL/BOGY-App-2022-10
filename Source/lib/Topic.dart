import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnhub/EditQuestion.dart';
import 'package:learnhub/Score.dart';

import 'DataHelper/QuestionStack.dart';
import 'EditDeck.dart';
import 'Question.dart';

class Topic extends StatefulWidget {
  //false = Benutzereingabe; true= Multiple Choice
  //false = Home; true= EditDeck
  bool answerType = false;
  bool comingFrom;
  QuestionStack questionStack;
  Topic(
      {Key? key,
      required this.answerType,
      required this.comingFrom,
      required this.questionStack})
      : super(key: key);

  @override
  State<Topic> createState() => _TopicState();
}

class _TopicState extends State<Topic> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (widget.comingFrom) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const EditQuestion()));
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Question()),
                (route) => false);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.questionStack.name,
              style: TextStyle(fontSize: 30),
            ),
            Column(
              children: [
                if (!widget.answerType && widget.comingFrom) Icon(Icons.abc),
                if (widget.answerType) Icon(Icons.check_box_outline_blank),
                if (!widget.comingFrom)
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditDeck()));
                      },
                      icon: Icon(Icons.edit))
              ],
            ),
          ],
        ));
  }
}
