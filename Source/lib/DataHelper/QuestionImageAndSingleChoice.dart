import 'package:json_annotation/json_annotation.dart';

import 'QuestionBasic.dart';
import 'QuestionTypes.dart';

part 'QuestionImageAndSingleChoice.g.dart';

/// This is a question that contains a String as Question and multiple answers.
@JsonSerializable(includeIfNull: false)
class QuestionImageAndSingleChoice extends QuestionBasic {
  @JsonKey(required: true)
  String imageString;
  @JsonKey(required: true)
  List<String> answers; // always the first one is the right one

  /// Only define the image and the answers params. Leave uuid empty!
  /// Always the first answer is the right one.
  QuestionImageAndSingleChoice(
      {required this.imageString, required this.answers, String? uuid})
      : super(uuid: uuid, questionType: QuestionTypes.imageAndSingleChoice);

  @override
  bool isAnswerCorrect(var answerToCheck) {
    if (answers.isEmpty) {
      return false;
    }
    return answerToCheck == answers[0];
  }

  factory QuestionImageAndSingleChoice.fromJson(Map<String, dynamic> json) =>
      _$QuestionImageAndSingleChoiceFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionImageAndSingleChoiceToJson(this);

  @override
  String toString() => toJson().toString();
}
