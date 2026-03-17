// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'status3.dart';

part 'data3.freezed.dart';
part 'data3.g.dart';

@Freezed()
abstract class Data3 with _$Data3 {
  const factory Data3({
    required String id,
    required String name,
    required Status3 status,
  }) = _Data3;
  
  factory Data3.fromJson(Map<String, Object?> json) => _$Data3FromJson(json);
}
