// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profiles_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfilesRequestBody _$ProfilesRequestBodyFromJson(Map<String, dynamic> json) =>
    _ProfilesRequestBody(
      name: json['name'] as String,
      qna: (json['qna'] as List<dynamic>)
          .map((e) => Qna.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfilesRequestBodyToJson(
  _ProfilesRequestBody instance,
) => <String, dynamic>{'name': instance.name, 'qna': instance.qna};
