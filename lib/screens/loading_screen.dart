import 'package:flutter/material.dart';
import 'lesson_created_screen.dart';

class LoadingScreen extends StatefulWidget {
  final String lessonName;
  final String hobby;

  LoadingScreen({this.lessonName = "Biology", this.hobby = "Photography"});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    _simulateLoading();
  }

  void _simulateLoading() {
    // Simulate loading progress
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        progress += 0.2;
        if (progress < 1.0) {
          _simulateLoading();
        } else {
          // Navigate to Lesson Created screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => LessonCreatedScreen(
                lessonName: widget.lessonName,
                hobby: widget.hobby,
              ),
            ),
          );
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1117),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Upload Learning Material",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            // Title
            const Text(
              "Creating your lesson",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),

            const SizedBox(height: 12),

            // Subtitle
            Text(
              "Analyzing content and converting it...",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 40),

            // Circular Progress
            SizedBox(
              width: 130,
              height: 130,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 8,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    valueColor: const AlwaysStoppedAnimation(
                      Color(0xFF7C4DFF),
                    ),
                  ),
                  Text(
                    "${(progress * 100).toInt()}%",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              "Loading...",
              style: TextStyle(color: Colors.white54, fontSize: 13),
            ),

            const SizedBox(height: 40),

            // Steps
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStep("Extracting content from PDF"),
                _buildStep("Analyzing learning concepts"),
                _buildStep("Creating smart lesson"),
              ],
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
Widget _buildStep(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.check_circle, color: Colors.greenAccent, size: 18),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            color: Colors.white.withOpacity(0.85),
            fontSize: 13,
          ),
        ),
      ],
    ),
  );
}