// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/leauge_officials/widgets/custom_app_bar.dart';
import 'package:kaldmv/app/modules/regular_user/account_regular_page/controllers/account_regular_page_controller.dart';
import 'package:kaldmv/app/modules/regular_user/account_regular_page/views/pages/widgets/regular_header_card.dart';
import 'package:kaldmv/app/modules/regular_user/account_regular_page/views/pages/widgets/regular_info_card.dart';
import 'package:kaldmv/core/constants/app_colors.dart';
import 'package:kaldmv/core/utils/utils.dart';
import 'package:kaldmv/app/data/models/regular_user_profile_model.dart';

class ProfileRegularView extends GetView<AccountRegularPageController> {
  const ProfileRegularView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarLeauge(title: 'Profile'),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value &&
              controller.userProfile.value == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final profile = controller.userProfile.value;

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      RegularProfileHeaderCard(
                        name: profile?.name ?? 'Guest User',
                        email: profile?.email ?? 'N/A',
                        profession: profile?.userType ?? 'User',
                        location: profile?.userAddress ?? 'N/A',
                        imagePath: profile?.image ?? 'assets/images/u3.png',
                      ),
                      SizedBox(height: 10.h),
                      _buildEditProfileButton(context),
                      SizedBox(height: 10.h),
                      _buildProfileInfoSection(profile),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildEditProfileButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(12.r),
        child: Utils.primaryButton(
          context: context,
          backgroundColor: const Color(0xFF002B5B),
          title: 'Edit Profile',
          onTap: () {
            Get.toNamed('/edit-profile-regular');
          },
        ),
      ),
    );
  }

  Widget _buildProfileInfoSection(RegularUserProfile? profile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(),
          SizedBox(height: 12.h),
          RegularProfileInfoCard(
            label: 'Address',
            value: profile?.userAddress ?? 'N/A',
          ),
          SizedBox(height: 12.h),
          RegularProfileInfoCard(label: 'Joined', value: controller.joinedDate),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFDCFCE7),
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.all(8.w),
          child: SvgPicture.asset(
            'assets/icons/badge.svg',
            width: 24.w,
            height: 24.h,
            color: AppColors.appGreen,
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          'Profile Information',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
