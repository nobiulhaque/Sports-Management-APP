import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:kaldmv/app/modules/leauge_officials/leaugeDrawer/profile/leauge_profile/views/widgets/account_info_card.dart';
import 'package:kaldmv/app/modules/leauge_officials/leaugeDrawer/profile/leauge_profile/views/widgets/leauge_header_card.dart';
import 'package:kaldmv/app/modules/leauge_officials/leaugeDrawer/profile/leauge_profile/views/widgets/leauge_info_section.dart';
import 'package:kaldmv/app/modules/leauge_officials/leaugeDrawer/profile/leauge_profile/views/widgets/official_representative_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../../core/utils/utils.dart';
import '../../../../../../widgets/custom_back_button.dart';
import '../controllers/leauge_profile_controller.dart';

class LeaugeProfileView extends GetView<LeaugeProfileController> {
  const LeaugeProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          final data = controller.profileData;
          final user = data?.user;
          final official = data?.leagueOfficialsId;

          return Skeletonizer(
            enabled: controller.isLoading.value,
            child: Column(
              children: [
                _buildAppBar(),
                SizedBox(height: 15.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          LeagueHeaderCard(
                            leagueName: user?.name ?? 'League Name',
                            email: user?.email ?? 'league@example.com',
                            leagueType: official?.level ?? 'Professional',
                            foundedYear:
                                "Founded in ${official?.founded ?? 1929}",
                            profileImage: user?.image ?? '',
                          ),

                          SizedBox(height: 16.h),

                          Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(8.r),
                            child: Utils.primaryButton(
                              context: context,
                              onTap: () => Get.toNamed('/leauge-edit-profile'),
                              title: 'Edit Profile',
                              width: double.infinity,
                            ),
                          ),

                          SizedBox(height: 16.h),

                          LeagueInfoSection(
                            organizationId:
                                official?.organizationId ?? "#LLA-2025",
                            country: official?.country ?? "Country",
                            certifyingAuthority:
                                official?.certifyingAuthority ?? "Authority",
                            validUntil: official?.licenseValid ?? "Valid Until",
                            level: official?.level ?? "Level",
                          ),

                          SizedBox(height: 20.h),

                          OfficialRepresentativeCard(
                            fullName: official?.officialName ?? "Full Name",
                            designation:
                                official?.officialDesignation ?? "Designation",
                            contactNumber:
                                official?.officialPhone ?? "Contact Number",
                            email:
                                official?.officialEmail ?? "email@example.com",
                            profileImage: official?.officialImage,
                          ),

                          SizedBox(height: 20.h),

                          AccountInformationCard(
                            joinedDate: user?.joinedAt ?? 'Joined Date',
                            accountType: user?.role ?? 'Account Type',
                            refereesHired: data?.totalReferees ?? 0,
                            ongoingMatches: data?.ongoingMatches ?? 0,
                            pendingMatches: data?.pendingMatches ?? 0,
                            completedMatches: data?.completedMatches ?? 0,
                          ),

                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      children: [
        const CustomBackButton(),
        Expanded(
          child: Center(
            child: Text(
              'Profile',
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SizedBox(width: 48.w),
      ],
    );
  }
}
