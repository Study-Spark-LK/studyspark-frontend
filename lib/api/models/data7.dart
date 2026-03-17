// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'status.dart';
import 'generated_files.dart';

part 'data7.freezed.dart';
part 'data7.g.dart';

@Freezed()
abstract class Data7 with _$Data7 {
  const factory Data7({
    required String id,
    required String profileId,
    required Status status,
    required String title,
    required String description,
    required String category,
    required num progressPercentage,
    required String originalFileId,
    required List<GeneratedFiles> generatedFiles,
  }) = _Data7;
  
  factory Data7.fromJson(Map<String, Object?> json) => _$Data7FromJson(json);
}
