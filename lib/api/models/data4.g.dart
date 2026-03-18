// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data4.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Data4 _$Data4FromJson(Map<String, dynamic> json) => _Data4(
  id: json['id'] as String,
  name: json['name'] as String,
  status: Status.fromJson(json['status'] as String),
  visualScore: json['visualScore'] as num,
  auditoryScore: json['auditoryScore'] as num,
  readingScore: json['readingScore'] as num,
  kinestheticScore: json['kinestheticScore'] as num,
  createdAt: json['createdAt'] as num,
  updatedAt: json['updatedAt'] as num,
);

Map<String, dynamic> _$Data4ToJson(_Data4 instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'status': _$StatusEnumMap[instance.status]!,
  'visualScore': instance.visualScore,
  'auditoryScore': instance.auditoryScore,
  'readingScore': instance.readingScore,
  'kinestheticScore': instance.kinestheticScore,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};

const _$StatusEnumMap = {
  Status.pending: 'PENDING',
  Status.ready: 'READY',
  Status.$unknown: r'$unknown',
};
