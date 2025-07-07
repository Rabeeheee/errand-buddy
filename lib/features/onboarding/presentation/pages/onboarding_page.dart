import 'package:errand_buddy/features/onboarding/data/services/onboarding_service.dart';
import 'package:errand_buddy/features/onboarding/presentation/widgets/onboarding_content.dart';
import 'package:errand_buddy/features/onboarding/presentation/widgets/onboarding_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';

// Define your OnboardingItem
class OnboardingItem {
  final String title;
  final String description;
  final String image;
  final Color color;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.image,
    required this.color,
  });
}

class OnboardingPage extends StatelessWidget {
  OnboardingPage({super.key});

  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  final List<OnboardingItem> _items = [
    OnboardingItem(
      title: 'Errand Buddy',
      description: 'Simplify shared errands together',
      image: "assets/images/onboarding_image_1.png",
      color: AppColors.primary,
    ),
    OnboardingItem(
      title: 'Set Priorities & Due Dates',
      description: 'Mark tasks with priority levels and due dates.',
      image: "assets/images/onboarding_image_2.png",
      color: AppColors.secondary,
    ),
    OnboardingItem(
      title: 'Automatic Escalation',
      description: 'Overdue tasks automatically escalate to ensure nothing is missed.',
      image: "assets/images/onboarding_image_3.png",
      color: AppColors.accent,
    ),
  ];

  void _handlePageChanged(BuildContext context, int index) {
    _currentPage.value = index;
  }

  void _completeOnboarding(BuildContext context) async {
    await OnboardingService.setOnboardingCompleted();
    if (context.mounted) {
      context.go('/tasks');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _items.length + 1, // Add one extra "page"
                onPageChanged: (index) {
                  if (index == _items.length) {
                    // User swiped past the last onboarding page
                    _completeOnboarding(context);
                  } else {
                    _handlePageChanged(context, index);
                  }
                },
                itemBuilder: (context, index) {
                  if (index == _items.length) {
                    // This is the "extra" page that triggers navigation
                    return Container(
                      color: AppColors.white,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  final item = _items[index];
                  return OnboardingContent(item: item);
                },
              ),
            ),
            //ONBOARDING INDICATOR
            OnboardingIndicator(
              itemCount: _items.length, // Keep this as _items.length, not +1
              currentPageNotifier: _currentPage,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}