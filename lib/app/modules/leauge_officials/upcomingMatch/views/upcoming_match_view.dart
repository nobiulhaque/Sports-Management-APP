import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/leauge_officials/upcomingMatch/views/widgets/match_card_widgets.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_search_bar.dart';
import '../controllers/upcoming_match_controller.dart';
import 'match_detaills_upcoming_match.dart';

class UpcomingMatchView extends GetView<UpcomingMatchController> {
  const UpcomingMatchView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpcomingMatchController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarLeauge(title: "Upcoming Matches"),
      body: Column(
        children: [
          SizedBox(height: 16.h),

          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CustomSearchBar(hintText: 'Search '),
          ),

          SizedBox(height: 16.h),

          // Filter Chips
          Padding(
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

          SizedBox(height: 16.h),

          // Matches List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.filteredMatches.isEmpty) {
                return Center(
                  child: Text(
                    'No matches found',
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: controller.filteredMatches.length,
                itemBuilder: (context, index) {
                  final match = controller.filteredMatches[index];

                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: MatchCard(
                      match: match,
                      onViewDetails: () {
                        Get.to(
                          () => MatchDetailsScreenDetaislUpcomming(),
                          arguments: match.id,
                        );
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, UpcomingMatchController controller) {
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
