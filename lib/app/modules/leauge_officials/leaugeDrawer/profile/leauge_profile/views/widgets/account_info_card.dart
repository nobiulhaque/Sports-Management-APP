import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:kaldmv/core/constants/app_colors.dart';

class AccountInformationCard extends StatelessWidget {
  final String joinedDate;
  final String accountType;
  final int refereesHired;
  final int ongoingMatches;
  final int pendingMatches;
  final int completedMatches;

  const AccountInformationCard({
    super.key,
    required this.joinedDate,
    required this.accountType,
    required this.refereesHired,
    required this.ongoingMatches,
    required this.pendingMatches,
    required this.completedMatches,
  });

  @override
  Widget build(BuildContext context) {
    // Check if any meaningful data exists
    if ((joinedDate == 'N/A' || joinedDate.isEmpty) &&
        (accountType == 'N/A' || accountType.isEmpty) &&
        refereesHired == 0 &&
        ongoingMatches == 0 &&
        pendingMatches == 0 &&
        completedMatches == 0) {
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
          _buildAccountDetails(),
          SizedBox(height: 20.h),
          _buildStatsGrid(),
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
            color: AppColors.appLightGreen,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: SvgPicture.asset(
            'assets/icons/rep.svg',
            color: AppColors.appGreen,
          ),
        ),
        SizedBox(width: 15.w),
        Text(
          "Account Information",
          style: TextStyle(
            fontSize: 16.sp,
            color: const Color(0xFF1E2939),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildAccountDetails() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              'assets/images/calander.svg',
              width: 20.w,
              height: 20.h,
              color: Color(0xFF99A1AF),
            ),
            SizedBox(width: 12.w),
            Text(
              'Joined on',
              style: TextStyle(
                fontSize: 12.sp,
                color: Color(0xFF99A1AF),
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(),
            Text(
              joinedDate,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF101828),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              'assets/icons/badge.svg',
              color: Color(0xFF99A1AF),
              width: 20.w,
              height: 20.h,
            ),
            SizedBox(width: 12.w),
            Text(
              'Account Type',
              style: TextStyle(
                fontSize: 12.sp,
                color: Color(0xFF99A1AF),
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFA500),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                child: Text(
                  'Premium',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12.w,
      mainAxisSpacing: 12.h,
      childAspectRatio: 1.2,
      children: [
        _buildStatCard(
          icon: 'assets/icons/users.svg',
          label: 'Referees Hired',
          value: refereesHired.toString(),
          backgroundColor: const Color(0xFFE7F1FF),
          iconColor: AppColors.primary,
        ),
        _buildStatCard(
          icon: 'assets/icons/trending_up.svg',
          label: 'Ongoing Matches',
          value: ongoingMatches.toString(),
          backgroundColor: const Color(0xFFE8F5E9),
          iconColor: const Color(0xFF22C55E),
        ),
        _buildStatCard(
          icon: 'assets/icons/trending_up.svg',
          label: 'Pending Matches',
          value: pendingMatches.toString(),
          backgroundColor: const Color(0xFFE8F5E9),
          iconColor: const Color(0xFF22C55E),
        ),
        _buildStatCard(
          icon: 'assets/icons/trending_up.svg',
          label: 'Completed Matches',
          value: completedMatches.toString(),
          backgroundColor: const Color(0xFFFEF3C7),
          iconColor: const Color(0xFFF59E0B),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String icon,
    required String label,
    required String value,
    required Color backgroundColor,
    required Color iconColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                icon,
                width: 18.w,
                height: 18.h,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Color(0xFF6A7282),
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 28.sp,
              color: iconColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
