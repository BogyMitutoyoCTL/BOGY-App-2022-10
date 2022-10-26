import 'package:learnhub/DataHelper/QuestionStack.dart';

class CurrentlyPlaying {
  late QuestionStack stack;
  int questionIndex = 0;
  int correctAnswers = 0;

  CurrentlyPlaying(this.stack);
}
