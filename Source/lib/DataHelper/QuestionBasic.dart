import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'QuestionTypes.dart';

/// This is the parent class for all Questions. All QuestionTypes defined in QuestionTypes
/// need to extends from this class.
abstract class QuestionBasic {
  /// This is the UUID (Unified ID) of a question. This UUID differs from one to the next question.
  /// When you create the Question, the UUID is created automatically if not explicitly specified.
  @JsonKey(required: true)
  late String uuid;
  @JsonKey(required: true)
  late final bool isPictureQuestion;
  @JsonKey(required: true)
  late final bool isMultipleChoiceQuestion;
  @JsonKey(ignore: true)
  final QuestionTypes _questionType;

  QuestionBasic({required String? uuid, required QuestionTypes questionType})
      : _questionType = questionType {
    this.uuid = uuid ?? const Uuid().v1();
    isPictureQuestion = false;
    isMultipleChoiceQuestion = false;
    if (questionType == QuestionTypes.imageAndSingleChoice ||
        questionType == QuestionTypes.imageAndFreeText) {
      isPictureQuestion = true;
    }
    if (questionType == QuestionTypes.imageAndSingleChoice ||
        questionType == QuestionTypes.stringAndAnswers) {
      isMultipleChoiceQuestion = true;
    }
  }

  /// Returns true if `answerToCheck` is the right answer. Otherwise returns false.
  /// This function has to be overwritten by all subclasses.
  bool isAnswerCorrect(var answerToCheck);

  /// Returns the Type of the Question
  QuestionTypes get questionType => _questionType;

  /// Checks if the Type of this Question is equal to `questionType`.
  bool isQuestionType(QuestionTypes questionType) {
    return _questionType == questionType;
  }
}
