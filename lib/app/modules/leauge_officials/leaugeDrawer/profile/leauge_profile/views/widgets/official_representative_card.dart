import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:kaldmv/core/constants/app_colors.dart';

class OfficialRepresentativeCard extends StatelessWidget {
  final String fullName;
  final String designation;
  final String contactNumber;
  final String email;
  final String? profileImage;

  const OfficialRepresentativeCard({
    super.key,
    required this.fullName,
    required this.designation,
    required this.contactNumber,
    required this.email,
    this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    // Check if any meaningful data exists
    if ((fullName == 'N/A' || fullName.isEmpty) &&
        (designation == 'N/A' || designation.isEmpty) &&
        (contactNumber == 'N/A' || contactNumber.isEmpty) &&
        (email == 'N/A' || email.isEmpty) &&
        profileImage == null) {
      return SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 20.h),
          _buildProfileSection(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(30),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: SvgPicture.asset('assets/icons/rep.svg'),
        ),
        SizedBox(width: 15.w),
        Text(
          "Official Representative",
          style: TextStyle(
            fontSize: 16.sp,
            color: const Color(0xFF1E2939),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(2.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withAlpha(30),
          ),
          child: Container(
            width: 52.w,
            height: 52.w,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: profileImage != null
                ? ClipOval(
                    child: Image.network(
                      profileImage!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary.withAlpha(30),
                          ),
                          child: Icon(
                            Icons.person,
                            size: 28.r,
                            color: AppColors.primary,
                          ),
                        );
                      },
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withAlpha(30),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 28.r,
                      color: AppColors.primary,
                    ),
                  ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full Name',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF667085),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                fullName,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFF101828),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Designation',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF667085),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                designation,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFF101828),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Contact Number',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF667085),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                contactNumber,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFF101828),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF667085),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                email,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFF101828),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
