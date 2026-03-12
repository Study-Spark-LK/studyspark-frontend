// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'documents_request_body.freezed.dart';
part 'documents_request_body.g.dart';

@Freezed()
abstract class DocumentsRequestBody with _$DocumentsRequestBody {
  const factory DocumentsRequestBody({
    required String fileId,
    required String profileId,
  }) = _DocumentsRequestBody;
  
  factory DocumentsRequestBody.fromJson(Map<String, Object?> json) => _$DocumentsRequestBodyFromJson(json);
}
