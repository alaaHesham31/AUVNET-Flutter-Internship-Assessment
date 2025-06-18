import 'package:ecommerce_app/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class RestaurantItem extends StatelessWidget {
  final String name;
  final String logo;
  final String time;

  const RestaurantItem({
    super.key,
    required this.name,
    required this.logo,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            color: Colors.grey.shade100,
            padding: const EdgeInsets.all(8),
            width: 70,
            height: 70,
            child: Image.asset(logo, fit: BoxFit.contain),
          ),
        ),
        const SizedBox(height: 8),
        Text(name,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: AppStyle.medium14Black),
        Row(
          children: [
            const Icon(Icons.access_time, size: 14, color: Colors.grey),
            const SizedBox(width: 4),
            Text(time, style: AppStyle.medium10Grey),
          ],
        ),
      ],
    );
  }
}
