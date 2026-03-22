import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:studyspark/screens/upload_screen.dart';
// import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/questionnaire_welcome_screen.dart';
import 'screens/questionnaire_screen.dart';
import 'screens/main_shell.dart';
import 'screens/onboarding_screen1.dart';
import 'screens/onboarding_screen4.dart';
import 'screens/onboarding_screen2.dart';
import 'screens/onboarding_screen3.dart';
import 'screens/library_screen.dart';
import 'screens/practice_screen.dart';
import 'screens/outputresult_screen.dart';
import 'package:studyspark/env.dart';
import 'package:studyspark/api/api_client.dart';
//import 'screens/learning_path_screen.dart';
//import 'screens/quiz_screen.dart';
//import 'screens/progress_screen.dart';
import 'screens/profile_screen.dart';
import "screens/premium_upgrade_screen.dart";
import 'screens/quiz_screen.dart';

void main() {
  runApp(const StudySparkApp());
}

class StudySparkApp extends StatelessWidget {
  const StudySparkApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ClerkAuth (
      config: ClerkAuthConfig(
        publishableKey: Env.clerkKey,
      ),
      child: MaterialApp(
        title: 'StudySpark',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          primaryColor: const Color(0xFF6C63FF),
          scaffoldBackgroundColor: const Color(0xFFF8F9FA),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6C63FF),
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Color(0xFF6C63FF),
            foregroundColor: Colors.white,
          ),
          cardTheme: const CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C63FF),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        // initialRoute: '/home',
        home: ClerkErrorListener(
          child: ClerkAuthBuilder(
            signedInBuilder: (context, authState) {
              Future<bool> checkIfUserHasProfiles() async {
                try {
                  final auth = ClerkAuth.of(context);
                  try {
                    final sessionToken = await auth.sessionToken();
                    rawDio.options.headers['Authorization'] =
                    'Bearer ${sessionToken.jwt}';
                  } catch (_) {
                    final jwt = auth.session?.lastActiveToken?.jwt;
                    if (jwt != null) {
                      rawDio.options.headers['Authorization'] = 'Bearer $jwt';
                    }
                  }

                  final res = await rawDio.get('/profiles?status=all');
                  final profilesList = res.data['data'] as List?;
                  return profilesList != null && profilesList.isNotEmpty;
                } catch (_) {
                  return false;
                }
              }

              return FutureBuilder<bool>(
                future: checkIfUserHasProfiles(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const _SplashScreen();
                  }

                  final hasProfiles = snapshot.data ?? false;

                  if (hasProfiles) {
                    // Replace the initial '/' route with '/home' so that
                    // back-navigation from any screen always returns to
                    // MainShell, never to this FutureBuilder / QuestionnaireWelcomeScreen.
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (context.mounted) {
                        Navigator.of(context).pushReplacementNamed('/home');
                      }
                    });
                    return const _SplashScreen();
                  } else {
                    return const QuestionnaireWelcomeScreen();
                  }
                },
              );
            },
            signedOutBuilder: (context, authState) {
              if (authState.client.isEmpty) {
                return const _SplashScreen();
              }
              return const LoginScreen();
            },
          ),
        ),
        routes: {
          // '/': (context) => const SplashScreen(),
          // '/auth-check': (context) => ClerkErrorListener(
          //   child: ClerkAuthBuilder(
          //     signedInBuilder: (context, authState) => const QuestionnaireWelcomeScreen(),
          //     signedOutBuilder: (context, authState) => const LoginScreen(),
          //   ),
          // ),
          // '/login': (context) => const LoginScreen(),
          '/personality-test-welcome': (context) => const QuestionnaireWelcomeScreen(),
          '/home': (context) => const MainShell(),
          '/library': (context) => const LibraryScreen(),
          '/upload': (context) => const UploadScreen(),
          '/onboard1': (context) => const OnboardingScreen1(),
          '/onboard2': (context) => const OnboardingScreen2(),
          '/onboard3': (context) => const OnboardingScreen3(),
          '/onboard4': (context) => const OnboardingScreen4(),
          '/questionnaire': (context) => const PersonalityTestQuestionnaireScreen(),
          '/output-result': (context) => const OutputresultScreen(),
          '/practice': (context) => const PracticeScreen(),
          '/profile': (context) => const ProfileScreen(),
          "/premium":(context) => const PremiumUpgradeScreen(),
          '/signup': (context) => const LoginScreen(),
          '/quiz': (context) => const QuizScreen(),
          //'/learning-path': (context) => const LearningPathScreen(),
          //'/quiz': (context) => const QuizScreen(),
          //'/progress': (context) => const ProgressScreen(),
          //'/profile': (context) => const ProfileScreen(),
        },
      ),

    );
  }
}

class _SplashScreen extends StatefulWidget {
  const _SplashScreen();

  @override
  State<_SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<_SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _pulse = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: Stack(
        children: [
          // Background glow blobs
          Positioned(
            top: -80,
            left: -60,
            child: AnimatedBuilder(
              animation: _pulse,
              builder: (_, __) => Opacity(
                opacity: 0.25 + _pulse.value * 0.15,
                child: Container(
                  width: 280,
                  height: 280,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(colors: [
                      Color(0xFF6C63FF),
                      Colors.transparent,
                    ]),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            right: -40,
            child: AnimatedBuilder(
              animation: _pulse,
              builder: (_, __) => Opacity(
                opacity: 0.2 + (1 - _pulse.value) * 0.15,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(colors: [
                      Color(0xFF4FC3F7),
                      Colors.transparent,
                    ]),
                  ),
                ),
              ),
            ),
          ),

          // Centre content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo with pulsing glow ring
                AnimatedBuilder(
                  animation: _pulse,
                  builder: (_, __) => Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6C63FF)
                              .withValues(alpha: 0.25 + _pulse.value * 0.35),
                          blurRadius: 32 + _pulse.value * 24,
                          spreadRadius: 4 + _pulse.value * 8,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: const Color(0xFF6C63FF),
                          child: const Icon(Icons.bolt,
                              color: Colors.white, size: 48),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // App name
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF6C63FF), Color(0xFF4FC3F7)],
                  ).createShader(bounds),
                  child: const Text(
                    'StudySpark',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Personalised learning, powered by AI',
                  style: TextStyle(
                    color: Color(0xFF6B7A99),
                    fontSize: 13,
                    letterSpacing: 0.2,
                  ),
                ),

                const SizedBox(height: 56),

                // Animated dots loader
                _DotsLoader(animation: _pulse),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DotsLoader extends StatelessWidget {
  const _DotsLoader({required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            // Each dot is offset in phase
            final phase = (animation.value + i / 3) % 1.0;
            final scale = 0.5 + (phase < 0.5 ? phase : 1 - phase);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Transform.scale(
                scale: scale,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.lerp(
                      const Color(0xFF6C63FF),
                      const Color(0xFF4FC3F7),
                      i / 2,
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
