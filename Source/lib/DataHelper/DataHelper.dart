// Run `flutter pub run build_runner build --delete-conflicting-outputs`
// Run `flutter pub run build_runner watch --delete-conflicting-outputs`
// to continuously and automatically (re)build on changes.
// if you run into trouble with *.g.dart files. See
// https://docs.flutter.dev/development/data-and-backend/json#one-time-code-generation
// for help.

import 'package:flutter/services.dart';

import 'QuestionStack.dart';
import 'QuestionStringAndAnswers.dart';
import 'QuestionStringAndFreeText.dart';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

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
    if (!_myQuestionStacks.contains(newQuestionStack)) {
      _myQuestionStacks.add(newQuestionStack);
    }
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

  /// Adds Demo data
  void loadDemoData() {
    for (int i = 0; i < 10; i++) {
      QuestionStack questionStack = QuestionStack("QuestionStack$i");
      for (int j = 0; j <= i; j++) {
        QuestionStringAndFreeText questionStringAndFreeText =
            QuestionStringAndFreeText(
                question:
                    "Das ist die Frage der Freitextfrage $j von Stack $i. Was ist deine Antwort?",
                answer: "Answer");
        questionStack.addQuestion(questionStringAndFreeText);
        QuestionStringAndAnswers questionStringAndAnswers =
            QuestionStringAndAnswers(
                question:
                    "Das ist die Frage der SingleChoiceFrage $j von Stack $i. Was ist deine Antwort?",
                answers: ["Anton", "Berta", "Cäsar", "Dino"]);
        questionStack.addQuestion(questionStringAndAnswers);
      }
      addQuestionStack(questionStack);
    }
  }

  /// Returns the directory where the QuestionStacks were saved.
  /// This is a folder inside the Application Document Directory.
  Future<Directory> _getQuestionStackDir() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    return Directory("${appDocDir.path}/questionStacks");
  }

  /// Creates `directory` if it doesn't exist.
  void _createFolderIfNotExists(final Directory directory) async {
    if (!(await directory.exists())) {
      await directory.create(recursive: true);
    }
  }

  /// Writes all QuestionStacks to files. You can load them again with `load`.
  /// Important: All existing files in that directory like previous storages
  /// where deleted before!
  Future<void> save() async {
    await _deleteAllJsonFiles();
    try {
      Directory questionStackDir = await _getQuestionStackDir();
      _createFolderIfNotExists(questionStackDir);

      for (QuestionStack questionStack in _myQuestionStacks) {
        final String fileName = questionStack.getValidFileName();
        final file = File('${questionStackDir.path}/$fileName.json');
        await file.writeAsString(jsonEncode(questionStack));
        print("Saved to file: ${file.path}");
      }
      print('Saved all QuestionStacks');
    } catch (e) {
      print('Something went wrong, but anyway...');
    }
  }

  /// Replaces all QuestionStacks with the QuestionStacks saved in the json files
  /// by method `save`.
  /// Returns true on finished. This is needed by a FutureBuilder.
  Future<bool> load() async {
    try {
      Directory questionStackDir = await _getQuestionStackDir();
      _createFolderIfNotExists(questionStackDir);

      _myQuestionStacks = [];

      try {
        List<FileSystemEntity> files =
            questionStackDir.listSync(recursive: false, followLinks: false);

        for (FileSystemEntity fileSystemEntity in files) {
          try {
            final file = File(fileSystemEntity.path);
            String jsonString = await file.readAsString();
            print("Read from file ${file.path}: $jsonString");
            Map<String, dynamic> questionStackMap = jsonDecode(jsonString);
            QuestionStack questionStack =
                QuestionStack.fromJson(questionStackMap);
            addQuestionStack(questionStack);
          } catch (e) {
            print("Couldn't read file");
          }
        }
      } catch (FileSystemException) {
        print("No file found. Starting with an empty set.");
      }
      print('Read all QuestionStacks');
    } catch (FileSystemException) {
      print("Something went wrong - no worries...");
    }
    return true;
  }

  Future<String> _loadAsset(String filename) async {
    return await rootBundle.loadString("assets/$filename.json");
  }

  Future<void> addDefaultQuestionStacks() async {
    for (String filename in ["Bundeslaender", "DeutschesAllgemeinwissen"]) {
      String jsonString = await _loadAsset(filename);
      print("Read from asset $filename: $jsonString");
      Map<String, dynamic> questionStackMap = jsonDecode(jsonString);
      QuestionStack questionStack = QuestionStack.fromJson(questionStackMap);
      addQuestionStack(questionStack);
    }
  }

  /// Deletes all files in the directory for the QuestionStacks.
  Future<void> _deleteAllJsonFiles() async {
    try {
      Directory questionStackDir = await _getQuestionStackDir();
      _createFolderIfNotExists(questionStackDir);

      List<FileSystemEntity> files =
          questionStackDir.listSync(recursive: false, followLinks: false);

      for (FileSystemEntity fileSystemEntity in files) {
        try {
          final file = File(fileSystemEntity.path);
          await file.delete();
          print("Delete file: ${file.path}");
        } catch (e) {
          print("Couldn't delete file");
        }
      }
      print('Delete all QuestionStacks');
    } catch (e) {
      print('Something went wrong, but anyway...');
    }
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

Future<void> testDataHelper() async {
  DataHelper dataHelper = DataHelper();
  dataHelper.loadDemoData();

  QuestionStack questionStack = dataHelper.getQuestionStack(0);

  print(questionStack);

  QuestionStringAndFreeText questionStringAndFreeText =
      QuestionStringAndFreeText(question: "neue Frage", answer: "neue antwort");

  questionStack.replaceQuestion(0, questionStringAndFreeText);

  print(questionStack);
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

  dataHelper.getQuestionStack(0).addQuestion(
      QuestionStringAndFreeText(question: "Frage?", answer: "Antwort"));
  dataHelper.getQuestionStack(0).addQuestion(
      QuestionStringAndAnswers(question: "Frage2?", answers: ["8", "3", "4"]));
  print(dataHelper);

  QuestionStringAndFreeText question = dataHelper
      .getQuestionStack(0)
      .getQuestion(0) as QuestionStringAndFreeText;
  print("Die Frage: ${question.question}");
  print(question.isAnswerCorrect("Antwort"));
}
