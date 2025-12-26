// Updated version if you want the last item (Level) to be special
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:kaldmv/core/constants/app_colors.dart';
import 'info_card_item.dart';

class LeagueInfoSection extends StatelessWidget {
  final String organizationId;
  final String country;
  final String certifyingAuthority;
  final String validUntil;
  final String level;

  const LeagueInfoSection({
    super.key,
    required this.organizationId,
    required this.country,
    required this.certifyingAuthority,
    required this.validUntil,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          _buildSectionHeader(),
          SizedBox(height: 15.h),
          _buildInfoItems(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: AppColors.secondary.withAlpha(30),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: SvgPicture.asset('assets/icons/badge.svg'),
        ),
        SizedBox(width: 15.w),
        Text(
          "League Information",
          style: TextStyle(
            fontSize: 16.sp,
            color: const Color(0xFF101828),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItems() {
    final items = [
      ('Organization ID', organizationId, false),
      ('Country', country, false),
      ('Certifying Authority', certifyingAuthority, false),
      ('Valid Until', validUntil, false),
      ('Level', level, true), // Special item
    ];

    return Column(
      children: List.generate(
        items.length,
        (index) => Column(
          children: [
            InfoCardItem(
              label: items[index].$1,
              value: items[index].$2,
              isSpecial: items[index].$3,
            ),
            if (index < items.length - 1) SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }
}
