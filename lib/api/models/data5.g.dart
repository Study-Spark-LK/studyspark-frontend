// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data5.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Data5 _$Data5FromJson(Map<String, dynamic> json) => _Data5(
  id: json['id'] as String,
  profileId: json['profileId'] as String,
  status: Status.fromJson(json['status'] as String),
  title: json['title'] as String?,
  description: json['description'] as String?,
  category: json['category'] as String?,
  progressPercentage: json['progressPercentage'] as num,
);

Map<String, dynamic> _$Data5ToJson(_Data5 instance) => <String, dynamic>{
  'id': instance.id,
  'profileId': instance.profileId,
  'status': _$StatusEnumMap[instance.status]!,
  'title': instance.title,
  'description': instance.description,
  'category': instance.category,
  'progressPercentage': instance.progressPercentage,
};

const _$StatusEnumMap = {
  Status.pending: 'PENDING',
  Status.ready: 'READY',
  Status.$unknown: r'$unknown',
};
