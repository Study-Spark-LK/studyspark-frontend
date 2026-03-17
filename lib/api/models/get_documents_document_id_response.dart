// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'data7.dart';

part 'get_documents_document_id_response.freezed.dart';
part 'get_documents_document_id_response.g.dart';

@Freezed()
abstract class GetDocumentsDocumentIdResponse with _$GetDocumentsDocumentIdResponse {
  const factory GetDocumentsDocumentIdResponse({
    required Data7 data,
  }) = _GetDocumentsDocumentIdResponse;
  
  factory GetDocumentsDocumentIdResponse.fromJson(Map<String, Object?> json) => _$GetDocumentsDocumentIdResponseFromJson(json);
}
