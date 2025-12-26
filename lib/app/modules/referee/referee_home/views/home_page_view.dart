// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/referee/referee_home/controllers/referee_home_controller.dart';
import 'package:kaldmv/app/modules/referee/upcoming_matches/controllers/upcoming_matches_controller.dart';
import 'package:kaldmv/app/widgets/custom_svg_icon.dart';

import '../../../../widgets/match_card.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;
  late UpcomingMatchesController matchesController;

  @override
  void initState() {
    super.initState();
    matchesController = Get.put(UpcomingMatchesController());
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                height: 52.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(30),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search jobs',
                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF9CA3AF),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 16.h,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: 40.w,
                      height: 40.h,
                      margin: EdgeInsets.only(right: 8.w),
                      decoration: const BoxDecoration(
                        color: Color(0xFF1E40AF),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: CustomSvgIcon(
                          assetName: 'assets/icons/search-lg.svg',
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // Upcoming Matches Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upcoming Matches',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed('/upcoming-matches');
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E40AF),
                      ),
                    ),
                  ),
                ],
              ),

              // Matches Carousel
              SizedBox(
                height: 230.h,
                child: GetX<UpcomingMatchesController>(
                  builder: (controller) {
                    final matches = controller.filteredMatches.take(3).toList();
                    return Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: matches.length,
                            padEnds: false,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(right: 8.w),
                                child: SizedBox(
                                  height: 160.h,
                                  child: MatchCard(
                                    match: matches[index],
                                    onViewDetails: () {
                                      Get.toNamed(
                                        '/match-details',
                                        arguments: matches[index].id,
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10.h),
                        // Page Indicator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            matches.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              width: _currentPage == index ? 32.w : 8.w,
                              height: 8.h,
                              decoration: BoxDecoration(
                                color: _currentPage == index
                                    ? const Color(0xFF1E40AF)
                                    : const Color(0xFFD1D5DB),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              SizedBox(height: 24.h),

              // Top Icons Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTopIconCard(
                      iconPath: 'assets/icons/league.svg',
                      iconColor: Colors.white,
                      backgroundColor: const Color(0xFFFB4365),
                      label: 'League',
                      onTap: () {
                        Get.toNamed("/leauge");
                      },
                    ),
                    _buildTopIconCard(
                      iconPath: 'assets/icons/premium.svg',
                      iconColor: Colors.white,
                      backgroundColor: const Color(0xFFFACC15),
                      label: 'Premium',
                      onTap: () {
                        Get.toNamed("/premium");
                      },
                    ),
                    _buildTopIconCard(
                      iconPath: 'assets/icons/save.svg',
                      iconColor: Colors.white,
                      backgroundColor: const Color(0xFF2B0172),
                      label: 'Saved',
                      onTap: () {
                        Get.toNamed("/saved");
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3E8FF),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: CustomSvgIcon(
                      assetName: 'assets/icons/trending_up.svg',
                      color: const Color(0xFF9810FA),
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Performance Stats',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),

              // Performance Stats Section
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
                ),
                child: GetX<RefereeHomeController>(
                  builder: (controller) {
                    final stats = controller.performanceStats.value;

                    if (controller.statsLoading.value) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Text(
                                  'Referee Rating',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                const CircularProgressIndicator(),
                              ],
                            ),
                          ),
                        ],
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section Header
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Text(
                                'Referee Rating',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: const Color(0xFFFFD700),
                                    size: 24.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  // API Data - Dynamic Rating
                                  Text(
                                    stats?.averageRating.toStringAsFixed(1) ??
                                        '0.0',
                                    style: TextStyle(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),

                              Text(
                                stats?.performanceDescription ?? 'Loading...',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      stats?.performanceColor ??
                                      const Color(0xFF00A63E),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 10.h),
              GetX<RefereeHomeController>(
                builder: (controller) {
                  final stats = controller.performanceStats.value;

                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: Color(0xFFFEF9C2),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.leaderboard,
                                    color: const Color(0xFFD08700),
                                    size: 20.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    'Level',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFD08700),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),

                              // API Data - Dynamic Level
                              Text(
                                stats?.levelDisplayName ?? 'Regional Level',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF733E0A),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: Color(0xFFBEDBFF),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: const Color(0xFF155DFC),
                                    size: 20.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    'This Season',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF193CB8),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              // API Data - Dynamic Total Matches
                              Text(
                                (stats?.totalMatches ?? 0).toString(),
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1C398E),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    try {
      // Refresh upcoming matches
      await matchesController.loadMatches();

      // Refresh performance stats if RefereeHomeController is available
      final homeController = Get.find<RefereeHomeController>();
      await homeController.loadPerformanceStats();
    } catch (e) {
      print('Error refreshing data: $e');
    }
  }

  Widget _buildTopIconCard({
    required String iconPath,
    required Color iconColor,
    required Color backgroundColor,
    required String label,
    required VoidCallback onTap, // <-- Updated to VoidCallback
  }) {
    return Column(
      children: [
        GestureDetector(
          // <-- Make the card tappable
          onTap: onTap,
          child: Container(
            width: 64.w,
            height: 64.h,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CustomSvgIcon(
                assetName: iconPath,
                color: iconColor,
                size: 32,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
