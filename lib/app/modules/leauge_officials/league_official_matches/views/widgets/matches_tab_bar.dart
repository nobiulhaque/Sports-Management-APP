import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../controllers/league_official_matches_controller.dart';

class MatchesTabBar extends StatelessWidget {
  MatchesTabBar({
    super.key,
  });

  final LeagueOfficialMatchesController controller = Get.put(LeagueOfficialMatchesController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 33.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.matchTabs.length,
        itemBuilder: (context, index) {
          final bool isFirst = index == 0;
          final bool isLast = index == controller.matchTabs.length - 1;

          return Obx(() {
            final bool isSelected = controller.selectedMatchTab.value == index;

            return GestureDetector(
              onTap: () {
                controller.changeMatchTab(index);
                debugPrint('New Tab Selected: ${controller.selectedMatchTab.value}');
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                margin: EdgeInsets.only(
                  left: isFirst ? 10.w : 8.w,
                  right: isLast ? 10.w : 0.w,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32.r),
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.primaryAccent,
                ),
                child: Text(
                  controller.matchTabs[index],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    color: isSelected ? AppColors.white : AppColors.primary,
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}