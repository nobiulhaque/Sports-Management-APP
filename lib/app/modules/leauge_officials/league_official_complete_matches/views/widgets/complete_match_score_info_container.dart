import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/constants/app_icons.dart';
import 'complete_match_scoreline.dart';

class CompleteMatchScoreInfoContainer extends StatelessWidget {
  const CompleteMatchScoreInfoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFBEDBFF)),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Color(0xFF000000).withAlpha(25),
            offset: Offset(0, 4),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFEFF6FF), Color(0xFFEEF2FF)],
        ),
      ),
      child: Column(
        spacing: 16.h,
        children: [
          CompleteMatchScoreLine(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                spacing: 8.w,
                children: [
                  SvgPicture.asset(
                    AppIcons.calender,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF6A7282),
                      BlendMode.srcIn,
                    ),
                  ),
                  Text(
                    'Oct 12, 2025',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Color(0xFF364153),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10.w),
              Wrap(
                spacing: 8.w,
                children: [
                  SvgPicture.asset(
                    AppIcons.time,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF6A7282),
                      BlendMode.srcIn,
                    ),
                  ),
                  Text(
                    '3:00 PM',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Color(0xFF364153),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppIcons.location,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF6A7282),
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                'National Sports Complex, Field 3',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Color(0xFF364153),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
