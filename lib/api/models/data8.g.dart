// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data8.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Data8 _$Data8FromJson(Map<String, dynamic> json) => _Data8(
  id: json['id'] as String,
  profileId: json['profileId'] as String,
  status: Status.fromJson(json['status'] as String),
);

Map<String, dynamic> _$Data8ToJson(_Data8 instance) => <String, dynamic>{
  'id': instance.id,
  'profileId': instance.profileId,
  'status': _$StatusEnumMap[instance.status]!,
};

const _$StatusEnumMap = {
  Status.pending: 'PENDING',
  Status.ready: 'READY',
  Status.$unknown: r'$unknown',
};
