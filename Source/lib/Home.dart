// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:learnhub/DataHelper/DataHelper.dart';
import 'DataHelper/QuestionStack.dart';
import 'EditDeck.dart';
import 'Topic.dart';
import 'multiplechoice.dart';
import 'Typing.dart';

class Home extends StatelessWidget {
  DataHelper quizes = DataHelper();
  Home({Key? key}) : super(key: key) {
    quizes.loadDemoData();
  }
  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: addNewDeck)
          ],
          title: const Text(
            "Home",
            style: TextStyle(fontSize: 50),
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: quizes.amountOfQuestionStacks(),
                  itemBuilder: (BuildContext context, int index) {
                    QuestionStack questionStack =
                        quizes.getQuestionStack(index);
                    return Topic(
                      questionStack: questionStack,
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [],
            ),
          ],
        ),
      ),
    );
  }

  void addNewDeck() {
    //    Navigator.push(
    //     context,
    //       MaterialPageRoute(builder: (context) => EditDeck()),
  }
}
