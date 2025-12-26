import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:kaldmv/app/modules/leauge_officials/home_leauge/views/leauge_app_drawer.dart';
import 'package:kaldmv/app/modules/leauge_officials/league_official_matches/views/league_official_matches_view.dart';
import 'package:kaldmv/app/widgets/custom_svg_icon.dart';
import 'package:kaldmv/core/constants/app_icons.dart';

import '../../../referee/message/controllers/message_controller.dart';
import '../../../referee/message/views/message_view.dart';
import '../../RefereesSide/views/referees_side_view.dart';
import '../../add_match/modules/views/add_match_modules_view.dart';

import '../controllers/home_leauge_controller.dart';
import 'leaugehomeview.dart';

class HomeLeagueView extends GetView<HomeLeaugeController> {
  const HomeLeagueView({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      LeaugeHomeView(),
      LeagueOfficialMatchesView(),
      AddMatchModulesView(),
      RefereesSideView(),
      MessageView(),
    ];

    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: controller.currentIndex.value == 4
                ? null
                : PreferredSize(
                    preferredSize: Size.fromHeight(80.h),
                    child: _buildAppBar(),
                  ),
            endDrawer: const AppEndDrawer(),
            body: pages[controller.currentIndex.value],
            bottomNavigationBar: _buildBottomNav(),
          ),

        ],
      ),
    );
  }

  // =========================
  // AppBar
  // =========================
  Widget _buildAppBar() {
    return Container(
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
          child: Obx(
            () => Row(
              children: [
                /// Profile Image
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: controller.profileImage.value.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: controller.profileImage.value,
                            fit: BoxFit.cover,
                            width: 50.w,
                            height: 50.h,
                            placeholder: (_, __) => Container(
                              color: Colors.white.withOpacity(0.1),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            errorWidget: (_, __, ___) => Container(
                              color: Colors.white.withOpacity(0.1),
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Container(
                            color: Colors.white.withOpacity(0.1),
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),

                SizedBox(width: 12.w),

                /// Name & Greeting
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.profileName.value.isNotEmpty
                            ? controller.profileName.value
                            : 'Loading...',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        controller.greeting,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),

                /// Notification
                GestureDetector(
                  onTap: () => Get.toNamed('/notification'),
                  child: Stack(
                    children: [
                      const CustomSvgIcon(
                        assetName: 'assets/icons/notification_bell.svg',
                      ),
                      Obx(() {
                        if (controller.notificationCount.value <= 0) {
                          return const SizedBox.shrink();
                        }
                        return Positioned(
                          right: 0,
                          top: 0,
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
                ),

                SizedBox(width: 16.w),

                /// Drawer
                Builder(
                  builder: (context) => GestureDetector(
                    onTap: () => Scaffold.of(context).openEndDrawer(),
                    child: const CustomSvgIcon(
                      assetName: 'assets/icons/hum_menu.svg',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =========================
  // Bottom Navigation
  // =========================
  Widget _buildBottomNav() {
    final icons = [
      AppIcons.home,
      AppIcons.football,
      AppIcons.add,
      AppIcons.referee,
      AppIcons.message,
    ];

    final labels = ['Home', 'Matches', 'Add', 'Referees', 'Message'];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
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
            children: List.generate(
              icons.length,
              (index) => _buildNavItem(
                svgIcon: icons[index],
                label: labels[index],
                index: index,
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
  }) {
    final isSelected = controller.currentIndex.value == index;

    return GestureDetector(
      onTap: () => controller.currentIndex.value = index,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomSvgIcon(
            assetName: svgIcon,
            color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
