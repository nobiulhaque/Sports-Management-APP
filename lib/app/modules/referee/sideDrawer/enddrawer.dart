import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/referee/sideDrawer/controllers/drawer_controller.dart'
    as side_drawer;
import 'package:kaldmv/app/routes/app_pages.dart';
import 'package:kaldmv/app/widgets/logout_confirm_dialog.dart';
import 'package:kaldmv/app/widgets/rate_us_dialog.dart';
import 'package:kaldmv/core/constants/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DrawerMenu extends GetView<side_drawer.SideDrawerController> {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Obx(
        () => Skeletonizer(
          enabled: controller.isLoading.value,
          effect: PulseEffect(duration: const Duration(milliseconds: 1000)),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // ✅ Header section
              SizedBox(
                height: 237.h,
                child: DrawerHeader(
                  decoration: const BoxDecoration(color: Color(0xFF1E3A8A)),
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.all(16.w),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile Avatar
                          controller.image.value.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(35.r),
                                  child: CachedNetworkImage(
                                    imageUrl: controller.image.value,
                                    width: 70.r,
                                    height: 70.r,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => CircleAvatar(
                                      radius: 35.r,
                                      backgroundColor: Colors.white24,
                                      child: Icon(
                                        Icons.person,
                                        size: 50.r,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        CircleAvatar(
                                          radius: 35.r,
                                          backgroundColor: Colors.white24,
                                          child: Icon(
                                            Icons.person,
                                            size: 50.r,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 35.r,
                                  backgroundColor: Colors.white24,
                                  child: Icon(
                                    Icons.person,
                                    size: 50.r,
                                    color: AppColors.primary,
                                  ),
                                ),
                          SizedBox(height: 12.h),

                          // User name
                          Text(
                            controller.name.value,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 5.h),

                          // User email
                          Text(
                            controller.email.value,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // ✅ Menu Items
              _buildMenuItem(
                icon: Icons.person_outline,
                title: 'Profile',
                onTap: () {
                  // close the drawer then navigate using the app's Navigator
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              _buildMenuItem(
                icon: Icons.list_alt_outlined,
                title: 'Request List',
                onTap: () {
                  // close the drawer then navigate using the app's Navigator
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/request-list');
                },
              ),
              _buildMenuItem(
                icon: Icons.star_rate_rounded,
                title: 'Rate Team Conduct',
                onTap: () {
                  // close the drawer then navigate using the app's Navigator
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Routes.RATE_TEAM_CONDUCT);
                },
              ),
              _buildMenuItem(
                icon: Icons.auto_awesome_outlined,
                title: 'Rate this app',
                onTap: () {
                  // close the drawer then navigate using the app's Navigator
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => const RateUsDialog(),
                  );
                },
              ),
              _buildMenuItem(
                icon: Icons.lock_outline,
                title: 'Change Password',
                onTap: () {
                  // close the drawer then navigate using the app's Navigator
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/changepassword');
                },
              ),
              _buildMenuItem(
                icon: Icons.support_agent_outlined,
                title: 'Contact Support',
                onTap: () {
                  // close the drawer then navigate using the app's Navigator
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/contactsupport');
                },
              ),
              _buildMenuItem(
                icon: Icons.logout_outlined,
                title: 'Logout',
                onTap: () async {
                  // Close the Drawer
                  Navigator.pop(context);

                  // Give the drawer a moment to close for smoother UX
                  await Future.delayed(const Duration(milliseconds: 200));

                  // Show confirm dialog and handle logout
                  // ignore: use_build_context_synchronously
                  await showLogoutConfirmDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ Reusable menu item widget
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 10),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF334155), size: 22.w),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            color: const Color(0xFF334155),
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
