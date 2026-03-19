// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data7.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Data7 _$Data7FromJson(Map<String, dynamic> json) => _Data7(
  id: json['id'] as String,
  profileId: json['profileId'] as String,
  status: Status.fromJson(json['status'] as String),
  title: json['title'] as String,
  description: json['description'] as String,
  category: json['category'] as String,
  progressPercentage: json['progressPercentage'] as num,
  originalFileId: json['originalFileId'] as String,
  generatedFiles: (json['generatedFiles'] as List<dynamic>)
      .map((e) => GeneratedFiles.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$Data7ToJson(_Data7 instance) => <String, dynamic>{
  'id': instance.id,
  'profileId': instance.profileId,
  'status': _$StatusEnumMap[instance.status]!,
  'title': instance.title,
  'description': instance.description,
  'category': instance.category,
  'progressPercentage': instance.progressPercentage,
  'originalFileId': instance.originalFileId,
  'generatedFiles': instance.generatedFiles,
};

const _$StatusEnumMap = {
  Status.pending: 'PENDING',
  Status.ready: 'READY',
  Status.$unknown: r'$unknown',
};
