// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Typing extends StatefulWidget {
  const Typing({Key? key}) : super(key: key);

  @override
  State<Typing> createState() => _TypingState();
}

class _TypingState extends State<Typing> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
            onPressed: onPressed,
            child: Text(
              "Vokabeln",
              style: TextStyle(fontSize: 65),
            )),
        Icon(
          Icons.edit,
          size: 60,
        )
      ],
    );
  }

  void onPressed() {}
}
