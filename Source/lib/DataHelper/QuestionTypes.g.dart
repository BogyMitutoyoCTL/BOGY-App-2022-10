// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuestionTypes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionStringAndAnswers _$QuestionStringAndAnswersFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['question', 'answers'],
  );
  return QuestionStringAndAnswers(
    question: json['question'] as String,
    answers:
        (json['answers'] as List<dynamic>).map((e) => e as String).toList(),
    uuid: json['uuid'] as String?,
  );
}

Map<String, dynamic> _$QuestionStringAndAnswersToJson(
        QuestionStringAndAnswers instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'question': instance.question,
      'answers': instance.answers,
    };

QuestionStringAndFreeText _$QuestionStringAndFreeTextFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['question', 'answer'],
  );
  return QuestionStringAndFreeText(
    question: json['question'] as String,
    answer: json['answer'] as String,
    uuid: json['uuid'] as String?,
  );
}

Map<String, dynamic> _$QuestionStringAndFreeTextToJson(
        QuestionStringAndFreeText instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'question': instance.question,
      'answer': instance.answer,
    };
