// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_documents_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetDocumentsResponse _$GetDocumentsResponseFromJson(
  Map<String, dynamic> json,
) => _GetDocumentsResponse(
  data: (json['data'] as List<dynamic>)
      .map((e) => Data5.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GetDocumentsResponseToJson(
  _GetDocumentsResponse instance,
) => <String, dynamic>{'data': instance.data};
