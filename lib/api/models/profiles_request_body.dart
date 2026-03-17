// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'qna.dart';

part 'profiles_request_body.freezed.dart';
part 'profiles_request_body.g.dart';

@Freezed()
abstract class ProfilesRequestBody with _$ProfilesRequestBody {
  const factory ProfilesRequestBody({
    required String name,
    required List<Qna> qna,
  }) = _ProfilesRequestBody;
  
  factory ProfilesRequestBody.fromJson(Map<String, Object?> json) => _$ProfilesRequestBodyFromJson(json);
}
