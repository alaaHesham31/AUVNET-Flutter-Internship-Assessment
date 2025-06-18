import 'package:ecommerce_app/core/utils/app_images.dart';
import 'package:ecommerce_app/core/utils/app_style.dart';
import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';

class CustomAppbar extends StatelessWidget {

  final String name;
  final String address;

  const CustomAppbar({
    super.key,
    required this.name,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryColor, AppColors.yellowColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Delivering to", style: AppStyle.bold12Black),
                SizedBox(height: 4),
                Text(address, style: AppStyle.bold16Black),

                SizedBox(height: 16),
                Text("Hi $name!", style: AppStyle.bold30White),

              ],
            ),
          ),
          CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage(
              AppImages.userAvatar, // placeholder image
            ),
          ),
        ],
      ),
    );
  }
}
