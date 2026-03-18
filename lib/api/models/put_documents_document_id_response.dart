// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'data8.dart';

part 'put_documents_document_id_response.freezed.dart';
part 'put_documents_document_id_response.g.dart';

@Freezed()
abstract class PutDocumentsDocumentIdResponse with _$PutDocumentsDocumentIdResponse {
  const factory PutDocumentsDocumentIdResponse({
    required Data8 data,
  }) = _PutDocumentsDocumentIdResponse;
  
  factory PutDocumentsDocumentIdResponse.fromJson(Map<String, Object?> json) => _$PutDocumentsDocumentIdResponseFromJson(json);
}
