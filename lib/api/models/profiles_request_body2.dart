// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'profiles_request_body2.freezed.dart';
part 'profiles_request_body2.g.dart';

@Freezed()
abstract class ProfilesRequestBody2 with _$ProfilesRequestBody2 {
  const factory ProfilesRequestBody2({
    required String id,
  }) = _ProfilesRequestBody2;
  
  factory ProfilesRequestBody2.fromJson(Map<String, Object?> json) => _$ProfilesRequestBody2FromJson(json);
}
