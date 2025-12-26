// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/regular_user/LeaguesRegularUser/controllers/league_profile_controller.dart';
import 'package:kaldmv/app/widgets/custom_profile_card.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../widgets/custom_back_button.dart';
import '../../../leauge_officials/home_leauge/views/widgets/custom_infoCard.dart';
import '../../home_regular_user/views/widgets/regular_referees_section.dart';


class LeagueProfileViewsRegular extends GetView<LeagueProfileController> {
  LeagueProfileViewsRegular({super.key});
  final controller = Get.put(LeagueProfileController());

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(LeaguesRegularUserController());
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 70.w,
        leading: CustomBackButton(),
        title: Center(
          child: Text(
            'Profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [SizedBox(width: 70.w)], // To center the title
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 16),
              _buildHeaderCard(),
              const SizedBox(height: 12),
              CustomInfoCard(
                icon: const Icon(Icons.sports_soccer, color: AppColors.primary),
                title: "League Information",
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoItem(
                      title: "Organization ID",
                      value: "#LLA-2025",
                    ),
                    const SizedBox(height: 12),

                    _buildInfoItem(
                      title: "Certifying Authority",
                      value: "Bangladesh Football Federation",
                    ),
                    const SizedBox(height: 12),

                    _buildInfoItem(
                      title: "License Valid Till",
                      value: "December 2026",
                    ),
                    const SizedBox(height: 12),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Level",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF003366),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "National",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 16),
              RegularRefereesSection(),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Obx(
      () => SizedBox(
        width: double.infinity,
        child: CustomProfileCard(
          elevation: 2,
          color: const Color.fromARGB(255, 24, 58, 131),
          borderRadius: 20,
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.h),
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      controller.logoAsset.value,
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  controller.name.value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.email.value,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 16),
                Text(
                  controller.leagueType.value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.foundedYear.value,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem({required String title, required String value}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
