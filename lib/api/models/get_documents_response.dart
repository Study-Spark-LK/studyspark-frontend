// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'data5.dart';

part 'get_documents_response.freezed.dart';
part 'get_documents_response.g.dart';

@Freezed()
abstract class GetDocumentsResponse with _$GetDocumentsResponse {
  const factory GetDocumentsResponse({
    required List<Data5> data,
  }) = _GetDocumentsResponse;
  
  factory GetDocumentsResponse.fromJson(Map<String, Object?> json) => _$GetDocumentsResponseFromJson(json);
}
