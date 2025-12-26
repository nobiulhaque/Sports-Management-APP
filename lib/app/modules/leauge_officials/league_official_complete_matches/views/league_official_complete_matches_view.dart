import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kaldmv/app/modules/leauge_officials/league_official_complete_matches/views/widgets/RefereeFeedbackCard.dart';
import 'package:kaldmv/app/modules/leauge_officials/league_official_complete_matches/views/widgets/complete_match_referees_container.dart';
import 'package:kaldmv/app/modules/leauge_officials/league_official_complete_matches/views/widgets/complete_match_score_info_container.dart';

import 'package:kaldmv/app/modules/leauge_officials/league_official_complete_matches/views/widgets/complete_match_statistics_container.dart';
import 'package:kaldmv/app/modules/leauge_officials/widgets/custom_app_bar.dart';
import 'package:kaldmv/core/utils/utils.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_icons.dart';
import '../controllers/league_official_complete_matches_controller.dart';

class LeagueOfficialCompleteMatchesView
    extends GetView<LeagueOfficialCompleteMatchesController> {
  const LeagueOfficialCompleteMatchesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBarLeauge(title: 'Complete Matches'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 24.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CompleteMatchScoreInfoContainer(),
                    CompleteMatchStatisticsContainer(),
                    CompleteMatchRefereesContainer(),
                    Utils.cardTitleSection(
                      context: context,
                      fontSize: 18.sp,
                      iconImagePath: AppIcons.starOutlined,
                      iconColor: Color(0xFF2701FF),
                      title: 'Referee Feedback',
                      backgroundColor: Color(0xFF2701FF).withAlpha(25),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Column(
                        children: [
                          Utils.primaryButton(
                            context: context,
                            title: 'View All',
                            backgroundColor: AppColors.secondary,
                          ),
                          SizedBox(height: 16.h),
                          Column(
                            spacing: 16.h,
                            children: List.generate(2, (index) {
                              return RefereeFeedbackCard();
                            }),
                          ),
                        ],
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
    );
  }
}
