import 'package:errand_buddy/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/entypo.dart';
import 'package:iconify_flutter/icons/ph.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        _buildNavItem(
  icon: Iconify(Ph.user_fill),
  label: 'Members',
  isSelected: false,
),
_buildNavItem(
  iconData: Icons.format_list_bulleted,
  label: 'Tasks',
  isSelected: true,
),
_buildNavItem(
  icon: Iconify(Entypo.back_in_time),
  label: 'Escalations',
  isSelected: false,
),
_buildNavItem(
  icon: Iconify(Ph.user_light),
  label: 'Profile',
  isSelected: false,
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
}) {
  final iconColor = isSelected ? AppColors.black : AppColors.iconColor;

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      if (iconData != null)
        Icon(
          iconData,
          color: iconColor,
          size: 24,
        )
      else if (icon != null)
        // Wrap the icon in IconTheme to give color & size
        IconTheme(
          data: IconThemeData(
            color: iconColor,
            size: 24,
          ),
          child: icon,
        ),
      const SizedBox(height: 4),
      Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: iconColor,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    ],
  );
}
}