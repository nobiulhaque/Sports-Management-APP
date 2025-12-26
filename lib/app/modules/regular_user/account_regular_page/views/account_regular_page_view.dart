import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/widgets/logout_confirm_dialog.dart';
import 'package:kaldmv/app/widgets/rate_us_dialog.dart';
import 'package:kaldmv/core/constants/app_colors.dart';
import '../controllers/account_regular_page_controller.dart';

class AccountRegularPageView extends GetView<AccountRegularPageController> {
  const AccountRegularPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Profile Header Section
              _buildProfileHeader(),
              const SizedBox(height: 40),
              // Menu Items Section
              _buildMenuItems(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Profile Header Widget
  Widget _buildProfileHeader() {
    return Obx(() {
      final profile = controller.userProfile.value;
      final isLoading = controller.isLoading.value;

      if (isLoading && profile == null) {
        return const Center(child: CircularProgressIndicator());
      }

      final String imagePath = profile?.image ?? 'assets/images/u3.png';
      final String name = profile?.name ?? 'Guest User';
      final String role = profile?.role ?? 'User';

      return Column(
        children: [
          // Avatar with Image Asset or Network Image
          Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE8EEFA),
              image: imagePath.isNotEmpty && imagePath.startsWith('http')
                  ? DecorationImage(
                      image: NetworkImage(imagePath),
                      fit: BoxFit.cover,
                    )
                  : DecorationImage(
                      image: AssetImage(
                        imagePath.isNotEmpty
                            ? imagePath
                            : 'assets/images/u3.png',
                      ),
                      fit: BoxFit.cover,
                    ),
            ),
            child: imagePath.isEmpty
                ? Icon(Icons.person, size: 60.r, color: Colors.grey)
                : null,
          ),
          const SizedBox(height: 16),
          // User Name
          Text(
            name,
            style: Theme.of(Get.context!).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 24.sp,
            ),
          ),
          const SizedBox(height: 4),
          // User Subtitle
          Text(
            role,
            style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
              fontSize: 14.sp,
            ),
          ),
        ],
      );
    });
  }

  // Menu Items Widget
  Widget _buildMenuItems(BuildContext context) {
    final menuItems = [
      {
        'icon': Icons.account_circle_outlined,
        'label': 'Profile',
        'onTap': () {
          // close the drawer then navigate using the app's Navigator
          Navigator.pushNamed(context, '/profile-regular');
        },
      },
      {
        'icon': Icons.star_outline,
        'label': 'Rate this app',
        'onTap': () {
          // close the drawer then navigate using the app's Navigator
          showDialog(
            context: context,
            builder: (context) => const RateUsDialog(),
          );
        },
      },
      {
        'icon': Icons.lock_outline,
        'label': 'Change Password',
        'onTap': () {
          // close the drawer then navigate using the app's Navigator
          Navigator.pushNamed(context, '/changepassword');
        },
      },
      {
        'icon': Icons.help_outline,
        'label': 'Contact Support',
        'onTap': () {
          // close the drawer then navigate using the app's Navigator
          Navigator.pushNamed(context, '/contactsupport');
        },
      },
      {
        'icon': Icons.logout,
        'label': 'Logout',
        'onTap': () async {
          // Give a moment for smooth UX
          await Future.delayed(const Duration(milliseconds: 200));

          // Show confirm dialog and handle logout
          // ignore: use_build_context_synchronously
          await showLogoutConfirmDialog(context);
        },
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: List.generate(
          menuItems.length,
          (index) => _buildMenuItem(
            icon: menuItems[index]['icon'] as IconData,
            label: menuItems[index]['label'] as String,
            onTap: menuItems[index]['onTap'] as Function(),
            isLast: index == menuItems.length - 1,
          ),
        ),
      ),
    );
  }

  // Individual Menu Item Widget
  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required Function() onTap,
    required bool isLast,
  }) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          elevation: 3,
          borderRadius: BorderRadius.circular(4.r),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(4.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Row(
                children: [
                  // Menu Icon
                  Icon(icon, size: 24, color: Colors.grey[700]),
                  const SizedBox(width: 16),
                  // Menu Label
                  Expanded(
                    child: Text(
                      label,
                      style: Theme.of(Get.context!).textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                  // Arrow Icon
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Colors.grey[600],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (!isLast) const SizedBox(height: 12),
      ],
    );
  }
}
