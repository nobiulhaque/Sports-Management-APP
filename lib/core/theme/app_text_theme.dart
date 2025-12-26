import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

class AppTextTheme {
  static TextTheme get light => TextTheme(
    /// heading text
    headlineLarge: TextStyle(
      fontSize: 30.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryTextColor,
      fontFamily: 'Anton',
    ),
    headlineMedium: TextStyle(
      fontSize: 26.sp,
      fontWeight: FontWeight.w600,

      fontFamily: 'Anton',
    ),
    headlineSmall: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryTextColor,
      fontFamily: 'Anton',
    ),

    /// title text
    titleLarge: TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.primaryTextColor,
      fontFamily: 'Anton',
    ),
    titleMedium: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.primaryTextColor,
      fontFamily: 'Anton',
    ),

    titleSmall: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryTextColor,
      fontFamily: 'Anton',
    ),

    bodyLarge: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryTextColor,
      fontFamily: 'Anton',
    ),

    bodyMedium: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.primaryTextColor,
      fontFamily: 'Anton',
    ),

    /// regular body text
    bodySmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.primaryTextColor,
      fontFamily: 'Anton',
    ),
  );
}