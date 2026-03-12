// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/delete_profiles_response.dart';
import '../models/get_profiles_response.dart';
import '../models/post_profiles_response.dart';
import '../models/profiles_request_body.dart';
import '../models/profiles_request_body2.dart';
import '../models/status2.dart';

part 'profiles_client.g.dart';

@RestApi()
abstract class ProfilesClient {
  factory ProfilesClient(Dio dio, {String? baseUrl}) = _ProfilesClient;

  @GET('/profiles')
  Future<GetProfilesResponse> getProfiles({
    @Query('status') Status2? status = Status2.all,
  });

  @POST('/profiles')
  Future<PostProfilesResponse> postProfiles({
    @Body() ProfilesRequestBody? body,
  });

  @DELETE('/profiles')
  Future<DeleteProfilesResponse> deleteProfiles({
    @Body() ProfilesRequestBody2? body,
  });
}
