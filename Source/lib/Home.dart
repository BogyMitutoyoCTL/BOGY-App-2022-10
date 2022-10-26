import 'package:flutter/material.dart';
import 'package:learnhub/EditDeck.dart';
import 'Topic.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key)
  //{Navigator.}
  ;
  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "          Quiz",
            style: TextStyle(fontSize: 50),
          ),
          IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditDeck()),
                );
              })
        ],
      )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Topic(
                      answerType: false,
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
}
