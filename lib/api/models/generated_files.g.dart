// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generated_files.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GeneratedFiles _$GeneratedFilesFromJson(Map<String, dynamic> json) =>
    _GeneratedFiles(
      fileId: json['fileId'] as String,
      type: Type.fromJson(json['type'] as String),
    );

Map<String, dynamic> _$GeneratedFilesToJson(_GeneratedFiles instance) =>
    <String, dynamic>{
      'fileId': instance.fileId,
      'type': _$TypeEnumMap[instance.type]!,
    };

const _$TypeEnumMap = {
  Type.visual: 'visual',
  Type.audio: 'audio',
  Type.analytical: 'analytical',
  Type.story: 'story',
  Type.$unknown: r'$unknown',
};
