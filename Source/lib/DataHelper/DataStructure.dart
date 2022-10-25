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
}

@JsonSerializable(explicitToJson: true, includeIfNull: true)
class QuestionStack {
  @JsonKey(required: true)
  String name;
  @JsonKey(defaultValue: [])
  List<String> _orderList;
  @JsonKey(defaultValue: [])
  List<QuestionStringAndAnswers> questionStringAndAnswers;
  @JsonKey(defaultValue: [])
  List<QuestionStringAndFreeText> questionStringAndFreeText;

  QuestionStack(this.name, List<String> orderList,
      {List<QuestionStringAndAnswers> this.questionStringAndAnswers = const [],
      List<QuestionStringAndFreeText> this.questionStringAndFreeText =
          const []})
      : _orderList = orderList {
    checkQuestionOrder();
  }

  Question getQuestion(int index) {
    checkQuestionOrder();

    String uuid = _orderList[index];

    if (questionStringAndAnswers.any((element) => element.uuid == uuid)) {
      return questionStringAndAnswers
          .firstWhere((element) => element.uuid == uuid);
    }
    if (questionStringAndAnswers.any((element) => element.uuid == uuid)) {
      return questionStringAndAnswers
          .firstWhere((element) => element.uuid == uuid);
    }

    throw Exception("Can't find the this question");
  }

  void checkQuestionOrder() {
    _addMissingUuidsToOrderList();
    _deleteUnsetUuidsInOrderList();
  }

  void _addMissingUuidsToOrderList() {
    for (QuestionStringAndAnswers element in questionStringAndAnswers) {
      if (!_orderList.contains(element.uuid)) {
        _orderList.add(element.uuid);
      }
    }
    for (QuestionStringAndFreeText element in questionStringAndFreeText) {
      if (!_orderList.contains(element.uuid)) {
        _orderList.add(element.uuid);
      }
    }
  }

  void _deleteUnsetUuidsInOrderList() {
    _orderList.removeWhere((String uid) {
      for (QuestionStringAndAnswers element in questionStringAndAnswers) {
        if (uid == element.uuid) {
          return false;
        }
      }
      for (QuestionStringAndFreeText element in questionStringAndFreeText) {
        if (uid == element.uuid) {
          return false;
        }
      }
      return true;
    });
  }

  List<String> get orderList => _orderList;

  @override
  String toString() => toJson().toString();

  factory QuestionStack.fromJson(Map<String, dynamic> json) =>
      _$QuestionStackFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionStackToJson(this);
}
