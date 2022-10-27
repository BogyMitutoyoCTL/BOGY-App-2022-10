import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnhub/DataHelper/DataHelper.dart';
import 'package:learnhub/Home.dart';
import 'package:learnhub/TopicQuestion.dart';
import 'DataHelper/QuestionBasic.dart';
import 'DataHelper/QuestionStack.dart';
import 'DataHelper/QuestionStringAndAnswers.dart';
import 'EditQuestion.dart';

class EditDeck extends StatefulWidget {
  QuestionStack questionStack;

  DataHelper datahelper;

  EditDeck({required this.datahelper, required this.questionStack, Key? key})
      : super(key: key);

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
        title: Text("Bearbeiten/Erstellen"),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: FloatingActionButton(
              heroTag: "add",
              onPressed: addQuestion,
              backgroundColor: Colors.amber,
              child: const Icon(Icons.add),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
                heroTag: "save",
                onPressed: saveStack,
                child: Icon(Icons.save_outlined)),
          )
        ],
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
                    changedCard: (QuestionBasic questionbasic) {
                      setState(() {
                        widget.questionStack
                            .replaceQuestion(index, questionbasic);
                      });
                    },
                    removeCard: () {
                      setState(() {
                        widget.questionStack.removeQuestionByIndex(index);
                      });
                    },
                    datahelper: widget.datahelper,
                    questionstack: widget.questionStack,
                  );
                }),
          ),
        ],
      ),
    );
  }

  void saveStack() {
    String titelStapel = _titleController.text;

    widget.questionStack.name = titelStapel;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => Home(datahelper: widget.datahelper)),
        (route) => false);
  }

  void addQuestion() {
    QuestionStringAndAnswers neuefrage =
        QuestionStringAndAnswers(question: "", answers: ["", "", "", ""]);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => EditQuestion(neuefrage)))
        .then((questionbasic) {
      setState(() {
        widget.questionStack.addQuestion(questionbasic);
      });
    });
  }
}
