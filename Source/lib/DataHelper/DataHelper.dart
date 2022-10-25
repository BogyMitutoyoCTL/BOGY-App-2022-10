// Run `flutter pub run build_runner build --delete-conflicting-outputs`
// if you run into trouble with *.g.dart files. See
// https://docs.flutter.dev/development/data-and-backend/json#one-time-code-generation
// for help.

import 'DataStructure.dart';

class DataHelper {
  late List<QuestionStack> _myQuestionStacks;

  DataHelper({List<QuestionStack> myQuestionStacks = const <QuestionStack>[]})
      : _myQuestionStacks = myQuestionStacks;

  List<QuestionStack> get myQuestionStacks => _myQuestionStacks;
}
