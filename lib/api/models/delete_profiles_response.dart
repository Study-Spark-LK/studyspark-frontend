// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'data4.dart';

part 'delete_profiles_response.freezed.dart';
part 'delete_profiles_response.g.dart';

@Freezed()
abstract class DeleteProfilesResponse with _$DeleteProfilesResponse {
  const factory DeleteProfilesResponse({
    required Data4 data,
  }) = _DeleteProfilesResponse;
  
  factory DeleteProfilesResponse.fromJson(Map<String, Object?> json) => _$DeleteProfilesResponseFromJson(json);
}
