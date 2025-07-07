import 'package:errand_buddy/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class OnboardingContent extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingContent({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.06, 
        vertical: screenHeight * 0.02,  
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
               item.image,
              height: screenHeight * 0.60, 
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: screenHeight * 0.04), 
          
          // Title
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeight * 0.02), // spacing below title
          
          // Description
          Text(
            item.description,
            style: TextStyle(
              fontSize: screenWidth * 0.04, // ~4% of screen width
              color: AppColors.grey,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
