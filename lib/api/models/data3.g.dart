// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Data3 _$Data3FromJson(Map<String, dynamic> json) => _Data3(
  id: json['id'] as String,
  name: json['name'] as String,
  status: Status3.fromJson(json['status'] as String),
);

Map<String, dynamic> _$Data3ToJson(_Data3 instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'status': _$Status3EnumMap[instance.status]!,
};

const _$Status3EnumMap = {
  Status3.pending: 'PENDING',
  Status3.$unknown: r'$unknown',
};
