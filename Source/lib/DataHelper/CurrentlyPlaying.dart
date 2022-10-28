import 'dart:math';

import 'package:learnhub/DataHelper/QuestionBasic.dart';
import 'package:learnhub/DataHelper/QuestionStack.dart';

class CurrentlyPlaying {
  late QuestionStack stack;
  int questionIndex = 0;
  int correctAnswers = 0;
  int maxQuestions = 20;

  CurrentlyPlaying(this.stack) {
    stack.orderList.shuffle();
    stack.questionStringAndAnswers.shuffle();
    stack.questionStringAndFreeText.shuffle();
    //TODO Workaround
  }

  QuestionBasic getActQuestion() {
    if (stack.orderList.length > questionIndex) {
      return stack.getQuestion(questionIndex);
    }
    throw Exception("Can't get Act question");
  }

  int getMaxPoints() {
    int numberOfQuestions = stack.getAmountOfQuestions();
    int maxScore = min(numberOfQuestions, maxQuestions);
    return maxScore;
  }
}
