// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum Type {
  @JsonValue('visual')
  visual('visual'),
  @JsonValue('audio')
  audio('audio'),
  @JsonValue('analytical')
  analytical('analytical'),
  @JsonValue('story')
  story('story'),
  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const Type(this.json);

  factory Type.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;

  @override
  String toString() => json?.toString() ?? super.toString();
  /// Returns all defined enum values excluding the $unknown value.
  static List<Type> get $valuesDefined => values.where((value) => value != $unknown).toList();
}
