import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:errand_buddy/features/onboarding/data/services/onboarding_service.dart'; // Add this import

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    // Wait for 3 seconds to show splash screen
    await Future.delayed(const Duration(seconds: 3));
    
    if (mounted) {
      // Check if onboarding is completed
      final isOnboardingCompleted = await OnboardingService.isOnboardingCompleted();
      
      if (isOnboardingCompleted) {
        context.go('/tasks');
      } else {
        context.go('/onboarding');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 140,
                width: 140,
                child: Image.asset("assets/logo/logo.png"),
              ),
              Text(
                AppStrings.appName,
                style: GoogleFonts.playpenSans(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}