// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Multiplechioce extends StatefulWidget {
  const Multiplechioce({Key? key}) : super(key: key);

  @override
  State<Multiplechioce> createState() => _MultiplechioceState();
}

class _MultiplechioceState extends State<Multiplechioce> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
            onPressed: onPressed,
            child: Text(
              "Flaggen",
              style: TextStyle(fontSize: 65),
            )),
        Icon(
          Icons.check_box_outlined,
          size: 80,
        ),
      ],
    );
  }

  void onPressed() {}
}
