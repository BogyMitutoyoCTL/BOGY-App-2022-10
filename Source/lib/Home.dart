import 'package:flutter/material.dart';
import 'package:learnhub/EditDeck.dart';
import 'DataHelper/DataHelper.dart';
import 'DataHelper/QuestionStack.dart';
import 'Topic.dart';

class Home extends StatefulWidget {
  DataHelper datahelper;

  Home({Key? key, required DataHelper this.datahelper}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: addNewDeck,
              )
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
                    itemCount: widget.datahelper.amountOfQuestionStacks(),
                    itemBuilder: (BuildContext context, int index) {
                      QuestionStack questionStack =
                          widget.datahelper.getQuestionStack(index);
                      return Topic(
                        datahelper: widget.datahelper,
                        questionStack: questionStack,
                        index: index,
                        removeStack: () {
                          setState(() {
                            widget.datahelper.removeQuestionStack(index);
                          });
                        },
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
      ),
    );
  }

  void addNewDeck() {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => EditDeck(
                  datahelper: widget.datahelper,
                  questionStack: QuestionStack(""),
                )))
        .then((questionStack) {
      if (questionStack != null) {
        setState(() {
          widget.datahelper.addQuestionStack(questionStack);
        });
      }
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                //<-- SEE HERE
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                // <-- SEE HERE
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
