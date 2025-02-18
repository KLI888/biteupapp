import 'package:flutter/material.dart';
import 'package:biteupcontent/pages/others/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late AnimationController _blurController;
  
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _blurAnimation;

  @override
  void initState() {
    super.initState();
    
    // Scale animation controller
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    // Fade animation controller
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    // Blur animation controller
    _blurController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    // Scale animation
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 60.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.05)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 40.0,
      ),
    ]).animate(_scaleController);

    // Fade animation
    _fadeAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 40.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.0)
            .chain(CurveTween(curve: Curves.linear)),
        weight: 60.0,
      ),
    ]).animate(_fadeController);

    // Blur animation
    _blurAnimation = Tween<double>(begin: 10, end: 0).animate(
      CurvedAnimation(
        parent: _blurController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Start animations sequence
    _startAnimations();
    _navigateToHome();
  }

  void _startAnimations() async {
    _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _blurController.forward();
    _scaleController.forward();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 3500));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1000),
          pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            );
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    _blurController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _scaleAnimation,
          _fadeAnimation,
          _blurAnimation,
        ]),
        builder: (context, child) {
          return Stack(
            children: [
              // Background with blur effect
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: const AssetImage('assets/splash/9.png'),
                    fit: BoxFit.cover,
                    opacity: 0.7,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
              
              // Main image with animations
              FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage('assets/splash/9.png'),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: _blurAnimation.value,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Optional: Gradient overlay for depth
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.transparent,
                      Colors.black.withOpacity(0.2),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}