import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaldmv/core/utils/utils.dart';

import '../../core/constants/app_colors.dart';

class FilePickerWidget extends StatelessWidget {
  const FilePickerWidget({super.key, this.title, this.subTitle, this.onTap});

  final String? title;
  final String? subTitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Text(
                title ?? '',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E3A8A),
                ),
              )
            : SizedBox.shrink(),
        const SizedBox(height: 8),
        DottedBorder(
          options: RoundedRectDottedBorderOptions(
            dashPattern: [12, 12],
            strokeWidth: 1,
            radius: Radius.circular(16.r),
            color: Color(0xFF1E3A8A),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20.h),
              decoration: BoxDecoration(
                color: Color(0xFFF2F5FF),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.cloud_upload_outlined,
                    size: 40,
                    color: Color(0xFF1E3A8A),
                  ),
                  const SizedBox(height: 8),
                  Text(subTitle ?? '', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 10),
                  Utils.primaryButton(
                    context: context,
                    title: 'Add Attachment',
                    height: 28.h,
                    width: MediaQuery.of(context).size.width * 0.4,
                    fontSize: 12.sp,
                    backgroundColor: AppColors.primarySubtle,
                    radius: 4.r,
                    onTap: onTap,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
