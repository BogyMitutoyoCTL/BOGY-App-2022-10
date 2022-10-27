// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuestionStack.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionStack _$QuestionStackFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['name'],
  );
  return QuestionStack(
    json['name'] as String,
    orderList:
        (json['orderList'] as List<dynamic>?)?.map((e) => e as String).toList(),
    questionStringAndAnswers: (json['questionStringAndAnswers']
            as List<dynamic>?)
        ?.map(
            (e) => QuestionStringAndAnswers.fromJson(e as Map<String, dynamic>))
        .toList(),
    questionStringAndFreeText:
        (json['questionStringAndFreeText'] as List<dynamic>?)
            ?.map((e) =>
                QuestionStringAndFreeText.fromJson(e as Map<String, dynamic>))
            .toList(),
    questionImageAndFreeText: (json['questionImageAndFreeText']
            as List<dynamic>?)
        ?.map(
            (e) => QuestionImageAndFreeText.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$QuestionStackToJson(QuestionStack instance) =>
    <String, dynamic>{
      'name': instance.name,
      'orderList': instance.orderList,
      'questionStringAndAnswers':
          instance.questionStringAndAnswers.map((e) => e.toJson()).toList(),
      'questionStringAndFreeText':
          instance.questionStringAndFreeText.map((e) => e.toJson()).toList(),
      'questionImageAndFreeText':
          instance.questionImageAndFreeText.map((e) => e.toJson()).toList(),
    };
