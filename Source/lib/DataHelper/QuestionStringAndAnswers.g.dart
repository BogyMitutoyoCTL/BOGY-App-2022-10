// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuestionStringAndAnswers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionStringAndAnswers _$QuestionStringAndAnswersFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['uuid', 'question', 'answers'],
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
