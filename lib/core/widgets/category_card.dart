import 'package:fitness/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final Color backgroundColor;
  final Color iconColor;
  final bool isSelected; // Added isSelected flag
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.iconPath,
    required this.backgroundColor,
    required this.iconColor,
    this.isSelected = false, // Default to false
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Circular Icon Container with Active Border
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColors.primary : Colors.transparent,
                width: 2.0,
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(
                iconColor,
                BlendMode.srcIn,
              ),
              placeholderBuilder: (context) => Icon(
                Icons.category_outlined,
                color: iconColor,
                size: 24,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Category Title Text - Changes color when selected
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? AppColors.primary : const Color(0xFF4A4E5A),
            ),
          ),
        ],
      ),
    );
  }
}