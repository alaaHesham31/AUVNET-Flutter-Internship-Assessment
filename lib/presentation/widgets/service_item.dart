import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_style.dart';

class ServiceItem extends StatelessWidget {
  final String image;
  final String label;
  final String tag;
  final bool isNetworkImage;

  const ServiceItem({
    super.key,
    required this.image,
    required this.label,
    required this.tag,
    this.isNetworkImage = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Image.asset(image),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(tag, style: AppStyle.medium14White),
        ),
        const SizedBox(height: 4),
        Text(label, textAlign: TextAlign.center, style: AppStyle.medium14Black),
      ],
    );
  }
}
