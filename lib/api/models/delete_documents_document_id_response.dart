// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'data9.dart';

part 'delete_documents_document_id_response.freezed.dart';
part 'delete_documents_document_id_response.g.dart';

@Freezed()
abstract class DeleteDocumentsDocumentIdResponse with _$DeleteDocumentsDocumentIdResponse {
  const factory DeleteDocumentsDocumentIdResponse({
    required Data9 data,
  }) = _DeleteDocumentsDocumentIdResponse;
  
  factory DeleteDocumentsDocumentIdResponse.fromJson(Map<String, Object?> json) => _$DeleteDocumentsDocumentIdResponseFromJson(json);
}
