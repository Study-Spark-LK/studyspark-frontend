// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'status.dart';

part 'data2.freezed.dart';
part 'data2.g.dart';

@Freezed()
abstract class Data2 with _$Data2 {
  const factory Data2({
    required String id,
    required String name,
    required Status status,
    @Default(0) num visualScore,
    @Default(0) num auditoryScore,
    @Default(0) num readingScore,
    @Default(0) num kinestheticScore,
    Object? createdAt,
    Object? updatedAt,
  }) = _Data2;
  
  factory Data2.fromJson(Map<String, Object?> json) => _$Data2FromJson(json);
}
