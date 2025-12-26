// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../widgets/custom_svg_icon.dart';
import '../../../../widgets/match_card.dart';
import '../controllers/upcoming_matches_controller.dart';

class UpcomingMatchesView extends StatelessWidget {
  const UpcomingMatchesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpcomingMatchesController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 64.h,
        leadingWidth: 72.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w, top: 10.h, bottom: 10.h),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: const Color(0xFFD9E1F7),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.chevron_left,
                  color: const Color(0xFF1E3A8A),
                  size: 24.sp,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          'Upcoming Matches',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            height: 1.5,
            letterSpacing: 0,
          ),
        ),
        centerTitle: true,
        titleSpacing: 0,
      ),

      body: CustomScrollView(
        slivers: [
          // Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Container(
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
                            color: const Color(0xFF61758A),
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
            ),
          ),

          // Filter Chips
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Obx(
                () => Row(
                  children: [
                    _buildFilterChip('All', controller),
                    SizedBox(width: 8.w),
                    _buildFilterChip('This week', controller),
                    SizedBox(width: 8.w),
                    _buildFilterChip('This month', controller),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 16.h)),

          // Matches List or Loading/Error States
          Obx(() {
            if (controller.isLoading.value) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 48.h),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              );
            }

            if (controller.errorMessage.value.isNotEmpty) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Error',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          controller.errorMessage.value,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                        ),
                        SizedBox(height: 16.h),
                        ElevatedButton(
                          onPressed: () => controller.loadMatches(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            if (controller.filteredMatches.isEmpty) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 48.h),
                  child: Center(
                    child: Text(
                      'No upcoming matches',
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                    ),
                  ),
                ),
              );
            }

            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final match = controller.filteredMatches[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ).copyWith(bottom: 12.h),
                  child: MatchCard(
                    match: match,
                    onViewDetails: () {
                      Get.toNamed('/match-details', arguments: match.id);
                    },
                  ),
                );
              }, childCount: controller.filteredMatches.length),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, UpcomingMatchesController controller) {
    final isSelected = controller.selectedFilter.value == label;
    return GestureDetector(
      onTap: () => controller.setFilter(label),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E40AF) : const Color(0xFFD9E1F7),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF1E3A8A),
            height: 1.5,
            letterSpacing: 0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
