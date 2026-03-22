import 'package:flutter/material.dart';
import 'package:clerk_flutter/clerk_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Layer 1 — decorative glow
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0x266C63FF), Colors.transparent],
                ),
              ),
            ),
          ),

          // Layer 2 — main content
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // TOP: branding
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          color: Color(0xFF6C63FF),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: const Icon(
                          Icons.auto_stories,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'StudySpark',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Learn smarter, not harder',
                        style: TextStyle(
                          color: Color(0xFF6B7A99),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                // BOTTOM: Clerk card
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: const ClerkAuthentication(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
