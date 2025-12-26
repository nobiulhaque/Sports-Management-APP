import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/widgets/league_card.dart';
import 'widgets/saved_league_skeleton_loader.dart';
import '../../../../widgets/app_bar_widgets.dart';
import '../controllers/saved_controller.dart';

class SavedView extends StatelessWidget {
  SavedView({super.key});
  final controller = Get.put(SavedPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Saved'),
      backgroundColor: const Color(0xFFF9FAFB),
      body: const SavedPageContent(),
    );
  }
}

class SavedPageContent extends GetView<SavedPageController> {
  const SavedPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Filter Chips
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          color: Colors.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('All', context),
                SizedBox(width: 8.w),
                _buildFilterChip('This Week', context),
                SizedBox(width: 8.w),
                _buildFilterChip('This Month', context),
                SizedBox(width: 8.w),
                _buildFilterChip('Recent', context),
              ],
            ),
          ),
        ),

        // Saved Leagues List
        Expanded(
          child: Obx(() {
            // Skeletonizer loading state
            if (controller.isLoading.value) {
              return const SavedLeagueSkeletonLoader();
            }

            if (controller.errorMessage.isNotEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B6B).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: const Color(0xFFFF6B6B),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          controller.errorMessage.value,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFFF6B6B),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (controller.savedLeagues.isEmpty) {
              return Center(
                child: Text(
                  'No saved leagues',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: controller.savedLeagues.length,
              itemBuilder: (context, index) {
                final league = controller.savedLeagues[index];
                return LeagueCard(
                  league: league,
                  onRequest: () {
                    // Handle request
                  },
                  onToggleSave: (leagueId) {
                    controller.toggleSaveLeague(leagueId);
                  },
                );
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () => controller.onFilterChanged(label),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: controller.selectedFilter.value == label
                ? const Color(0xFF1E40AF)
                : Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: controller.selectedFilter.value == label
                  ? const Color(0xFF1E40AF)
                  : const Color(0xFFE5E7EB),
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: controller.selectedFilter.value == label
                  ? Colors.white
                  : const Color(0xFF6B7280),
            ),
          ),
        ),
      ),
    );
  }
}
