// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_profiles_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetProfilesResponse _$GetProfilesResponseFromJson(Map<String, dynamic> json) =>
    _GetProfilesResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => Data2.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetProfilesResponseToJson(
  _GetProfilesResponse instance,
) => <String, dynamic>{'data': instance.data};
