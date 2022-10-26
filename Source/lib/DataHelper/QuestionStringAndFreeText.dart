import 'package:json_annotation/json_annotation.dart';

import 'QuestionBasic.dart';
import 'QuestionTypes.dart';
part 'QuestionStringAndFreeText.g.dart';

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
