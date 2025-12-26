import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/home_regular_user_controller.dart';
import '../../controllers/regular_matches_controller.dart';
import '../../../../../widgets/match_card.dart';
import '../../../match_details/views/regular_match_details_view.dart';

class RegularCompletedMatchesSection extends StatefulWidget {
  const RegularCompletedMatchesSection({super.key});

  @override
  State<RegularCompletedMatchesSection> createState() =>
      _RegularCompletedMatchesSectionState();
}

class _RegularCompletedMatchesSectionState
    extends State<RegularCompletedMatchesSection> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeRegularUserController>();
    final matchesController = Get.put(RegularMatchesController());

    return Obx(() {
      if (matchesController.isLoading.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: CircularProgressIndicator(),
          ),
        );
      }

      // Get first 3 matches for carousel
      final carouselMatches = matchesController.matches.take(3).toList();

      if (carouselMatches.isEmpty) {
        return const Center(child: Text('No matches available'));
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with "See All" button
          _buildSectionHeader(
            title: 'Matches',
            onViewAll: () => homeController.updateNavIndex(1),
          ),
          SizedBox(height: 16.h),

          // Carousel with indicators
          Column(
            children: [
              // Carousel Slider
              CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: 218.h, // Increased height for better visibility
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: true,
                  pauseAutoPlayOnManualNavigate: true,
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.15,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: carouselMatches.map((matchData) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: MatchCard(
                          match: matchData.toMatchCardFormat(),
                          onViewDetails: () {
                            Get.to(
                              () => const RegularMatchDetailsView(),
                              arguments: matchData.id,
                            );
                          },
                        ),
                      );
                    },
                  );
                }).toList(),
              ),

              SizedBox(height: 12.h),

              // Carousel Indicators
              _buildCarouselIndicators(carouselMatches.length),
            ],
          ),
        ],
      );
    });
  }

  Widget _buildSectionHeader({
    required String title,
    required VoidCallback onViewAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: onViewAll,
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
    );
  }

  Widget _buildCarouselIndicators(int length) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => GestureDetector(
          onTap: () => _carouselController.animateToPage(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _currentIndex == index ? 28.w : 8.w,
            height: 8.h,
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: _currentIndex == index
                  ? const Color(0xFF1E40AF)
                  : const Color(0xFFE5E7EB),
            ),
          ),
        ),
      ),
    );
  }
}
