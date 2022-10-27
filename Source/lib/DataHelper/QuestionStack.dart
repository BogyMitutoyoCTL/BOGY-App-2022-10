import 'package:json_annotation/json_annotation.dart';
import 'package:learnhub/DataHelper/QuestionTypes.dart';

import 'QuestionBasic.dart';
import 'QuestionImageAndFreeText.dart';
import 'QuestionStringAndAnswers.dart';
import 'QuestionStringAndFreeText.dart';

part 'QuestionStack.g.dart';

/// This is one QuestionStack that contains multiple Question of different Types.
/// You can get a single Question by multiple functions.
@JsonSerializable(explicitToJson: true, includeIfNull: true)
class QuestionStack {
  @JsonKey(required: true)
  String name;
  @JsonKey(defaultValue: [])
  List<String> _orderList;
  @JsonKey(defaultValue: [])
  List<QuestionStringAndAnswers> _questionStringAndAnswers;
  @JsonKey(defaultValue: [])
  List<QuestionStringAndFreeText> _questionStringAndFreeText;
  @JsonKey(defaultValue: [])
  List<QuestionImageAndFreeText> _questionImageAndFreeText;

  QuestionStack(this.name,
      {List<String>? orderList,
      List<QuestionStringAndAnswers>? questionStringAndAnswers,
      List<QuestionStringAndFreeText>? questionStringAndFreeText,
      List<QuestionImageAndFreeText>? questionImageAndFreeText})
      : _orderList = orderList ?? [],
        _questionStringAndAnswers = questionStringAndAnswers ?? [],
        _questionStringAndFreeText = questionStringAndFreeText ?? [],
        _questionImageAndFreeText = questionImageAndFreeText ?? [] {
    checkQuestionOrder();
    _orderList.shuffle();
  }

  /// Returns the Question with the index `index`.
  /// The returned Object is not directly of Type Question but of
  /// one of its Subclasses. These are defined in QuestionTypes.
  /// To get the Type of the returned Question run .questionType on the
  /// returned Question.
  QuestionBasic getQuestion(int index) {
    String uuid = _orderList[index];

    if (_questionStringAndAnswers.any((element) => element.uuid == uuid)) {
      return _questionStringAndAnswers
          .firstWhere((element) => element.uuid == uuid);
    }
    if (_questionStringAndFreeText.any((element) => element.uuid == uuid)) {
      return _questionStringAndFreeText
          .firstWhere((element) => element.uuid == uuid);
    }
    if (_questionImageAndFreeText.any((element) => element.uuid == uuid)) {
      return _questionImageAndFreeText
          .firstWhere((element) => element.uuid == uuid);
    }

    throw Exception("Can't find the this question");
  }

  /// Adds a question independent from its type.
  /// Returns the index of the newly added question.
  int addQuestion(QuestionBasic question) {
    switch (question.questionType) {
      case QuestionTypes.stringAndAnswers:
        String uuid =
            _addQuestionStringAndAnswers(question as QuestionStringAndAnswers);
        _orderList.add(uuid);
        return _orderList.length - 1;
      case QuestionTypes.stringAndFreeText:
        String uuid = _addQuestionStringAndFreeText(
            question as QuestionStringAndFreeText);
        _orderList.add(uuid);
        return _orderList.length - 1;
      case QuestionTypes.imageAndFreeText:
        String uuid =
            _addQuestionImageAndFreeText(question as QuestionImageAndFreeText);
        _orderList.add(uuid);
        return _orderList.length - 1;
      default:
        throw Exception("This question is not of a valid question type");
    }
  }

  /// Adds a Question from Type QuestionStringAndAnswers to the end of the Stack.
  /// Returns the uuid of the newly added question.
  /// Does NOT add uuid to order file!
  String _addQuestionStringAndAnswers(
      QuestionStringAndAnswers newQuestionStringAndAnswers) {
    _questionStringAndAnswers.add(newQuestionStringAndAnswers);
    return newQuestionStringAndAnswers.uuid;
  }

  /// Adds a Question from Type QuestionStringAndFreeText to the end of the Stack.
  /// Returns the uuid of the newly added question.
  /// Does NOT add uuid to order file!
  String _addQuestionStringAndFreeText(
      QuestionStringAndFreeText newQuestionStringAndFreeText) {
    _questionStringAndFreeText.add(newQuestionStringAndFreeText);
    return newQuestionStringAndFreeText.uuid;
  }

  /// Adds a Question from Type QuestionImageAndFreeText to the end of the Stack.
  /// Returns the uuid of the newly added question.
  /// Does NOT add uuid to order file!
  String _addQuestionImageAndFreeText(
      QuestionImageAndFreeText newQuestionImageAndFreeText) {
    _questionImageAndFreeText.add(newQuestionImageAndFreeText);
    return newQuestionImageAndFreeText.uuid;
  }

  void removeQuestion(QuestionBasic question) {
    _orderList.remove(question.uuid);
    _removeQuestionFromQuestionList(question.uuid);
  }

  /// Removes a Question by its id. Throws an error if the index is not valid.
  void removeQuestionByIndex(int index) {
    String uuid = _orderList[index];
    _orderList.removeAt(index);
    _removeQuestionFromQuestionList(uuid);
  }

  /// Removes the question but does NOT delete the uuid from order file.
  void _removeQuestionFromQuestionList(String uuid) {
    if (_questionStringAndAnswers.any((element) => element.uuid == uuid)) {
      _questionStringAndAnswers.removeWhere((element) => element.uuid == uuid);
      return;
    }
    if (_questionStringAndFreeText.any((element) => element.uuid == uuid)) {
      _questionStringAndFreeText.removeWhere((element) => element.uuid == uuid);
      return;
    }
    if (_questionImageAndFreeText.any((element) => element.uuid == uuid)) {
      _questionImageAndFreeText.removeWhere((element) => element.uuid == uuid);
      return;
    }
  }

  /// Replaces the Question at index `indexOfOldQuestion` with `newQuestion`.
  void replaceQuestion(int indexOfOldQuestion, QuestionBasic newQuestion) {
    String uuid = getQuestion(indexOfOldQuestion).uuid;
    _removeQuestionFromQuestionList(uuid);

    newQuestion.uuid = uuid;

    switch (newQuestion.questionType) {
      case QuestionTypes.stringAndAnswers:
        _addQuestionStringAndAnswers(newQuestion as QuestionStringAndAnswers);
        break;
      case QuestionTypes.stringAndFreeText:
        _addQuestionStringAndFreeText(newQuestion as QuestionStringAndFreeText);
        break;
      case QuestionTypes.imageAndFreeText:
        _addQuestionImageAndFreeText(newQuestion as QuestionImageAndFreeText);
        break;
      default:
        throw Exception("This question is not of a valid question type");
    }
  }

  /// Returns the total amount of Questions.
  int getAmountOfQuestions() {
    return _orderList.length;
  }

  /// Syncs the uuids from the questions with the order list.
  void checkQuestionOrder() {
    _addMissingUuidsToOrderList();
    _deleteUnsetUuidsInOrderList();
  }

  void _addMissingUuidsToOrderList() {
    for (QuestionStringAndAnswers element in _questionStringAndAnswers) {
      if (!_orderList.contains(element.uuid)) {
        _orderList.add(element.uuid);
      }
    }
    for (QuestionStringAndFreeText element in _questionStringAndFreeText) {
      if (!_orderList.contains(element.uuid)) {
        _orderList.add(element.uuid);
      }
    }
    for (QuestionImageAndFreeText element in _questionImageAndFreeText) {
      if (!_orderList.contains(element.uuid)) {
        _orderList.add(element.uuid);
      }
    }
  }

  void _deleteUnsetUuidsInOrderList() {
    if (_orderList.isEmpty) {
      return;
    }
    _orderList.removeWhere((String uuid) {
      for (QuestionStringAndAnswers element in _questionStringAndAnswers) {
        if (uuid == element.uuid) {
          return false;
        }
      }
      for (QuestionStringAndFreeText element in _questionStringAndFreeText) {
        if (uuid == element.uuid) {
          return false;
        }
      }
      for (QuestionImageAndFreeText element in _questionImageAndFreeText) {
        if (uuid == element.uuid) {
          return false;
        }
      }
      return true;
    });
  }

  /// Returns a list containing the uuids from the Questions.
  List<String> get orderList => _orderList;

  List<QuestionStringAndAnswers> get questionStringAndAnswers =>
      _questionStringAndAnswers;

  List<QuestionStringAndFreeText> get questionStringAndFreeText =>
      _questionStringAndFreeText;

  List<QuestionImageAndFreeText> get questionImageAndFreeText =>
      _questionImageAndFreeText;

  @override
  String toString() => toJson().toString();

  factory QuestionStack.fromJson(Map<String, dynamic> json) =>
      _$QuestionStackFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionStackToJson(this);
}

void main() {
  QuestionStack questionStack = QuestionStack("Neuer QuestionStack");

  QuestionImageAndFreeText questionImageAndFreeText =
      QuestionImageAndFreeText(imageString: "ALNDWONDOWAN", answer: "Antwort");
  questionStack.addQuestion(questionImageAndFreeText);
  Map<String, dynamic> json = questionStack.toJson();

  print(json.toString());

  QuestionStack questionStack_2 = QuestionStack.fromJson(json);
  print(questionStack_2);
}
