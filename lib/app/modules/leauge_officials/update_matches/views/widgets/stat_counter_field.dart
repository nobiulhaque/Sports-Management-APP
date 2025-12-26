import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaldmv/core/constants/app_colors.dart';

class StatCounterField extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

   StatCounterField({
    super.key,
    required this.label,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  final Color titleColor = Color(0xFF61758A);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: titleColor,
            fontWeight: FontWeight.w400
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          height: 52.h,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: AppColors.primary,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value.toString().padLeft(2, '0'),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.hintTextColor
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: onIncrement,
                    child:  Icon(
                      Icons.keyboard_arrow_up,
                      color: Color(0xFF0D0D0D),
                      size: 16.r,
                    ),
                  ),
                  GestureDetector(
                    onTap: onDecrement,
                    child:  Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xFF0D0D0D),
                      size: 16.r,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
