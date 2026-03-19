// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data6.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Data6 _$Data6FromJson(Map<String, dynamic> json) => _Data6(
  id: json['id'] as String,
  profileId: json['profileId'] as String,
  status: Status3.fromJson(json['status'] as String),
);

Map<String, dynamic> _$Data6ToJson(_Data6 instance) => <String, dynamic>{
  'id': instance.id,
  'profileId': instance.profileId,
  'status': _$Status3EnumMap[instance.status]!,
};

const _$Status3EnumMap = {
  Status3.pending: 'PENDING',
  Status3.$unknown: r'$unknown',
};
