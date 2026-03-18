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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Upload Learning Material"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              value: progress,
              color: Colors.blue,
              strokeWidth: 6,
            ),
            SizedBox(height: 30),
            Text(
              "Creating your lesson",
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Text(
              "Analyzing content and converting it to ${widget.hobby}...",
              style: TextStyle(color: Colors.grey[400]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("✓ Extracting content from PDF", style: TextStyle(color: Colors.greenAccent)),
                Text("✓ Analyzing learning concepts", style: TextStyle(color: Colors.greenAccent)),
                Text("✓ Creating hobby-based connections", style: TextStyle(color: Colors.greenAccent)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

//hobby selection screen
// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (_) => LoadingScreen(
//       lessonName: uploadedFileName,
//       hobby: selectedHobby,
//     ),
//   ),
// );