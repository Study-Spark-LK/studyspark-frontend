import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:studyspark/screens/upload_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/questionnaire_welcome_screen.dart';
import 'screens/questionnaire_screen.dart';
import 'screens/main_shell.dart';
import 'screens/onboarding_screen1.dart';
import 'screens/onboarding_screen4.dart';
import 'screens/onboarding_screen2.dart';
import 'screens/onboarding_screen3.dart';
import 'screens/Library_screen.dart';
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
          initialRoute: '/',
          // home: ClerkErrorListener(
          //   child: ClerkAuthBuilder(
          //     signedInBuilder: (context, authState) {
          //       Future<bool> checkIfUserHasProfiles() async {
          //         try {
          //           final token = ClerkAuth.of(context).session?.lastActiveToken?.jwt;
          //           if (token != null) {
          //             rawDio.options.headers['Authorization'] = 'Bearer $token';
          //           }
          //
          //           final res = await rawDio.get('/profiles?status=all');
          //           final profilesList = res.data['data'] as List?;
          //
          //           if (profilesList != null && profilesList.isNotEmpty) {
          //             return true;
          //           }
          //
          //           return false;
          //
          //         } catch (_) {
          //           return false;
          //         }
          //       }
          //       return FutureBuilder<bool>(
          //         future: checkIfUserHasProfiles(),
          //         builder: (context, snapshot) {
          //
          //           if (snapshot.connectionState == ConnectionState.waiting) {
          //             return const Scaffold(
          //               backgroundColor: Color(0xFF1A1A2E),
          //               body: Center(
          //                 child: CircularProgressIndicator(color: Color(0xFF6C63FF)),
          //               ),
          //             );
          //           }
          //
          //           final hasProfiles = snapshot.data ?? false;
          //
          //           if (hasProfiles) {
          //             return const MainShell();
          //           } else {
          //             return const QuestionnaireWelcomeScreen();
          //           }
          //         },
          //       );
          //     },
          //     signedOutBuilder: (context, authState) => const LoginScreen(),
          //   ),
          // ),
          routes: {
            '/': (context) => const SplashScreen(),
            '/auth-check': (context) => ClerkErrorListener(
              child: ClerkAuthBuilder(
                signedInBuilder: (context, authState) {

                  // Set the token bridge for the whole app
                  fetchClerkToken = () async {
                    return ClerkAuth.of(context).session?.lastActiveToken?.jwt;
                  };

                  Future<bool> checkIfUserHasProfiles() async {
                    try {
                      final token = ClerkAuth.of(context).session?.lastActiveToken?.jwt;
                      if (token != null) {
                        rawDio.options.headers['Authorization'] = 'Bearer $token';
                      }

                      final res = await rawDio.get('/profiles?status=all');
                      final profilesList = res.data['data'] as List?;

                      if (profilesList != null && profilesList.isNotEmpty) {
                        return true;
                      }

                      return false;
                    } catch (_) {
                      return false;
                    }
                  }

                  return FutureBuilder<bool>(
                    future: checkIfUserHasProfiles(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Scaffold(
                          backgroundColor: Color(0xFF1A1A2E),
                          body: Center(
                            child: CircularProgressIndicator(color: Color(0xFF6C63FF)),
                          ),
                        );
                      }

                      final hasProfiles = snapshot.data ?? false;

                      if (hasProfiles) {
                        return const MainShell();
                      } else {
                        return const QuestionnaireWelcomeScreen();
                      }
                    },
                  );
                },
                signedOutBuilder: (context, authState) => const LoginScreen(),
              ),
            ),
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
