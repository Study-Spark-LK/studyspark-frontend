// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/delete_documents_document_id_response.dart';
import '../models/documents_request_body.dart';
import '../models/get_documents_document_id_response.dart';
import '../models/get_documents_response.dart';
import '../models/post_documents_response.dart';
import '../models/put_documents_document_id_response.dart';

part 'documents_client.g.dart';

@RestApi()
abstract class DocumentsClient {
  factory DocumentsClient(Dio dio, {String? baseUrl}) = _DocumentsClient;

  @GET('/documents')
  Future<GetDocumentsResponse> getDocuments({
    @Query('category') String? category,
    @Query('page') num? page,
  });

  @POST('/documents')
  Future<PostDocumentsResponse> postDocuments({
    @Body() DocumentsRequestBody? body,
  });

  @GET('/documents/{documentId}')
  Future<GetDocumentsDocumentIdResponse> getDocumentsDocumentId({
    @Path('documentId') required String documentId,
  });

  @PUT('/documents/{documentId}')
  Future<PutDocumentsDocumentIdResponse> putDocumentsDocumentId({
    @Path('documentId') required String documentId,
    @Query('progress') required num progress,
  });

  @DELETE('/documents/{documentId}')
  Future<DeleteDocumentsDocumentIdResponse> deleteDocumentsDocumentId({
    @Path('documentId') required String documentId,
  });
}
