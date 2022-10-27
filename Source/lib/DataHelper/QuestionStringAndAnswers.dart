import 'package:json_annotation/json_annotation.dart';

import 'QuestionBasic.dart';
import 'QuestionTypes.dart';

part 'QuestionStringAndAnswers.g.dart';

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
      {required this.question, required this.answers, String? uuid})
      : super(uuid: uuid, questionType: QuestionTypes.stringAndAnswers);

  @override
  bool isAnswerCorrect(var answerToCheck) {
    if (answers.isEmpty) {
      return false;
    }
    return answerToCheck == answers[0];
  }

  factory QuestionStringAndAnswers.fromJson(Map<String, dynamic> json) =>
      _$QuestionStringAndAnswersFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionStringAndAnswersToJson(this);

  @override
  String toString() => toJson().toString();
}
