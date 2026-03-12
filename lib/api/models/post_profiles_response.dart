// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'data3.dart';

part 'post_profiles_response.freezed.dart';
part 'post_profiles_response.g.dart';

@Freezed()
abstract class PostProfilesResponse with _$PostProfilesResponse {
  const factory PostProfilesResponse({
    required Data3 data,
  }) = _PostProfilesResponse;
  
  factory PostProfilesResponse.fromJson(Map<String, Object?> json) => _$PostProfilesResponseFromJson(json);
}
