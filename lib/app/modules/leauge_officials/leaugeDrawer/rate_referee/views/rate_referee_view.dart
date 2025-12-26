import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/leauge_officials/leaugeDrawer/rate_referee/views/widgets/completed_match_card.dart';
import 'package:kaldmv/app/modules/leauge_officials/leaugeDrawer/rate_referee/views/widgets/dummy_matches.dart';
import 'package:kaldmv/app/widgets/app_bar_widgets.dart';
import '../controllers/rate_referee_controller.dart';

class RateRefereeView extends GetView<RateRefereeController> {
  const RateRefereeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Completed Matches'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Obx(
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
                SizedBox(height: 20.h),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: matches.length,
                  separatorBuilder: (_, __) => SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    return CompletedMatchCard(match: matches[index]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, RateRefereeController controller) {
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
          ),
        ),
      ),
    );
  }
}
