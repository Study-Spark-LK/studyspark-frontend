// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'qna.freezed.dart';
part 'qna.g.dart';

@Freezed()
abstract class Qna with _$Qna {
  const factory Qna({
    required String question,
    required String answer,
  }) = _Qna;
  
  factory Qna.fromJson(Map<String, Object?> json) => _$QnaFromJson(json);
}
