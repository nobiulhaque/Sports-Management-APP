import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../widgets/custom_svg_icon.dart';
import 'package:kaldmv/app/modules/regular_user/home_regular_user/controllers/home_regular_user_controller.dart';
import 'package:kaldmv/app/modules/regular_user/account_regular_page/controllers/account_regular_page_controller.dart';

class RegularHomeAppBar extends GetView<HomeRegularUserController>
    implements PreferredSizeWidget {
  const RegularHomeAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(80.h);

  @override
  Widget build(BuildContext context) {
    // Get the account controller for profile data
    final accountController = Get.find<AccountRegularPageController>();

    return PreferredSize(
      preferredSize: Size.fromHeight(80.h),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1E3A8A), Color(0xFF2E4F9E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                // Profile Avatar
                Obx(
                  () => _buildProfileAvatar(
                    accountController.userProfile.value?.image,
                  ),
                ),
                SizedBox(width: 12.w),

                // User Info
                Expanded(
                  child: Obx(
                    () => _buildUserInfo(
                      accountController.userProfile.value?.name,
                      accountController.isLoading.value,
                    ),
                  ),
                ),

                // Notification Bell
                _buildNotificationBell(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileAvatar(String? imagePath) {
    final String path = imagePath ?? '';
    return Container(
      width: 48.w,
      height: 48.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white24,
        image: path.isNotEmpty && path.startsWith('http')
            ? DecorationImage(image: NetworkImage(path), fit: BoxFit.cover)
            : DecorationImage(
                image: AssetImage(
                  path.isNotEmpty ? path : 'assets/images/u3.png',
                ),
                fit: BoxFit.cover,
              ),
      ),
      child: path.isEmpty
          ? Icon(Icons.person, color: Colors.white, size: 24.r)
          : null,
    );
  }

  Widget _buildUserInfo(String? name, bool isLoading) {
    if (isLoading && name == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: 100.w, height: 14.h, color: Colors.white24),
          SizedBox(height: 4.h),
          Container(width: 80.w, height: 12.h, color: Colors.white24),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name ?? 'Guest User',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          'Welcome Back!',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationBell() {
    return GestureDetector(
      onTap: () => Get.toNamed('/notification'),
      child: Stack(
        children: [
          CustomSvgIcon(assetName: 'assets/icons/notification_bell.svg'),
          // Red dot indicator with count
          Obx(() {
            if (controller.notificationCount.value <= 0) {
              return const SizedBox.shrink();
            }
            return Positioned(
              left: 1.w,
              top: 0.h,
              child: Container(
                padding: EdgeInsets.all(2.w),
                constraints: BoxConstraints(minWidth: 10.w, minHeight: 10.h),
                decoration: const BoxDecoration(
                  color: Color(0xFFEF4444),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    controller.notificationCount.value > 99
                        ? '99+'
                        : '${controller.notificationCount.value}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
