import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/subject.dart';

class ApiService {
  // TODO: Get this URL from your backend team
  static const String baseUrl = 'http://YOUR_BACKEND_URL:PORT/api';
  
  // You might need to add authentication headers
  // static String? authToken;
  
  Future<List<Subject>> fetchSubjects() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/subjects'),
        // Uncomment if you need auth headers:
        // headers: {
        //   'Content-Type': 'application/json',
        //   'Authorization': 'Bearer $authToken',
        // },
      );
      
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Subject.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load subjects: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching subjects: $e');
    }
  }
  
  // Add more API methods as needed
  // Future<Subject> fetchSubjectById(String id) async { ... }
  // Future<void> updateProgress(String subjectId, int completedLessons) async { ... }
}