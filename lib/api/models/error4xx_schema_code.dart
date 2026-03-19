// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum Error4xxSchemaCode {
  @JsonValue('input_validation_error')
  inputValidationError('input_validation_error'),
  @JsonValue('authentication_required')
  authenticationRequired('authentication_required'),
  @JsonValue('profile-not-found')
  profileNotFound('profile-not-found'),
  @JsonValue('profile-not-ready')
  profileNotReady('profile-not-ready'),
  @JsonValue('document-not-found')
  documentNotFound('document-not-found'),
  @JsonValue('invalid_file')
  invalidFile('invalid_file'),
  @JsonValue('file_not_found')
  fileNotFound('file_not_found'),
  @JsonValue('file_too_large')
  fileTooLarge('file_too_large'),
  @JsonValue('unknown error')
  unknownError('unknown error'),
  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const Error4xxSchemaCode(this.json);

  factory Error4xxSchemaCode.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;

  @override
  String toString() => json?.toString() ?? super.toString();
  /// Returns all defined enum values excluding the $unknown value.
  static List<Error4xxSchemaCode> get $valuesDefined => values.where((value) => value != $unknown).toList();
}
