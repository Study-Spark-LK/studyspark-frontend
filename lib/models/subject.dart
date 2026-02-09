import 'package:flutter/material.dart';

class Subject {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final double progress;
  final int totalLessons;
  final int completedLessons;

  Subject({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.progress,
    required this.totalLessons,
    required this.completedLessons,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'].toString(),
      name: json['name'],
      icon: _getIconFromString(json['icon'] ?? 'book'),
      color: _getColorFromString(json['color'] ?? 'blue'),
      progress: (json['progress'] ?? 0.0).toDouble(),
      totalLessons: json['totalLessons'] ?? 0,
      completedLessons: json['completedLessons'] ?? 0,
    );
  }

  static IconData _getIconFromString(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'calculate':
      case 'math':
      case 'mathematics':
        return Icons.calculate;
      case 'science':
        return Icons.science;
      case 'book':
      case 'english':
        return Icons.menu_book;
      case 'history':
        return Icons.history_edu;
      case 'physics':
        return Icons.science;
      case 'chemistry':
        return Icons.biotech;
      default:
        return Icons.book;
    }
  }

  static Color _getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'orange':
        return Colors.orange;
      case 'brown':
        return Colors.brown;
      case 'teal':
        return Colors.teal;
      case 'purple':
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }
}