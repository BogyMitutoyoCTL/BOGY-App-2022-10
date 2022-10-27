// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuestionImageAndFreeText.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionImageAndFreeText _$QuestionImageAndFreeTextFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['uuid', 'imageString', 'answer'],
  );
  return QuestionImageAndFreeText(
    imageString: json['imageString'] as String,
    answer: json['answer'] as String,
    uuid: json['uuid'] as String?,
  );
}

Map<String, dynamic> _$QuestionImageAndFreeTextToJson(
        QuestionImageAndFreeText instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'imageString': instance.imageString,
      'answer': instance.answer,
    };
