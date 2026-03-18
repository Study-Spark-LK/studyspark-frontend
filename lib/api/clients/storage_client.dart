// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/post_storage_files_response.dart';

part 'storage_client.g.dart';

@RestApi()
abstract class StorageClient {
  factory StorageClient(Dio dio, {String? baseUrl}) = _StorageClient;

  @POST('/storage/files')
  Future<PostStorageFilesResponse> postStorageFiles({
    @Header('content-length') required String contentLength,
    @Header('x-file-name') String? xFileName,
    @Body() MultipartFile? body,
  });

  @GET('/storage/files/{id}')
  @DioResponseType(ResponseType.stream)
  Stream<String> getStorageFilesId({
    @Path('id') required String id,
  });
}
