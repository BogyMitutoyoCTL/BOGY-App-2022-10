// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuestionImageAndSingleChoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionImageAndSingleChoice _$QuestionImageAndSingleChoiceFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['uuid', 'imageString', 'answers'],
  );
  return QuestionImageAndSingleChoice(
    imageString: json['imageString'] as String,
    answers:
        (json['answers'] as List<dynamic>).map((e) => e as String).toList(),
    uuid: json['uuid'] as String?,
  );
}

Map<String, dynamic> _$QuestionImageAndSingleChoiceToJson(
        QuestionImageAndSingleChoice instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'imageString': instance.imageString,
      'answers': instance.answers,
    };
