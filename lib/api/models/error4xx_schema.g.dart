// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error4xx_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Error4xxSchema _$Error4xxSchemaFromJson(Map<String, dynamic> json) =>
    _Error4xxSchema(
      code: Error4xxSchemaCode.fromJson(json['code'] as String),
      message: json['message'] as String,
    );

Map<String, dynamic> _$Error4xxSchemaToJson(_Error4xxSchema instance) =>
    <String, dynamic>{
      'code': _$Error4xxSchemaCodeEnumMap[instance.code]!,
      'message': instance.message,
    };

const _$Error4xxSchemaCodeEnumMap = {
  Error4xxSchemaCode.inputValidationError: 'input_validation_error',
  Error4xxSchemaCode.authenticationRequired: 'authentication_required',
  Error4xxSchemaCode.profileNotFound: 'profile-not-found',
  Error4xxSchemaCode.profileNotReady: 'profile-not-ready',
  Error4xxSchemaCode.documentNotFound: 'document-not-found',
  Error4xxSchemaCode.invalidFile: 'invalid_file',
  Error4xxSchemaCode.fileNotFound: 'file_not_found',
  Error4xxSchemaCode.fileTooLarge: 'file_too_large',
  Error4xxSchemaCode.unknownError: 'unknown error',
  Error4xxSchemaCode.$unknown: r'$unknown',
};
