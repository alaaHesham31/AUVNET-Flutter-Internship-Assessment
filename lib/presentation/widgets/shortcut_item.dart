import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class ShortcutItem extends StatelessWidget {
  final String image;
  final String label;

  const ShortcutItem({
    super.key,
    required this.image,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.semounColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Image.asset(image, height: 40, width: 40),
        ),
        const SizedBox(height: 24),
        Text(label, style: AppStyle.medium14Black),
      ],
    );
  }
}
