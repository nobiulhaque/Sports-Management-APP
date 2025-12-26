import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_colors.dart';

class Utils {
  /// primary button
  static Widget primaryButton({
    required BuildContext context,
    VoidCallback? onTap,
    String? title,
    Widget? child,
    double? radius,
    Color? backgroundColor,
    Color? borderColor,
    Color? textColor,
    double? width,
    double? height,
    double? fontSize,
    LinearGradient? gradient,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width ?? double.infinity,
        height: height ?? 44.h,
        // padding: EdgeInsets.symmetric(vertical: 15.h),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primary,
          borderRadius: BorderRadius.circular(radius ?? 8.r),
          border: Border.all(color: borderColor ?? Colors.transparent),
          gradient: gradient,
        ),
        child:
        child ??
            Text(
              title ?? ' ',
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(
                color: textColor ?? AppColors.white,
                fontSize: fontSize ?? 16.sp,
              ),
            ),
      ),
    );
  }


  static Widget cardTitleSection({
    required BuildContext context,
    required String iconImagePath,
    IconData? iconData,
    required String title,
    double? fontSize,
    Color? iconColor,
    Color? backgroundColor,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: iconData == null ? SvgPicture.asset(iconImagePath, width: 16.w,
              height: 16.h,
              colorFilter: ColorFilter.mode(
                iconColor ?? AppColors.primary,
                BlendMode.srcIn,
              ),) : Icon(iconData, color: iconColor, size: 16.r),
        ),
        SizedBox(width: 8.w),
        Text(
          title,
          style: Theme
              .of(context)
              .textTheme
              .titleSmall
              ?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: fontSize ?? 18.sp,
            color: Color(0xFF101828),
          ),
        ),
      ],
    );
  }

  /// back button
  static Widget backButton({
    required BuildContext context,
    VoidCallback? onTap,
    Color? buttonColor,
    double? width,
    double? height,
    Color? backgroundColor,
  }) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.pop(context),
      child: Container(
        width: width ?? 44.w,
        height: height ?? 44.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFD9E1F7),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: Icon(
            Icons.arrow_back_ios,
            color: buttonColor ?? AppColors.primary,
            size: 24.r,
          ),
        ),
      ),
    );
  }

  /// custom Text Form Field with label
  static Widget customTextField({
    required BuildContext context,
    String? title,
    String? hintText,
    double? hintFontSize,
    double? tfontsize,
    double? shight,
    TextEditingController? controller,
    Widget? suffixIcon,
    bool? obscureText,
    int? maxLine,
    Color? textColor,
    double? radius,
    ValueChanged<String>? onChanged,
    bool? readOnly,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Text(
          title,
          style: Theme
              .of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(
            color: textColor ?? AppColors.primaryTextColor,
            fontSize: tfontsize ?? 14.sp,
          ),
        )
            : SizedBox.shrink(),
        SizedBox(height: shight),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 2.h),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary),
            borderRadius: BorderRadius.circular(radius ?? 10.r),
          ),
          child: TextFormField(
            controller: controller,
            readOnly: readOnly ?? false,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: Theme
                  .of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(
                color: AppColors.hintTextColor,
                fontWeight: FontWeight.w400,
                fontSize: hintFontSize ?? 18.sp,
              ),
              suffixIcon: suffixIcon,
            ),
            maxLines: maxLine ?? 1,
          ),
        ),
      ],
    );
  }
}
