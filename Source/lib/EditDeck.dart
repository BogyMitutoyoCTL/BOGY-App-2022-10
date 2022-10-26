import 'package:flutter/material.dart';
import 'package:learnhub/TopicQuestion.dart';
import 'DataHelper/QuestionStack.dart';

class EditDeck extends StatefulWidget {
  QuestionStack questionStack;

  EditDeck(this.questionStack, {Key? key}) : super(key: key);

  @override
  State<EditDeck> createState() => _EditDeckState();
}

class _EditDeckState extends State<EditDeck> {
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.questionStack.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: saveStack, icon: Icon(Icons.check))],
        title: const Text("Title"),
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


  void saveStack() {
    String titelStapel =_titleController.text;
    setState(() {
      widget.questionStack.name = titelStapel;
    });

    Navigator.of(context).pop();

  }
}
