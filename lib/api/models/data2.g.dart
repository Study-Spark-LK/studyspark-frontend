// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Data2 _$Data2FromJson(Map<String, dynamic> json) => _Data2(
  id: json['id'] as String,
  name: json['name'] as String,
  status: Status.fromJson(json['status'] as String),
  visualScore: json['visualScore'] as num? ?? 0,
  auditoryScore: json['auditoryScore'] as num? ?? 0,
  readingScore: json['readingScore'] as num? ?? 0,
  kinestheticScore: json['kinestheticScore'] as num? ?? 0,
  createdAt: json['createdAt'],
  updatedAt: json['updatedAt'],
);

Map<String, dynamic> _$Data2ToJson(_Data2 instance) => <String, dynamic>{
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
