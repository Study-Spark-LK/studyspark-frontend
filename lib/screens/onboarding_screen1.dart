import 'package:flutter/material.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const Spacer(),

              Image.asset(
                "assets/images/onboard1.png",
                height: 260,
              ),

              const SizedBox(height: 40),

              const Text(
                "Learning That\nAdapts to You",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                "StudySpark transforms education with psychology-powered personalization.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white70,
                  height: 1.6,
                ),
              ),

              const Spacer(),
                Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                      _dot(true),
                      _dot(false),
                      _dot(false),
                      _dot(false),
                    ],
            ),
            const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF38BDF8),                 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context,'/onboard2');
                  },
                  child: const Text("Continue"),
                ),
              ),

              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text(
                  "SKIP",
                  style: TextStyle(color: Colors.white60),
                ),
              ),

              const SizedBox(height: 30),
            ],
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
      color: isActive ? const Color(0xFF38BDF8) : Colors.white38,
      shape: BoxShape.circle,
    ),
  );
}
