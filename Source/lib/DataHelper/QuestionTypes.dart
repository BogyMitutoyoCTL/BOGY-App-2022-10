// ignore_for_file: type_init_formals

import 'package:json_annotation/json_annotation.dart';
import 'DataStructure.dart';

part 'QuestionTypes.g.dart';

/// This are the existing QuestionTypes
enum QuestionTypes {
  stringAndAnswer,
  stringAndFreeText,
}

/// This is a question that contains a String as Question and multiple answers.
@JsonSerializable(includeIfNull: false)
class QuestionStringAndAnswers extends QuestionBasic {
  @JsonKey(required: true)
  String question;
  @JsonKey(required: true)
  List<String> answers; // always the first one is the right one

  /// Only define the question and the answers params. Leave uuid empty!
  /// Always the first answer is the right one.
  QuestionStringAndAnswers(
      {required String this.question,
      required List<String> this.answers,
      String? uuid})
      : super(uuid: uuid, questionType: QuestionTypes.stringAndAnswer);

  @override
  bool isAnswerCorrect(var answerToCheck) {
    if (answers.isEmpty) {
      return false;
    }
    return answers[0] == answerToCheck;
  }

  factory QuestionStringAndAnswers.fromJson(Map<String, dynamic> json) =>
      _$QuestionStringAndAnswersFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionStringAndAnswersToJson(this);

  @override
  String toString() => toJson().toString();
}

/// This is a question that is defined by a String as Question and
/// a free text as answer.
@JsonSerializable(includeIfNull: false)
class QuestionStringAndFreeText extends QuestionBasic {
  @JsonKey(required: true)
  String question;
  @JsonKey(required: true)
  String answer;

  /// Only define the question and the answers params. Leave uuid empty!
  /// The answer is the text the user is expected to type in
  QuestionStringAndFreeText(
      {required String this.question,
      required String this.answer,
      String? uuid})
      : super(uuid: uuid, questionType: QuestionTypes.stringAndFreeText);

  @override
  bool isAnswerCorrect(var answerToCheck) {
    return answer == answerToCheck;
  }

  factory QuestionStringAndFreeText.fromJson(Map<String, dynamic> json) =>
      _$QuestionStringAndFreeTextFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionStringAndFreeTextToJson(this);

  @override
  String toString() => toJson().toString();
}
