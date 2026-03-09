import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
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
      // Return mock data as fallback if API is not configured
      if (e.toString().contains('API base URL is not configured')) {
        return _getMockSubjects();
      }
      throw Exception('Error fetching subjects: $e');
    }
  }

  List<Subject> _getMockSubjects() {
    return [
      Subject(
        id: '1',
        name: 'Mathematics',
        icon: Icons.calculate,
        color: const Color(0xFF6C63FF),
        progress: 0.75,
        totalLessons: 20,
        completedLessons: 15,
      ),
      Subject(
        id: '2',
        name: 'English',
        icon: Icons.menu_book,
        color: const Color(0xFFFF6B6B),
        progress: 0.6,
        totalLessons: 18,
        completedLessons: 11,
      ),
      Subject(
        id: '3',
        name: 'Science',
        icon: Icons.science,
        color: const Color(0xFF4ECDC4),
        progress: 0.8,
        totalLessons: 22,
        completedLessons: 18,
      ),
      Subject(
        id: '4',
        name: 'History',
        icon: Icons.history_edu,
        color: const Color(0xFFFFD93D),
        progress: 0.5,
        totalLessons: 16,
        completedLessons: 8,
      ),
    ];
  }

  // Add more API methods as needed
  // Future<Subject> fetchSubjectById(String id) async { ... }
  // Future<void> updateProgress(String subjectId, int completedLessons) async { ... }
}
