import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
// import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/questionnaire_welcome_screen.dart';
import 'screens/questionnaire_screen.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_screen1.dart';
import 'screens/onboarding_screen4.dart';
import 'screens/onboarding_screen2.dart';
import 'screens/onboarding_screen3.dart';
import 'screens/file_upload_screen.dart';
import 'package:studyspark/env.dart';
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
                final auth = ClerkAuth.of(context);
                final user = auth.user;
                print("Email1: ${user?.email}");
                print("Username: ${user?.username}");
                print("firstName: ${user?.firstName}");
                print("lastName: ${user?.lastName}");
                return const QuestionnaireWelcomeScreen();
              },
              signedOutBuilder: (context, authState) => const LoginScreen(),
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
            '/home': (context) => const HomeScreen(),
            '/onboard1': (context) => const OnboardingScreen1(),
            '/onboard2': (context) => const OnboardingScreen2(),
            '/onboard3': (context) => const OnboardingScreen3(),
            '/onboard4': (context) => const OnboardingScreen4(),
            '/questionnaire': (context) => const PersonalityTestQuestionnaireScreen(),
            '/upload': (context) => const FileUploadScreen(),
            //'/learning-path': (context) => const LearningPathScreen(),
            //'/quiz': (context) => const QuizScreen(),
            //'/progress': (context) => const ProgressScreen(),
            //'/profile': (context) => const ProfileScreen(),
          },
        ),

    );

  }
}
