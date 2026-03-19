// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'data6.dart';

part 'post_documents_response.freezed.dart';
part 'post_documents_response.g.dart';

@Freezed()
abstract class PostDocumentsResponse with _$PostDocumentsResponse {
  const factory PostDocumentsResponse({
    required Data6 data,
  }) = _PostDocumentsResponse;
  
  factory PostDocumentsResponse.fromJson(Map<String, Object?> json) => _$PostDocumentsResponseFromJson(json);
}
