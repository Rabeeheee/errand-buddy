import 'package:errand_buddy/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/entypo.dart';
import 'package:iconify_flutter/icons/ph.dart';

class CustomBottomNavBar extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;
  
  const CustomBottomNavBar({
    Key? key,
    required this.onTap,
    this.currentIndex = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
  BoxShadow(
    color: Colors.black.withOpacity(0.1), 
    blurRadius: 0,        
    spreadRadius: 0,     
    offset: Offset(0, -1), // move shadow up by 1 pixel (like a top border line)
  ),
],

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            icon: const Iconify(Ph.users_fill),
            label: 'Members',
            isSelected: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          _buildNavItem(
            iconData: Icons.format_list_bulleted,
            label: 'Tasks',
            isSelected: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          _buildNavItem(
            icon: const Iconify(Entypo.back_in_time),
            label: 'Escalations',
            isSelected: currentIndex == 2,
            onTap: () => onTap(2),
          ),
          _buildNavItem(
            icon: const Iconify(Ph.user_light),
            label: 'Profile',
            isSelected: currentIndex == 3,
            onTap: () => onTap(3),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    IconData? iconData,
    Widget? icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconData != null)
              Icon(
                iconData,
                color: isSelected ? Colors.black : AppColors.iconColor,
                size: 24,
              )
            else if (icon != null)
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  isSelected ? Colors.black : AppColors.iconColor,
                  BlendMode.srcIn,
                ),
                child: icon,
              ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.black : const Color(0xFF9E9E9E),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}