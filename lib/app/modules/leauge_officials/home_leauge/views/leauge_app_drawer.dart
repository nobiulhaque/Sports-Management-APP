import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kaldmv/app/modules/leauge_officials/home_leauge/controllers/home_leauge_controller.dart';
import 'package:kaldmv/app/widgets/custom_svg_icon.dart';
import 'package:kaldmv/app/widgets/logout_confirm_dialog.dart';
import 'package:kaldmv/app/widgets/rate_us_dialog.dart';

class AppEndDrawer extends StatelessWidget {
  const AppEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeLeaugeController>();
    
    return Drawer(
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
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Avatar
                        CircleAvatar(
                          radius: 35.r,
                          backgroundColor: Colors.white24,
                          child: controller.profileImage.value.isNotEmpty
                              ? ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: controller.profileImage.value,
                                    width: 70.r,
                                    height: 70.r,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                )
                              : const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 40,
                                ),
                        ),
                        SizedBox(height: 12.h),

                        // User name
                        Text(
                          controller.profileName.value.isNotEmpty
                              ? controller.profileName.value
                              : 'Loading...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5.h),

                        // User email
                        Text(
                          controller.profileEmail.value.isNotEmpty
                              ? controller.profileEmail.value
                              : 'example@mail.com',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ✅ Menu Items
          _buildMenuItem(
            svgPath: 'assets/images/profile.svg',
            title: 'Profile',
            onTap: () {
              // close the drawer then navigate using the app's Navigator
              Navigator.pop(context);
              // Navigator.pushNamed(context, '/profile');
              Get.toNamed('/leauge-profile');
            },
          ),
          _buildMenuItem(
            icon: Icons.list_alt_outlined,
            title: 'Request List',
            onTap: () {
              // close the drawer then navigate using the app's Navigator
              Navigator.pop(context);
              Navigator.pushNamed(context, '/requestlist');
            },
          ),
          _buildMenuItem(
            svgPath: 'assets/images/rate_stars.svg',
            title: 'Rate Raferee',
            onTap: () {
              // close the drawer then navigate using the app's Navigator
              Get.toNamed('/rate-referee');
            },
          ),
          _buildMenuItem(
            svgPath: 'assets/images/rate.svg',
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
            svgPath: 'assets/images/crown.svg',
            title: 'Try Premium',
            onTap: () {
              // close the drawer then navigate using the app's Navigator
              Get.toNamed('/premium');
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
            svgPath: 'assets/images/contact.svg',
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
    );
  }

  /// ✅ Reusable menu item widget
  Widget _buildMenuItem({
    IconData? icon,
    String? imagePath,
    String? svgPath,
    required String title,
    required VoidCallback onTap,
  }) {
    Widget leadingWidget;

    if (imagePath != null) {
      leadingWidget = Image.asset(
        imagePath,
        color:Color(0xFF61758A),
        width: 22.w,
        height: 22.w,
        fit: BoxFit.contain,
      );
    } else if (svgPath != null) {
      leadingWidget = CustomSvgIcon(
        assetName: svgPath,
        color:Color(0xFF61758A),
        width: 18.w,
        height: 18.w,
      );
    } else {
      leadingWidget = Icon(icon, size: 22.w, color:Color(0xFF61758A));
    }

    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 10),
      child: ListTile(
        leading: leadingWidget,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            color: Color(0xFF030709),
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
