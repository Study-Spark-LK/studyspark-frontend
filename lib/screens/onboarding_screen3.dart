import 'package:flutter/material.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0B1020),
              Color(0xFF111827),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [

                const SizedBox(height: 50),

                Image.asset(
                  "assets/images/onboard3.png",
                  height: 280,
                ),

                const SizedBox(height: 40),

                const Text(
                  "Progress tracking",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  "Your Study Hours, Completed Lessons Can Be\nMonitored With Quiz Marks Along With The\nPerformance...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                    height: 1.6,
                  ),
                ),

                const Spacer(),

                 Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _dot(false),
                        _dot(false),
                        _dot(true),
                        _dot(false),
                      ],
                    ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CC2F1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/onboard4');
                    },
                    child: const Text("continue"),
                  ),
                ),

                const SizedBox(height: 14),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text(
                    "SKIP",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
Widget _dot(bool isActive) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    width: isActive ? 10 : 8,
    height: isActive ? 10 : 8,
    decoration: BoxDecoration(
      color: isActive ? const Color(0xFF4CC2F1) : Colors.white38,
      shape: BoxShape.circle,
    ),
  );
}