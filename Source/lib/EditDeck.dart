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
  bool _validate = false;
  QuestionStack questionStack;

  DataHelper datahelper;

  EditDeck({required this.datahelper, required this.questionStack, Key? key})
      : super(key: key);

  @override
  State<EditDeck> createState() => _EditDeckState();
}

class _EditDeckState extends State<EditDeck> {
  bool _validate = false;
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.questionStack.name;
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: new Text('Achtung!'),
            content: new Text(
                'Willst du deine bisherigen Änderungen wirklich verwerfen?'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: new Text('Nein'),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(true), // <-- SEE HERE
                child: new Text('Ja'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Bearbeiten/Erstellen", style: TextStyle(fontSize: 30)),
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
                  maxLength: 35,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Titel",
                    errorText: _validate ? "Titel muss gesetzt werden" : null,
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
        ));
  }

  void saveStack() {
    setState(() {
      _titleController.text.replaceAll(" ", "").isEmpty
          ? _validate = true
          : _validate = false;
    });
    widget.questionStack.name = _titleController.text;
    if (widget.questionStack.getAmountOfQuestions() == 0) return;
    if (widget.questionStack.name.replaceAll(" ", "").isEmpty) return;

    widget.datahelper.addQuestionStack(widget.questionStack);
    widget.datahelper.save();

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
