// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuestionStringAndFreeText.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
