import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnhub/TopicQuestion.dart';
import 'DataHelper/QuestionStack.dart';

class EditDeck extends StatefulWidget {
  QuestionStack questionStack;

  EditDeck(this.questionStack, {Key? key}) : super(key: key) {}

  @override
  State<EditDeck> createState() => _EditDeckState();
}

class _EditDeckState extends State<EditDeck> {
  final TextEditingController _titleController = TextEditingController();

  _EditDeckState() {
    _titleController.text = widget.questionStack.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Titel",
              ),
              controller: _titleController,
            ),
          ),
          const Text(
            "Karten:",
            style: TextStyle(fontSize: 30),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: widget.questionStack.getAmountOfQuestions(),
                itemBuilder: (BuildContext context, int index) {
                  return TopicQuestion(
                    isMultipleChoice: false,
                    questionBasic: widget.questionStack.getQuestion(index),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
