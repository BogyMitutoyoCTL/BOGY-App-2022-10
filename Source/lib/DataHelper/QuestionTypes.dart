// ignore_for_file: type_init_formals

import 'package:json_annotation/json_annotation.dart';
import 'DataStructure.dart';

part 'QuestionTypes.g.dart';

@JsonSerializable(includeIfNull: false)
class QuestionStringAndAnswers extends Question {
  @JsonKey(required: true)
  String question;
  @JsonKey(required: true)
  List<String> answers; // always the first one is the right one

  QuestionStringAndAnswers(
      {required String this.question, required List<String> this.answers, String? uuid})
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

@JsonSerializable(includeIfNull: false)
class QuestionStringAndFreeText extends Question {
  @JsonKey(required: true)
  String question;
  @JsonKey(required: true)
  String answer;

  QuestionStringAndFreeText(
      {required String this.question, required String this.answer, String? uuid})
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
