import 'package:json_annotation/json_annotation.dart';

import 'QuestionTypes.dart';
import 'package:uuid/uuid.dart';

/// This allows the `Question` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
/// See: https://docs.flutter.dev/development/data-and-backend/json#one-time-code-generation
part 'DataStructure.g.dart';

/// This is the parent class for all Questions. All QuestionTypes defined in QuestionTypes
/// need to extends from this class.
abstract class Question {
  @JsonKey(required: true)
  late String _uuid;
  @JsonKey(ignore: true)
  final QuestionTypes _questionType;

  Question({required String? uuid, required QuestionTypes questionType})
      : _questionType = questionType {
    _uuid = uuid ?? const Uuid().v1();
  }

  /// Returns true if `answerToCheck` is the right answer. Otherwise returns false.
  /// This function has to be overwritten by all subclasses.
  bool isAnswerCorrect(var answerToCheck);

  /// Returns the UUID (Unified ID) of a question. This UUID differs from one to the next question.
  /// When you create the Question, the UUID is created automatically if not explicitly specified.
  String get uuid => _uuid;

  /// Returns the Type of the Question
  QuestionTypes get questionType => _questionType;

  /// Checks if the Type of this Question is equal to `questionType`.
  bool isQuestionType(QuestionTypes questionType) {
    return _questionType == questionType;
  }
}

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

  QuestionStack(this.name,
      {List<String>? orderList,
      List<QuestionStringAndAnswers>? questionStringAndAnswers,
      List<QuestionStringAndFreeText>? questionStringAndFreeText})
      : _orderList = orderList ?? [],
        _questionStringAndAnswers = questionStringAndAnswers ?? [],
        _questionStringAndFreeText = questionStringAndFreeText ?? [] {
    checkQuestionOrder();
  }

  /// Returns the Question with the index `index`.
  /// The returned Object is not directly of Type Question but of
  /// one of its Subclasses. These are defined in QuestionTypes.
  /// To get the Type of the returned Question run .questionType on the
  /// returned Question.
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

  /// Adds a Question from Type QuestionStringAndAnswers to the end of the Stack.
  /// Returns the index of the newly added question.
  int addQuestionStringAndAnswers(
      QuestionStringAndAnswers newQuestionStringAndAnswers) {
    _questionStringAndAnswers.add(newQuestionStringAndAnswers);
    _orderList.add(newQuestionStringAndAnswers.uuid);
    return _orderList.length - 1;
  }

  /// Adds a Question from Type QuestionStringAndFreeText to the end of the Stack.
  /// Returns the index of the newly added question.
  int addQuestionStringAndFreeText(
      QuestionStringAndFreeText newQuestionStringAndFreeText) {
    _questionStringAndFreeText.add(newQuestionStringAndFreeText);
    _orderList.add(newQuestionStringAndFreeText.uuid);
    return _orderList.length - 1;
  }

  /// Removes a Question by its id. Throws an error if the index is not valid.
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

  /// Returns a list containing the uuids from the Questions.
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
