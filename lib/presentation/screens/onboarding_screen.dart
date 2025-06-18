import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/core/utils/app_images.dart';
import 'package:ecommerce_app/core/utils/app_style.dart';
import 'package:ecommerce_app/presentation/blocs/onboarding/onboarding_bloc.dart';
import 'package:ecommerce_app/presentation/blocs/onboarding/onboarding_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/onboarding/onboarding_state.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "all-in-one delivery",
      "desc":
          "Order groceries, medicines, and meals delivered straight to your door"
    },
    {
      "title": "User-to-User Delivery",
      "desc": "Send or receive items from other users quickly and easily"
    },
    {
      "title": "Sales & Discounts",
      "desc": "Discover exclusive sales and deals every day"
    },
  ];

  void nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _controller.nextPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state.hasSeenOnboarding) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Stack(
          children: [
            // Top overlapping circles
            SizedBox(
              height: screenHeight * 0.5,
              child: Stack(
                children: [
                  Positioned(
                    top: -screenHeight * 0.15,
                    left: -screenWidth * 0.4,
                    child: Container(
                      width: screenWidth * 1.05,
                      height: screenWidth * 1.05,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.yellowColor
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.1,
                    left: screenWidth * 0.06,
                    child: Container(
                      width: screenWidth * 0.7,
                      height: screenWidth * 0.7,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.whiteColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(AppImages.nawelLogo),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Bottom gradient background
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.whiteColor,
                      AppColors.whiteColor,
                     AppColors.greenColor,
                    ],
                  ),
                ),
              ),
            ),
            // Main Content
            Column(
              children: [
                SizedBox(height: screenHeight * 0.6),
                Expanded(
                  child: BlocListener<OnboardingBloc, OnboardingState>(
                    listener: (context, state) {
                      if (state.hasSeenOnboarding) {
                        Navigator.pushReplacementNamed(context, '/login');
                      }
                    },
                    child: PageView.builder(
                      controller: _controller,
                      itemCount: onboardingData.length,
                      onPageChanged: (index) =>
                          setState(() => _currentPage = index),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            children: [
                              Text(
                                onboardingData[index]['title']!,
                                textAlign: TextAlign.center,
                                style:AppStyle.medium28Black
                              ),
                              const SizedBox(height: 16),
                              Text(
                                onboardingData[index]['desc']!,
                                textAlign: TextAlign.center,
                                style: AppStyle.regular14Grey,
                              ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<OnboardingBloc>()
                                      .add(CompleteOnboarding());
                                  Navigator.pushReplacementNamed(
                                      context, "/login");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF7A00F2),
                                  minimumSize: const Size.fromHeight(50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child:  Text("Get Started",
                                    style: AppStyle.medium18White),
                              ),
                              const SizedBox(height: 8),
                              TextButton(
                                  onPressed: nextPage,
                                  child:  Text("next",
                                      style: AppStyle.regular14Grey)),
                              const SizedBox(height: 32),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
