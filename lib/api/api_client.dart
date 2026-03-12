import 'package:dio/dio.dart';
import 'package:studyspark/api/rest_client.dart';
import 'package:flutter/foundation.dart';
import 'package:studyspark/env.dart';

Future<String?> Function()? fetchClerkToken;


String getBaseUrl() {
  if (Env.apiBaseUrl.isNotEmpty) {
    return Env.apiBaseUrl;
  }
  if (kIsWeb) {
    // web
    return 'http://localhost:8787';
  } else {
    // android
    return 'http://10.0.2.2:8787';
  }
}

Dio buildDioClient() {
  final dio = Dio(
    BaseOptions(
      baseUrl: getBaseUrl(),
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: 'application/json',
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        try {
          if (fetchClerkToken != null) {
            final token = await fetchClerkToken!();

            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
        } catch (e) {
          print('Error fetching Clerk token: $e');
        }

        return handler.next(options);
      },
        onError: (DioException error, handler) {
          if (error.response?.statusCode == 401) {
            print("User is unauthorized. Token might be invalid or expired.");
          }
          return handler.next(error);
        }
    ),
  );

  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  return dio;
}

final apiClient = RestClient(buildDioClient());