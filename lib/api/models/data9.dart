// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'status.dart';

part 'data9.freezed.dart';
part 'data9.g.dart';

@Freezed()
abstract class Data9 with _$Data9 {
  const factory Data9({
    required String id,
    required String profileId,
    required Status status,
  }) = _Data9;
  
  factory Data9.fromJson(Map<String, Object?> json) => _$Data9FromJson(json);
}
