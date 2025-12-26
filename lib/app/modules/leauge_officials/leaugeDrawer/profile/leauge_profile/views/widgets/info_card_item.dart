import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:kaldmv/core/constants/app_colors.dart';

class InfoCardItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isSpecial;

  const InfoCardItem({
    super.key,
    required this.label,
    required this.value,
    this.isSpecial = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(13.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF667085),
              ),
            ),
            SizedBox(height: 4.h),
            isSpecial ? _buildSpecialValue() : _buildNormalValue(),
          ],
        ),
      ),
    );
  }

  Widget _buildNormalValue() {
    return Text(
      value,
      style: TextStyle(
        fontSize: 14.sp,
        color: const Color(0xFF101828),
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildSpecialValue() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
        child: Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}