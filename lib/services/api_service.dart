import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/subject.dart';

class ApiService {
  ApiService({
    http.Client? client,
    this.authToken,
  }) : _client = client ?? http.Client();

  static const String _fallbackBaseUrl = 'http://YOUR_BACKEND_URL:PORT/api';
  static const String _envBaseUrl = String.fromEnvironment('API_BASE_URL');
  static const Duration _requestTimeout = Duration(seconds: 15);

  final http.Client _client;
  final String? authToken;

  String get _baseUrl {
    final configuredBaseUrl = _envBaseUrl.trim();
    if (configuredBaseUrl.isNotEmpty) {
      return configuredBaseUrl;
    }
    if (_fallbackBaseUrl.contains('YOUR_BACKEND_URL')) {
      throw Exception(
        'API base URL is not configured. '
        'Pass --dart-define=API_BASE_URL=http://<host>:<port>/api when running the app.',
      );
    }
    return _fallbackBaseUrl;
  }

  Map<String, String> get _headers {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (authToken != null && authToken!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $authToken';
    }
    return headers;
  }

  Future<List<Subject>> fetchSubjects() async {
    try {
      final response = await _client
          .get(
            Uri.parse('$_baseUrl/subjects'),
            headers: _headers,
          )
          .timeout(_requestTimeout);

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is! List) {
          throw const FormatException(
            'Invalid response format: expected a JSON array.',
          );
        }
        return decoded
            .map((item) => Subject.fromJson(item as Map<String, dynamic>))
            .toList();
      }

      throw Exception(
        'Failed to load subjects (${response.statusCode}): ${response.reasonPhrase ?? 'Unknown error'}',
      );
    } on TimeoutException {
      throw Exception('Request timed out while fetching subjects.');
    } on SocketException {
      throw Exception('No internet connection or backend is unreachable.');
    } on FormatException catch (e) {
      throw Exception('Invalid data received from server: ${e.message}');
    } catch (e) {
      throw Exception('Error fetching subjects: $e');
    }
  }

  // Add more API methods as needed
  // Future<Subject> fetchSubjectById(String id) async { ... }
  // Future<void> updateProgress(String subjectId, int completedLessons) async { ... }
}
