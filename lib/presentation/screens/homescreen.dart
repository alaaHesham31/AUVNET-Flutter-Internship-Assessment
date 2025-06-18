import 'package:ecommerce_app/core/utils/app_images.dart';
import 'package:ecommerce_app/presentation/widgets/custom_appbar.dart';
import 'package:ecommerce_app/presentation/widgets/promo_code_box.dart';
import 'package:ecommerce_app/presentation/widgets/restaurant_item.dart';
import 'package:ecommerce_app/presentation/widgets/service_item.dart';
import 'package:ecommerce_app/presentation/widgets/shortcut_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_style.dart';
import '../blocs/home/home_bloc.dart';
import '../blocs/home/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> shortcuts = [
    {'image': AppImages.pastOrder, 'label': 'Past orders'},
    {'image': AppImages.superSaver, 'label': 'Super Saver'},
    {'image': AppImages.mustTries, 'label': 'Must-tries'},
    {'image': AppImages.giveBack, 'label': 'Give Back'},
    {'image': AppImages.bestSeller, 'label': 'Best Sellers'},
  ];

  final List<String> promoImages = [
    AppImages.promo1,
    AppImages.promo1,
    AppImages.promo1,
  ];
  final List<Map<String, String>> restaurants = [
    {"name": "Allo Beirut", "time": "32 mins", "logo": AppImages.alloBeirutRes},
    {"name": "Laffah", "time": "38 mins", "logo": AppImages.laffahRes},
    {
      "name": "Falafil Al Rabiah Al kha...",
      "time": "44 mins",
      "logo": AppImages.falafilRes
    },
    {"name": "Barbar", "time": "34 mins", "logo": AppImages.barbarRes},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gradient AppBar
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    final user = state.userProfile;

                    return CustomAppbar(
                      name: user?.name ?? 'User',
                      address: user?.address ?? 'Your Address',
                    );
                  },
                ),
                const SizedBox(height: 20),

                // Services Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Services:",
                    style: AppStyle.bold20Black,
                  ),
                ),

                const SizedBox(height: 12),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ServiceItem(
                        image: AppImages.foodService,
                        label: 'Food',
                        tag: 'Up to 50%',
                      ),
                      ServiceItem(
                        image: AppImages.healthAndWellnessService,
                        label: 'Health & wellness',
                        tag: '20mins',
                      ),
                      ServiceItem(
                        image: AppImages.groceriesService,
                        label: 'Groceries',
                        tag: '15 mins',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Promo Box
                PromoCodeBox(),

                const SizedBox(height: 14),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Shortcuts:",
                    style: AppStyle.bold20Black,
                  ),
                ),

                const SizedBox(height: 12),

                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state.shortcuts.isEmpty) {
                      return const SizedBox(height: 0);
                    }

                    return SizedBox(
                      height: 120,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount: state.shortcuts.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (_, index) {
                          final item = state.shortcuts[index];
                          return ShortcutItem(
                            image: item.image,
                            label: item.label,
                          );
                        },
                      ),
                    );
                  },
                ),


                const SizedBox(height: 16),

                // Promo Carousel
                SizedBox(
                  height: 180,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: promoImages.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            promoImages[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 12),

                // Page Indicator
                Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: promoImages.length,
                    effect: const WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: AppColors.primaryColor,
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Popular restaurants nearby", style: AppStyle.bold16Black),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 120,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.restaurants.length,
                              separatorBuilder: (_, __) => const SizedBox(width: 16),
                              itemBuilder: (context, index) {
                                final r = state.restaurants[index];
                                return RestaurantItem(
                                  name: r.name,
                                  logo: r.logo,
                                  time: r.time,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          _buildBarItem(0, 'Home', AppImages.homeIcon),
          _buildBarItem(1, 'Categories', AppImages.categoriesIcon),
          _buildBarItem(2, 'Deliver', AppImages.deliverIcon),
          _buildBarItem(3, 'Cart', AppImages.cartIcon),
          _buildBarItem(4, 'Profile', AppImages.profileIcon),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBarItem(
      int index, String label, String iconPath) {
    bool isSelected = _selectedIndex == index;

    return BottomNavigationBarItem(
      label: label,
      icon: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 4,
              width: 24,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 6),
            Image.asset(
              iconPath,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
