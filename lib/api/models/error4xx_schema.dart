// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'error4xx_schema_code.dart';

part 'error4xx_schema.freezed.dart';
part 'error4xx_schema.g.dart';

@Freezed()
abstract class Error4xxSchema with _$Error4xxSchema {
  const factory Error4xxSchema({
    required Error4xxSchemaCode code,
    required String message,
  }) = _Error4xxSchema;
  
  factory Error4xxSchema.fromJson(Map<String, Object?> json) => _$Error4xxSchemaFromJson(json);
}
