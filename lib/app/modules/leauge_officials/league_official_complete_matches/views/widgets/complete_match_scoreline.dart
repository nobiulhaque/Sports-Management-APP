import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_images.dart';

class CompleteMatchScoreLine extends StatelessWidget {
  const CompleteMatchScoreLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 16.w,
      children: [
        teamLogoContainer(
          context: context,
          imagePath: AppImage.fcBayern,
          teamName: 'FC Bayern',
        ),
        Container(
          height: 24.h,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.r),
            color: Color(0xFF3D455C).withAlpha(120),
          ),
          child: Text(
            '8 - 2',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ),
        teamLogoContainer(
          context: context,
          imagePath: AppImage.fcBarcelona,
          teamName: 'Barcelona',
        ),
      ],
    );
  }

  Widget teamLogoContainer({
    required BuildContext context,
    required String imagePath,
    required String teamName,
  }) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(7.5.r),
          child: SvgPicture.asset(imagePath),
        ),
        SizedBox(height: 8.h),
        Text(
          teamName,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.hintTextColor,
          ),
        ),
      ],
    );
  }
}
