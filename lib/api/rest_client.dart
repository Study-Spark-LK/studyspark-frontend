// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';

import 'clients/storage_client.dart';
import 'clients/profiles_client.dart';
import 'clients/documents_client.dart';

/// StudySpark Internal API `v1.0.0`
class RestClient {
  RestClient(
    Dio dio, {
    String? baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  final Dio _dio;
  final String? _baseUrl;

  static String get version => '1.0.0';

  StorageClient? _storage;
  ProfilesClient? _profiles;
  DocumentsClient? _documents;

  StorageClient get storage => _storage ??= StorageClient(_dio, baseUrl: _baseUrl);

  ProfilesClient get profiles => _profiles ??= ProfilesClient(_dio, baseUrl: _baseUrl);

  DocumentsClient get documents => _documents ??= DocumentsClient(_dio, baseUrl: _baseUrl);
}
