import 'package:fitness/screens/auth/presentation/screen/login_screen.dart';
import 'package:fitness/screens/profile/presentation/screen/complete_profile.dart';
import 'package:fitness/screens/splash/logic/splash_cubit.dart';
import 'package:fitness/screens/splash/logic/splash_state.dart';
import 'package:fitness/screens/splash/presentation/widget/circle_progress_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness/core/constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});



  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _circleController;
  late Animation<double> _circleAnimation;

  @override
  void initState() {
    super.initState();
    // Animates the progress indicator from 0% to 100% full circle
    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _circleAnimation = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(
        parent: _circleController,
        curve: Curves.easeInOut,
      ),
    );

    _circleController.forward();
  }

  @override
  void dispose() {
    _circleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..startSplash(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          // Navigates only when the circle animation completes
          _circleController.addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              if (state is SplashUnauthenticated) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false,
                );
              } else if (state is SplashAuthenticated) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => CompleteProfile()),
                      (route) => false,
                );
              }
            }
          });
        },
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFE8F5E9),
                  Color(0xFFDCEDC8),
                  Color(0xFFE8F5E9),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  // App Title
                  const Text(
                    "Vitality Logic",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                  const Spacer(),

                  // Circular Progress Indicator & Center Logo
                  AnimatedBuilder(
                    animation: _circleAnimation,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: CircleProgressPainter(
                          progress: _circleAnimation.value,
                          color: AppColors.primaryGreen,
                        ),
                        child: Container(
                          width: 260,
                          height: 260,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Replace Icon with Image.asset if needed
                              const Icon(
                                Icons.eco,
                                size: 40,
                                color: AppColors.primaryGreen,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "PREMIUM WELLNESS",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.2,
                                  color: AppColors.primaryGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 36),


                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      "Fuel your journey, master your health.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C3E50),
                        height: 1.3,
                      ),
                    ),
                  ),


                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

