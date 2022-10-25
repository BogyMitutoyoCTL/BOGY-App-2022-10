import 'package:flutter/material.dart';
import 'multiplechoice.dart';
import 'Typing.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Quiz"),
          IconButton(
              icon: const Icon(Icons.add_circle_outline), onPressed: () {})
        ],
      )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Multiplechioce(),
            Typing(),
            Multiplechioce(),
            Multiplechioce(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    size: 100,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
