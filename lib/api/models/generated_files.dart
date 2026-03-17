// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'type.dart';

part 'generated_files.freezed.dart';
part 'generated_files.g.dart';

@Freezed()
abstract class GeneratedFiles with _$GeneratedFiles {
  const factory GeneratedFiles({
    required String fileId,
    required Type type,
  }) = _GeneratedFiles;
  
  factory GeneratedFiles.fromJson(Map<String, Object?> json) => _$GeneratedFilesFromJson(json);
}
