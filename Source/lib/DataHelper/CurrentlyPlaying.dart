import 'dart:math';

import 'package:learnhub/DataHelper/QuestionStack.dart';

class CurrentlyPlaying {
  late QuestionStack stack;
  int questionIndex = 0;
  int correctAnswers = 0;
  int rundenanzahl = 20;
  
  CurrentlyPlaying(this.stack) {
    stack.orderList.shuffle();
    stack.questionStringAndAnswers.shuffle();
    stack.questionStringAndFreeText.shuffle();
    //TODO Workaround
  }

  int getMaxPoints(){
    int numberOfQuestions = stack.getAmountOfQuestions();
    int maxScore = min(numberOfQuestions, rundenanzahl);
    return maxScore;
  }
}
