// Run `flutter pub run build_runner build --delete-conflicting-outputs`
// Run `flutter pub run build_runner watch --delete-conflicting-outputs`
// to continuously and automatically (re)build on changes.
// if you run into trouble with *.g.dart files. See
// https://docs.flutter.dev/development/data-and-backend/json#one-time-code-generation
// for help.

import 'package:learnhub/DataHelper/QuestionTypes.dart';

import 'DataStructure.dart';

/// The DataHelper take care of the different question stacks.
/// You can add, remove and get a QuestionStack.
/// The DataHelper is also the one what saves and read the
/// QuestionStacks from file.
class DataHelper {
  // ignore: prefer_final_fields
  List<QuestionStack> _myQuestionStacks;

  DataHelper({List<QuestionStack>? myQuestionStacks})
      : _myQuestionStacks = myQuestionStacks ?? [];

  List<QuestionStack> get myQuestionStacks => _myQuestionStacks;

  /// This adds a new QuestionStack. Returns the index of the newly added Stack.
  /// It always adds the new Stack to the end.
  int addQuestionStack(QuestionStack newQuestionStack) {
    _myQuestionStacks.add(newQuestionStack);
    return _myQuestionStacks.length - 1;
  }

  /// Returns the QuestionStack by index. Throws an error if index doesn't exists.
  QuestionStack getQuestionStack(int index) {
    return _myQuestionStacks[index];
  }

  /// Removes one QuestionStack by index. Throws an error if index doesn't exists.
  void removeQuestionStack(int index) {
    _myQuestionStacks.removeAt(index);
  }

  /// Returns the amount of the QuestionStacks
  int amountOfQuestionStacks() {
    return _myQuestionStacks.length;
  }

  @override
  String toString() {
    String msg = "DataHelper: Contains ${_myQuestionStacks.length} Stacks.";
    for (QuestionStack value in _myQuestionStacks) {
      msg += "\n${value.toString()}";
    }
    return msg;
  }
}

/// This is an example of how to use this DataHelper
void main() {
  DataHelper dataHelper = DataHelper();

  print(dataHelper);

  QuestionStack questionStack = QuestionStack("Erster Stack");
  dataHelper.addQuestionStack(questionStack);
  print(dataHelper);

  QuestionStack questionStack2 = QuestionStack("Zweiter Stack");
  dataHelper.addQuestionStack(questionStack2);
  print(dataHelper);

  dataHelper.getQuestionStack(0).addQuestionStringAndFreeText(
      QuestionStringAndFreeText(question: "Frage?", answer: "Antwort"));
  dataHelper.getQuestionStack(0).addQuestionStringAndAnswers(
      QuestionStringAndAnswers(question: "Frage2?", answers: ["8", "3", "4"]));
  print(dataHelper);

  QuestionStringAndFreeText question = dataHelper
      .getQuestionStack(0)
      .getQuestion(0) as QuestionStringAndFreeText;
  print("Die Frage: ${question.question}");
  print(question.isAnswerCorrect("Antwort"));
}
