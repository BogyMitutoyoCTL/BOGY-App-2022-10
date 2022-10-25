import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Topic extends StatefulWidget {
  bool answerType;
  Topic({Key? key, required this.answerType}) : super(key: key) {
    print(answerType);
  }

  @override
  State<Topic> createState() => _TopicState(answerType);
}

class _TopicState extends State<Topic> {
  bool _answerType;

  _TopicState(this._answerType) {
    print("constructor state:${_answerType}");
  }
  //false = Benutzereingabe; true= Multiple Choice

  @override
  Widget build(BuildContext context) {
    print(_answerType);
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
                if (!_answerType) Icon(Icons.abc),
                if (_answerType) Icon(Icons.check_box_outline_blank),
                IconButton(onPressed: () {}, icon: Icon(Icons.edit))
              ],
            ),
          ],
        ));
  }
}
