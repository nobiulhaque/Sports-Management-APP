// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/referee/referee_matches/views/referee_matches_view.dart';
import 'package:kaldmv/app/widgets/custom_svg_icon.dart';
import 'package:kaldmv/app/modules/referee/sideDrawer/enddrawer.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../message/views/message_view.dart';
import '../../rating/rating_home/views/rating_view.dart';
import '../../training/training_home/views/training_views.dart';
import '../controllers/referee_home_controller.dart';
import 'home_page_view.dart';

class RefereeHomeView extends GetView<RefereeHomeController> {
  const RefereeHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        endDrawer: const DrawerMenu(),
        backgroundColor: Colors.white,

        // ✅ AppBar hidden when Message tab selected
        appBar: controller.currentIndex.value == 5
            ? null
            : PreferredSize(
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      child: Obx(
                        () => Skeletonizer(
                          enabled: controller.isLoading.value,
                          effect: PulseEffect(
                            duration: const Duration(milliseconds: 1000),
                          ),
                          child: Row(
                            children: [
                              // Profile Avatar
                              Container(
                                width: 48.w,
                                height: 48.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[300],
                                ),
                                child: controller.image.value.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          24.r,
                                        ),
                                        child: Image.network(
                                          controller.image.value,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Icon(
                                                  Icons.person,
                                                  size: 28.sp,
                                                  color: Colors.grey[600],
                                                );
                                              },
                                        ),
                                      )
                                    : Icon(
                                        Icons.person,
                                        size: 28.sp,
                                        color: Colors.grey[600],
                                      ),
                              ),
                              SizedBox(width: 12.w),

                              // Name and Role
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.name.value,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      controller.role.value,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Notification Icon
                              GestureDetector(
                                onTap: () => Get.toNamed('/notification'),
                                child: Stack(
                                  children: [
                                    CustomSvgIcon(
                                      assetName:
                                          'assets/icons/notification_bell.svg',
                                    ),
                                    // Red dot indicator with count
                                    Obx(() {
                                      if (controller.notificationCount.value <=
                                          0) {
                                        return const SizedBox.shrink();
                                      }
                                      return Positioned(
                                        left: 1.w,
                                        top: 0.h,
                                        child: Container(
                                          padding: EdgeInsets.all(2.w),
                                          constraints: BoxConstraints(
                                            minWidth: 10.w,
                                            minHeight: 10.h,
                                          ),
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFEF4444),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Text(
                                              controller
                                                          .notificationCount
                                                          .value >
                                                      99
                                                  ? '99+'
                                                  : '${controller.notificationCount.value}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 8.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16.w),

                              // Menu Icon
                              Builder(
                                builder: (context) => GestureDetector(
                                  onTap: () {
                                    Scaffold.of(
                                      context,
                                    ).openEndDrawer(); // opens drawer
                                  },
                                  child: CustomSvgIcon(
                                    assetName: 'assets/icons/hum_menu.svg',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

        // ✅ Body content
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: [
            HomePageView(),
            RefereeMatchesView(),
            TrainingViews(),
            RatingView(),
            MessageView(),
          ],
        ),

        // ✅ Bottom Navigation
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: const Border(
              top: BorderSide(color: Color(0xFFE5E7EB), width: 1),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    svgIcon: 'assets/icons/home.svg',
                    label: 'Home',
                    index: 0,
                    isSelected: controller.currentIndex.value == 0,
                  ),
                  _buildNavItem(
                    svgIcon: 'assets/icons/football.svg',
                    label: 'Matches',
                    index: 1,
                    isSelected: controller.currentIndex.value == 1,
                  ),
                  _buildNavItem(
                    svgIcon: 'assets/icons/training.svg',
                    label: 'Training',
                    index: 2,
                    isSelected: controller.currentIndex.value == 2,
                  ),
                  _buildNavItem(
                    svgIcon: 'assets/icons/rating.svg',
                    label: 'Ratings',
                    index: 3,
                    isSelected: controller.currentIndex.value == 3,
                  ),
                  _buildNavItem(
                    svgIcon: 'assets/icons/message.svg',
                    label: 'Message',
                    index: 4,
                    isSelected: controller.currentIndex.value == 4,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String svgIcon,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomSvgIcon(
              assetName: svgIcon,
              size: 24,
              color: isSelected
                  ? const Color(0xFF1E3A8A)
                  : const Color(0xFF6B7280),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? const Color(0xFF1E3A8A)
                    : const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
