import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/utils/utils.dart';

class CompleteMatchRefereesContainer extends StatelessWidget {
  const CompleteMatchRefereesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        spacing: 24.h,
        children: [
          Utils.cardTitleSection(
            context: context,
            iconImagePath: AppIcons.football,
            title: "Referees",
            backgroundColor: Color(0xFFD9E1F7),
          ),
          Column(
            spacing: 24.h,
            children: List.generate(4, (index) {
              return buildRefereeTile(
                context: context,
                name: 'Pierluigi Collina',
                title: 'Referee',
                imagePath: 'assets/images/refereeee.png',
                onTap: () {
                  Get.toNamed('/view-details-match');
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget buildRefereeTile({
    required BuildContext context,
    required String name,
    required String title,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: Color(0xFFF2F5FF),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24.r,
              backgroundColor: AppColors.skyBlue,
              backgroundImage: AssetImage(imagePath),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.hintTextColor,
                  ),
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSubtle,
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.r,
              color: AppColors.textSubtle,
            ),
          ],
        ),
      ),
    );
  }
}
