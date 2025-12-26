import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/leauge_officials/leaugeDrawer/profile/leauge_profile/views/widgets/leauge_info_section.dart';
import 'package:kaldmv/app/modules/leauge_officials/leaugeDrawer/profile/leauge_profile/views/widgets/official_representative_card.dart';
import 'package:kaldmv/app/widgets/custom_profile_card.dart';
import 'package:kaldmv/core/constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/utils.dart';
import '../custom_back_button.dart';
import 'shared_league_profile_controller.dart';

class SharedLeagueProfileView extends GetView<SharedLeagueProfileController> {
  final String leagueId;

  const SharedLeagueProfileView({super.key, required this.leagueId});

  @override
  String get tag => leagueId;

  String _getDisplayValue(String? value) {
    if (value == null || value.isEmpty) {
      return "N/A";
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          final data = controller.profileData.value;
          final user = data?.user;
          final isLoading = controller.isLoading.value;

          if (isLoading) {
            return _buildShimmerLoading();
          }

          return Column(
            children: [
              _buildAppBar(),
              SizedBox(height: 15.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        // League Header Card
                        if (user?.name != null ||
                            user?.email != null ||
                            data?.leagueStatus != null ||
                            data?.founded != null && data?.founded != 0)
                          Column(
                            children: [
                              CustomProfileCard(
                                elevation: 2,
                                color: AppColors.primary,
                                borderRadius: 20,
                                child: Padding(
                                  padding: EdgeInsets.all(16.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10.h),
                                      Center(
                                        child: CircleAvatar(
                                          radius: 45.r,
                                          backgroundColor: Colors.grey.shade300,
                                          backgroundImage:
                                              (user?.image?.isNotEmpty ?? false)
                                              ? NetworkImage(user!.image!)
                                              : null,
                                          child: (user?.image?.isEmpty ?? true)
                                              ? Icon(
                                                  Icons.sports_soccer,
                                                  size: 50.r,
                                                  color: AppColors.primary,
                                                )
                                              : null,
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Center(
                                        child: Text(
                                          user?.name ?? 'N/A',
                                          style: TextStyle(
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      if (user?.email != null)
                                        Center(
                                          child: Text(
                                            user!.email,
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ),
                                      if (data?.leagueStatus != null)
                                        Column(
                                          children: [
                                            SizedBox(height: 5.h),
                                            Center(
                                              child: Text(
                                                data!.leagueStatus,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (data?.founded != null &&
                                          data!.founded > 0)
                                        Column(
                                          children: [
                                            SizedBox(height: 5.h),
                                            Center(
                                              child: Text(
                                                'Founded in ${data.founded}',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),
                            ],
                          ),

                        // View Details Button
                        Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(8.r),
                          child: Utils.primaryButton(
                            backgroundColor: AppColors.secondary,
                            context: context,
                            onTap: () {
                              // Edit profile functionality
                            },
                            title: 'Message League',
                            width: double.infinity,
                          ),
                        ),
                        SizedBox(height: 16.h),

                        // League Info Section
                        LeagueInfoSection(
                          organizationId: _getDisplayValue(
                            data?.organizationId,
                          ),
                          country: _getDisplayValue(data?.country),
                          certifyingAuthority: _getDisplayValue(
                            data?.certifyingAuthority,
                          ),
                          validUntil: _getDisplayValue(data?.licenseValidTill),
                          level: _getDisplayValue(data?.level),
                        ),
                        SizedBox(height: 20.h),

                        // Official Representative Card
                        OfficialRepresentativeCard(
                          fullName: _getDisplayValue(data?.officialName),
                          designation: _getDisplayValue(
                            data?.officialDesignation,
                          ),
                          contactNumber: _getDisplayValue(data?.officialPhone),
                          email: _getDisplayValue(data?.officialEmail),
                          profileImage: data?.officialImage,
                        ),
                        SizedBox(height: 20.h),

                        // Account Information Card
                        // Uncomment when API provides match data
                        // AccountInformationCard(
                        //   joinedDate: _getDisplayValue(data?.joinedOn),
                        //   accountType: _getDisplayValue(data?.leagueStatus),
                        //   refereesHired: data?.refereesHired ?? 0,
                        //   ongoingMatches: data?.ongoingMatches ?? 0,
                        //   pendingMatches: data?.pendingMatches ?? 0,
                        //   completedMatches: data?.completedMatches ?? 0,
                        // ),
                        // SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Column(
      children: [
        _buildAppBar(),
        SizedBox(height: 15.h),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  // Shimmer Header Card
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 200.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Shimmer Button
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Shimmer Content
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      children: List.generate(
                        3,
                        (index) => Column(
                          children: [
                            Container(
                              height: 150.h,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            SizedBox(height: 16.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return Row(
      children: [
        const CustomBackButton(),
        Expanded(
          child: Center(
            child: Text(
              'League Profile',
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SizedBox(width: 48.w),
      ],
    );
  }
}
