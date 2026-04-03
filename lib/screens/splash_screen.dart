import 'package:flutter/material.dart'; // Flutter framework
import 'dart:async'; // For timing animations


// Splash screen with animated logo and tagline sequence
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

//State class with multiple animation controllers for logo and tagline sequence
class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  // Animation controllers for each element in the sequence    
  late AnimationController _logoController;
  late AnimationController _line1Controller;
  late AnimationController _line2Controller;
  late AnimationController _line3Controller;
  late AnimationController _brandController;


  // Animations for fading in each element
  late Animation<double> _logoFadeIn;
  late Animation<double> _line1FadeIn;
  late Animation<double> _line2FadeIn;
  late Animation<double> _line3FadeIn;
  late Animation<double> _brandFadeIn;


  //Visibility control variables
  bool _showLogo = true;
  bool _showLine1 = false;
  bool _showLine2 = false;
  bool _showLine3 = false;
  bool _showBrand = false;

  @override
  void initState() {
    super.initState();

    // Initialize all controllers withdurations and vsync
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _line1Controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _line2Controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _line3Controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _brandController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Create animations for fading in each element with easeIn curves
    _logoFadeIn = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeIn));

    _line1FadeIn = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _line1Controller, curve: Curves.easeIn));

    _line2FadeIn = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _line2Controller, curve: Curves.easeIn));

    _line3FadeIn = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _line3Controller, curve: Curves.easeIn));

    _brandFadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _brandController, curve: Curves.easeInOut),
    );

    // Start animation sequence
    _startAnimationSequence();

    // Navigate to login after all animations complete (increased to ~16 seconds)
    Timer(const Duration(milliseconds: 3000), () {
      Navigator.of(context).pushReplacementNamed('/signup');
    });
  }

  void _startAnimationSequence() async {
    // Fade in logo
    await _logoController.forward();

    // Hold logo (increased)
    await Future.delayed(const Duration(milliseconds: 400));

    //  Fade out logo
    await _logoController.reverse();

    // Pause before tagline
    await Future.delayed(const Duration(milliseconds: 200));

    setState(() {
      _showLogo = false;
      _showLine1 = true;
    });

    // Show "Your Path." (increased delay)
    await _line1Controller.forward();
    await Future.delayed(const Duration(milliseconds: 200));

    setState(() {
      _showLine2 = true;
    });

    //Show "Your pace." (increased delay)
    await _line2Controller.forward();
    await Future.delayed(const Duration(milliseconds: 200));

    setState(() {
      _showLine3 = true;
    });

    //Show "Your Spark..." (increased delay)
    await _line3Controller.forward();
    await Future.delayed(const Duration(milliseconds: 300));

    setState(() {
      _showBrand = true;
    });

    //Show StudySpark brand (increased delay before appearing)
    await _brandController.forward();

    // Hold final screen (increased)
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _logoController.dispose();
    _line1Controller.dispose();
    _line2Controller.dispose();
    _line3Controller.dispose();
    _brandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: Center(
        child: Stack(
          children: [
            // Logo
            if (_showLogo)
              FadeTransition(
                opacity: _logoFadeIn,
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 200,
                    height: 200,
                  ),
                ),
              ),

            // Tagline and Brand
            if (!_showLogo)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Line 1: "Your Path."
                    if (_showLine1)
                      FadeTransition(
                        opacity: _line1FadeIn,
                        child: const Text(
                          '" Your Path.',
                          style: TextStyle(
                            fontSize: 34,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                            letterSpacing: 1.5,
                            height: 2.0,
                          ),
                        ),
                      ),

                    // Line 2: "Your pace."
                    if (_showLine2)
                      FadeTransition(
                        opacity: _line2FadeIn,
                        child: const Text(
                          'Your pace.',
                          style: TextStyle(
                            fontSize: 34,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF6C63FF),
                            letterSpacing: 1.5,
                            height: 2.0,
                          ),
                        ),
                      ),

                    // Line 3: "Your Spark..."
                    if (_showLine3)
                      FadeTransition(
                        opacity: _line3FadeIn,
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 34,
                              fontStyle: FontStyle.italic,
                              letterSpacing: 1.5,
                              height: 2.0,
                            ),
                            children: [
                              TextSpan(
                                text: 'Your ',
                                style: TextStyle(color: Colors.white),
                              ),
                              TextSpan(
                                text: 'Spark',
                                style: TextStyle(
                                  color: Color(0xFFFFD700),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: '..."',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),

                    // Spacer for better separation
                    if (_showBrand) const SizedBox(height: 80),

                    // StudySpark Brand with divider
                    if (_showBrand)
                      FadeTransition(
                        opacity: _brandFadeIn,
                        child: Column(
                          children: [
                            // Optional decorative line
                            Container(
                              width: 100,
                              height: 1,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Color.fromRGBO(255, 255, 255, 0.3),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'StudySpark',
                              style: TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                                letterSpacing: 5.0,
                                fontFamily: 'serif',
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
