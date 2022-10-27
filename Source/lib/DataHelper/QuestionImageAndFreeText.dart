import 'package:json_annotation/json_annotation.dart';
import 'QuestionBasic.dart';
import 'QuestionTypes.dart';
part 'QuestionImageAndFreeText.g.dart';

/// This is a question that is defined by an image as Question and
/// a free text as answer.
/// The Image is encoded as Base64.
@JsonSerializable(includeIfNull: false)
class QuestionImageAndFreeText extends QuestionBasic {
  @JsonKey(required: true)
  String imageString;
  @JsonKey(required: true)
  String answer;

  /// Only define the question and the answers params. Leave uuid empty!
  /// The answer is the text the user is expected to type in
  QuestionImageAndFreeText(
      {required this.imageString, required this.answer, String? uuid})
      : super(uuid: uuid, questionType: QuestionTypes.imageAndFreeText);

  @override
  bool isAnswerCorrect(var answerToCheck) {
    return answerToCheck == answer;
  }

  factory QuestionImageAndFreeText.fromJson(Map<String, dynamic> json) =>
      _$QuestionImageAndFreeTextFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionImageAndFreeTextToJson(this);

  @override
  String toString() => toJson().toString();
}
