import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class OnboardingIndicator extends StatelessWidget {
  final int itemCount;
  final ValueNotifier<int> currentPageNotifier;

  const OnboardingIndicator({
    super.key,
    required this.itemCount,
    required this.currentPageNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: currentPageNotifier,
      builder: (context, currentPage, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(itemCount, (index) {
            final isSelected = currentPage == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.lightGrey,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        );
      },
    );
  }
}
