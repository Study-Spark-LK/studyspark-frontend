// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DocumentsRequestBody _$DocumentsRequestBodyFromJson(
  Map<String, dynamic> json,
) => _DocumentsRequestBody(
  fileId: json['fileId'] as String,
  profileId: json['profileId'] as String,
);

Map<String, dynamic> _$DocumentsRequestBodyToJson(
  _DocumentsRequestBody instance,
) => <String, dynamic>{
  'fileId': instance.fileId,
  'profileId': instance.profileId,
};
