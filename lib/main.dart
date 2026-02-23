import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/personality_test_welcome_screen.dart';
import 'screens/personality_test_questionnaire_screen.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_screen1.dart';
import 'screens/onboarding_screen2.dart';


//import 'screens/learning_path_screen.dart';
//import 'screens/quiz_screen.dart';
//import 'screens/progress_screen.dart';
//import 'screens/profile_screen.dart';

void main() {
  runApp(const StudySparkApp());
}

class StudySparkApp extends StatelessWidget {
  const StudySparkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/personality-test-welcome': (context) => const PersonalityTestWelcomeScreen(),
        '/home': (context) => const HomeScreen(),
        '/onboard1': (context) => const OnboardingScreen1(),
        '/onboard2': (context) => const OnboardingScreen2(),
        '/questionnaire': (context) => const PersonalityTestQuestionnaireScreen(),
        
        //'/learning-path': (context) => const LearningPathScreen(),
        //'/quiz': (context) => const QuizScreen(),
        //'/progress': (context) => const ProgressScreen(),
        //'/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
