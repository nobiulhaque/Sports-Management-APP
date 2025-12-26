// ignore_for_file: use_full_hex_values_for_flutter_colors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/leauge_officials/leaugeDrawer/rate_referee/views/widgets/cotch_rivew.dart';
import 'package:kaldmv/app/modules/leauge_officials/leaugeDrawer/rate_referee/views/widgets/details_Card.dart';
import 'package:kaldmv/app/modules/leauge_officials/leaugeDrawer/rate_referee/views/widgets/statistics_card.dart';
import 'package:kaldmv/app/modules/leauge_officials/widgets/custom_app_bar.dart';
import 'package:kaldmv/core/constants/app_colors.dart';
import '../controllers/view_details_match_controller.dart';

class ViewDetailsMatch extends GetView<ViewDetailsMatchController> {
  const ViewDetailsMatch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarLeauge(title: 'Complete Match Details'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final matchDetails = controller.matchDetails.value;
        final match = matchDetails?.match;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                DetailsCard(matchDetails: matchDetails),
                SizedBox(height: 20.h),
                MatchStatistics(
                  statistics: [
                    StatisticData(
                      label: 'Yellow Cards',
                      value: match?.yellowCards ?? 0,
                      backgroundColor: const Color(0xFFFFFAED),
                      valueColor: const Color(0xFFFF9800),
                      bColor: Color(0xFFFEF3C6),
                    ),
                    StatisticData(
                      label: 'Red Cards',
                      value: match?.redCards ?? 0,
                      backgroundColor: const Color(0xFFFFE5E5),
                      valueColor: const Color(0xFFF44336),
                      bColor: Color(0xFFFFE2E2),
                    ),
                    StatisticData(
                      label: 'Fouls Called',
                      value: match?.foulsCalled ?? 0,
                      backgroundColor: const Color(0xFFE3F2FD),
                      valueColor: const Color(0xFF2196F3),
                      bColor: Color(0xFFDBEAFE),
                    ),
                    StatisticData(
                      label: 'Offsides',
                      value: match?.offsides ?? 0,
                      backgroundColor: const Color(0xFFF3E5F5),
                      valueColor: const Color(0xFF9C27B0),
                      bColor: Color(0xFFF3E8FF),
                    ),
                  ],
                  title: 'Match Statistics',
                ),
                //Feedback Section
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF9C2),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.star_border_outlined,
                        color: const Color(0xFFF59E0B),
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Feedback',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                if (matchDetails?.allFeedback != null &&
                    matchDetails!.allFeedback!.isNotEmpty)
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: matchDetails.allFeedback!.length,
                    separatorBuilder: (context, index) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final feedback = matchDetails.allFeedback![index];
                      return Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                          ),
                          child: CoachReviewWidget(
                            coachName: feedback.reviewer?.name ?? 'Unknown',
                            coachRole: feedback.reviewer?.role ?? 'Reviewer',
                            reviewText: feedback.comment ?? 'No comment',
                            overallRating:
                                (feedback.overallRating ?? 0).toDouble(),
                            profileImageUrl: feedback.reviewer?.image ??
                                'assets/dynamic/cotch.png',
                            skillRatings: {
                              'Fairness': feedback.fairness ?? 0,
                              'Control': feedback.control ?? 0,
                              'Positioning': feedback.positioning ?? 0,
                              'Communication': feedback.communication ?? 0,
                            },
                          ));
                    },
                  )
                else
                  Text("No feedback available"),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      }),
    );
  }
}
