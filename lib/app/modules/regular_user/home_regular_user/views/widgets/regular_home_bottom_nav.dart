import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/regular_user/home_regular_user/controllers/home_regular_user_controller.dart';
import 'package:kaldmv/app/widgets/custom_svg_icon.dart';


class RegularHomeBottomNav extends GetView<HomeRegularUserController> {
  const RegularHomeBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                controller.navItems.length,
                (index) => _buildNavItem(
                  navItem: controller.navItems[index],
                  isSelected: controller.currentIndex.value == index,
                  onTap: () => controller.updateNavIndex(index),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required NavItem navItem,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: isSelected ? 1.1 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomSvgIcon(
              assetName: navItem.svgIcon,
              color: isSelected ? const Color(0xFF1E40AF) : Colors.grey,
            ),
            SizedBox(height: 4.h),
            Text(
              navItem.label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? const Color(0xFF1E40AF) : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}