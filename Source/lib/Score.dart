import 'package:flutter/material.dart';

class Score extends StatefulWidget {
  const Score({Key? key}) : super(key: key);

  @override
  State<Score> createState() => _ScoreState();
}

class _ScoreState extends State<Score> {
  @override // Ich weiß nicht was das macht
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Name des Stapels"),
      ),
      body: Column(
        children: [
          Center(
            child: Text("Glückwunsch!",
              style: TextStyle(fontSize: 50),
            ),
          ),
          Image.asset("assets/images/Feuerwerk.png"),
          Text("Du hast x von y",
            style: TextStyle(fontSize: 50),
          ),
          Text("Punkte erreicht!",
            style: TextStyle(fontSize: 50),),
           ElevatedButton(onPressed: (){}, child: Text("Neues Spiel"),
           ),
           ],
      ),
    );
  }
}
