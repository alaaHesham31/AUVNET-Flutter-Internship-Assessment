import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  TextEditingController? controller;


   CustomInputField({
    super.key,
    required this.hintText,
    required this.icon,
    this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: AppStyle.regular14Grey,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppColors.darkGreyColor),
          hintText: hintText,
          filled: true,
          fillColor: AppColors.lightGreyColor,
          contentPadding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
