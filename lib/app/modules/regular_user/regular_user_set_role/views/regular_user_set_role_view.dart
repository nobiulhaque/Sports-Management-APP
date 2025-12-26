import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/regular_user/regular_user_set_role/controllers/regular_user_set_role_controller.dart';
import 'package:kaldmv/core/constants/app_colors.dart';

class RegularUserSetRoleView extends StatelessWidget {
  RegularUserSetRoleView({super.key});

  final RegularUserSetRoleController ctrl =
      Get.put(RegularUserSetRoleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              InkWell(
                onTap: () => Get.back(),
                child: SizedBox(
                  height: 48.h,
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new,
                        size: 17.sp,
                        color: AppColors.black,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Back',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 22.h),
              // Title
              Text(
                'Select User Type',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.h),
              // Subtitle
              Text(
                'Select a profile type which matches your general activity.',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF61758A),
                ),
              ),
              SizedBox(height: 15.h),

              // Role Cards
              Expanded(
                child: Obx(() {
                  final roles = ctrl.roles;
                  final selected = ctrl.selectedRole.value;
                  // Build rows of two
                  List<Widget> rows = [];
                  for (int i = 0; i < roles.length; i += 2) {
                    final left = roles[i];
                    final right = (i + 1) < roles.length ? roles[i + 1] : null;
                    rows.add(Row(
                      children: [
                        Expanded(
                          child: _RoleCard(
                            imagePath: left.imagePath,
                            label: left.label,
                            isSelected: selected == left.key,
                            onTap: () => ctrl.selectRole(left.key),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: right != null
                              ? _RoleCard(
                                  imagePath: right.imagePath,
                                  label: right.label,
                                  isSelected: selected == right.key,
                                  onTap: () => ctrl.selectRole(right.key),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ));
                    rows.add(SizedBox(height: 16.h));
                  }

                  return SingleChildScrollView(
                    child: Column(children: rows),
                  );
                }),
              ),
              SizedBox(height: 24.h),

              // Error message (if any)
              Obx(() {
                final err = ctrl.errorMessage.value;
                if (err == null || err.isEmpty) return const SizedBox.shrink();
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Text(
                    err,
                    style: TextStyle(color: Colors.red, fontSize: 14.sp),
                  ),
                );
              }),

              // Proceed Button
              Obx(() {
                final isLoading = ctrl.isLoading.value;
                final selected = ctrl.selectedRole.value;
                return SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: (selected == null || isLoading)
                        ? null
                        : () {
                            ctrl.proceed();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      disabledBackgroundColor: const Color(0xFFE5E7EB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.r),
                      ),
                      elevation: 0,
                    ),
                    child: isLoading
                        ? SizedBox(
                            height: 20.h,
                            width: 20.h,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            'Proceed',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                );
              }),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.imagePath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF1E3A8A) : Colors.transparent,
            width: 2,
          ),
          color: const Color(0xFFF3F4F6),
        ),
        child: Stack(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(7.r),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 200.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 200.h,
                    color: const Color(0xFFF3F4F6),
                    child: Center(
                      child: Icon(Icons.person, size: 80.sp),
                    ),
                  );
                },
              ),
            ),
            // Label overlay at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(7.r),
                    bottomRight: Radius.circular(7.r),
                  ),
                ),
                child: Text(
                  label,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Selected checkmark
            if (isSelected)
              Positioned(
                top: 7.h,
                right: 7.w,
                child: Icon(
                  Icons.check_circle,
                  color: const Color(0xFF1E3A8A),
                ),
              ),
          ],
        ),
      ),
    );
  }
}