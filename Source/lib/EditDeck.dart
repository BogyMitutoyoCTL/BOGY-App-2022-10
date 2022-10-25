import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Topic.dart';

class EditDeck extends StatefulWidget {
  const EditDeck({Key? key}) : super(key: key);

  @override
  State<EditDeck> createState() => _EditDeckState();
}

class _EditDeckState extends State<EditDeck> {
  TextEditingController _titleControll = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stapel bearbeiten"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _titleControll,
          ),
          Text("Karten:"),
          for (int i = 0; i < 5; i++) Topic(answerType: true),
        ],
      ),
    );
  }
}
