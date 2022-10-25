import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Topic extends StatefulWidget {
  bool answerType;
  Topic({Key? key, required this.answerType}) : super(key: key) {
    print(answerType);
  }

  @override
  State<Topic> createState() => _TopicState();
}

class _TopicState extends State<Topic> {
  //false = Benutzereingabe; true= Multiple Choice

  @override
  Widget build(BuildContext context) {
    print(widget.answerType);
    return ElevatedButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Titel",
              style: TextStyle(fontSize: 30),
            ),
            Column(
              children: [
                if (!widget.answerType) Icon(Icons.abc),
                if (widget.answerType) Icon(Icons.check_box_outline_blank),
                IconButton(onPressed: () {}, icon: Icon(Icons.edit))
              ],
            ),
          ],
        ));
  }
}
