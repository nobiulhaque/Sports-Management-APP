// ignore_for_file: use_full_hex_values_for_flutter_colors, deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatisticData {
  final String label;
  final int value;
  final Color backgroundColor;
  final Color valueColor;
  final Color bColor;

  StatisticData({
    required this.label,
    required this.value,
    required this.backgroundColor,
    required this.valueColor,
    required this.bColor,
  });
}

class MatchStatistics extends StatelessWidget {
  final List<StatisticData> statistics;
  final String title;

  const MatchStatistics({
    Key? key,
    required this.statistics,
    this.title = 'Match Statistics',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF101828),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFFE5E7EB),),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding:  EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 1.4,
              children: statistics
                  .map((stat) => StatisticCard(data: stat))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class StatisticCard extends StatelessWidget {
  final StatisticData data;

  const StatisticCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: data.backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: data.bColor,),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data.label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF4A5565),
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '${data.value}',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
              color: data.valueColor,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}