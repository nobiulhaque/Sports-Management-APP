import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constants/app_colors.dart';
import 'complete_match_stat_card.dart';

class CompleteMatchStatisticsContainer extends StatelessWidget {
  const CompleteMatchStatisticsContainer({super.key});

  // Your stats list
  List<MatchStat> get stats => [
    MatchStat('Yellow Cards', '3'),
    MatchStat('Red Cards', '0'),
    MatchStat('Fouls Called', '18'),
    MatchStat('Offsides', '7'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Match Statistics',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.hintTextColor,
            fontSize: 18.sp,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: const Color(0xFFE5E7EB)),
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF000000).withAlpha(25),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: stats.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16.h,
              crossAxisSpacing: 16.w,
              childAspectRatio: 1.65,
            ),
            itemBuilder: (context, index) {
              final item = stats[index];
              return CompleteMatchStatCard(
                title: item.title,
                value: item.value,
              );
            },
          ),
        ),
      ],
    );
  }
}

class MatchStat {
  final String title;
  final String value;

  MatchStat(this.title, this.value);
}
