import 'package:json_annotation/json_annotation.dart';

import 'QuestionTypes.dart';
import 'package:uuid/uuid.dart';

/// This allows the `Question` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
/// See: https://docs.flutter.dev/development/data-and-backend/json#one-time-code-generation
part 'DataStructure.g.dart';

enum QuestionTypes {
  stringAndAnswer,
  stringAndFreeText,
}

abstract class Question {
  @JsonKey(required: true)
  late String _uuid;
  @JsonKey(ignore: true)
  QuestionTypes _questionType;

  Question({required String? uuid, required QuestionTypes questionType})
      : _questionType = questionType {
    _uuid = uuid ?? const Uuid().v1();
  }

  bool isAnswerCorrect(var answerToCheck);

  String get uuid => _uuid;

  QuestionTypes get questionType => _questionType;

  bool isQuestionType(QuestionTypes questionType) {
    return _questionType == questionType;
  }
}

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

  QuestionStack(this.name,
      {List<String>? orderList,
      List<QuestionStringAndAnswers>? questionStringAndAnswers,
      List<QuestionStringAndFreeText>? questionStringAndFreeText})
      : _orderList = orderList ?? [],
        _questionStringAndAnswers = questionStringAndAnswers ?? [],
        _questionStringAndFreeText = questionStringAndFreeText ?? [] {
    checkQuestionOrder();
  }

  Question getQuestion(int index) {
    String uuid = _orderList[index];

    if (_questionStringAndAnswers.any((element) => element.uuid == uuid)) {
      return _questionStringAndAnswers
          .firstWhere((element) => element.uuid == uuid);
    }
    if (_questionStringAndFreeText.any((element) => element.uuid == uuid)) {
      return _questionStringAndFreeText
          .firstWhere((element) => element.uuid == uuid);
    }

    throw Exception("Can't find the this question");
  }

  int addQuestionStringAndAnswers(
      QuestionStringAndAnswers newQuestionStringAndAnswers) {
    _questionStringAndAnswers.add(newQuestionStringAndAnswers);
    _orderList.add(newQuestionStringAndAnswers.uuid);
    return _orderList.length - 1;
  }

  int addQuestionStringAndFreeText(
      QuestionStringAndFreeText newQuestionStringAndFreeText) {
    _questionStringAndFreeText.add(newQuestionStringAndFreeText);
    _orderList.add(newQuestionStringAndFreeText.uuid);
    return _orderList.length - 1;
  }

  void removeQuestion(int index) {
    String uuid = _orderList[index];
    _orderList.removeAt(index);

    if (_questionStringAndAnswers.any((element) => element.uuid == uuid)) {
      _questionStringAndAnswers.removeWhere((element) => element.uuid == uuid);
      return;
    }
    if (_questionStringAndFreeText.any((element) => element.uuid == uuid)) {
      _questionStringAndFreeText.removeWhere((element) => element.uuid == uuid);
      return;
    }
  }

  int getAmountOfQuestions() {
    return _orderList.length;
  }

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
      return true;
    });
  }

  List<String> get orderList => _orderList;

  List<QuestionStringAndAnswers> get questionStringAndAnswers =>
      _questionStringAndAnswers;

  List<QuestionStringAndFreeText> get questionStringAndFreeText =>
      _questionStringAndFreeText;

  @override
  String toString() => toJson().toString();

  factory QuestionStack.fromJson(Map<String, dynamic> json) =>
      _$QuestionStackFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionStackToJson(this);
}
