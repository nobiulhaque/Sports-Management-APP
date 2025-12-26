// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const CustomBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w),
      child: GestureDetector(
        onTap: onTap ?? () => Get.back(),
        child: Container(
          width: 44.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: const Color(0xff1d9e1f7),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Icons.arrow_back_ios_new,
              color: const Color(0xfff1e3a8a),
              size: 20.sp,
            ),
          ),
        ),
      ),
    );
  }
}
