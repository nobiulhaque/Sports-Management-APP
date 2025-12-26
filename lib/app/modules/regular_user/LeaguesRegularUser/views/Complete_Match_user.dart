// ignore_for_file: use_full_hex_values_for_flutter_colors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/leauge_officials/leaugeDrawer/rate_referee/views/widgets/cotch_rivew.dart';
import 'package:kaldmv/app/modules/leauge_officials/leaugeDrawer/rate_referee/views/widgets/details_Card.dart';
import 'package:kaldmv/app/modules/leauge_officials/leaugeDrawer/rate_referee/views/widgets/statistics_card.dart';
import 'package:kaldmv/app/modules/leauge_officials/widgets/custom_app_bar.dart';
import 'package:kaldmv/core/constants/app_colors.dart';
import 'package:kaldmv/core/utils/utils.dart';
import '../../../leauge_officials/leaugeDrawer/rate_referee/controllers/rate_referee_controller.dart';

class ViewDetailsMatchuser extends GetView<RateRefereeController> {
  const ViewDetailsMatchuser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarLeauge(title: 'Complete Match Details'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DetailsCard(),
              SizedBox(height: 20.h),
              MatchStatistics(
                statistics: [
                  StatisticData(
                    label: 'Yellow Cards',
                    value: 3,
                    backgroundColor: const Color(0xFFFFFAED),
                    valueColor: const Color(0xFFFF9800),
                    bColor: Color(0xFFFEF3C6),
                  ),
                  StatisticData(
                    label: 'Red Cards',
                    value: 0,
                    backgroundColor: const Color(0xFFFFE5E5),
                    valueColor: const Color(0xFFF44336),
                    bColor: Color(0xFFFFE2E2),
                  ),
                  StatisticData(
                    label: 'Fouls Called',
                    value: 18,
                    backgroundColor: const Color(0xFFE3F2FD),
                    valueColor: const Color(0xFF2196F3),
                    bColor: Color(0xFFDBEAFE),
                  ),
                  StatisticData(
                    label: 'Offsides',
                    value: 7,
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

              // Feedback Card
              SizedBox(height: 12.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: 16.w,
                        left: 16.w,
                        top: 16.h,
                      ),
                      child: Text(
                        'How was the referee\'s performance?',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: const Color(0xFFD1D5DB)),
                      ),
                      child: Column(
                        children: [
                          _buildRatingRow('Fairness', 4),
                          SizedBox(height: 12.h),
                          _buildRatingRow('Control', 4),
                          SizedBox(height: 12.h),
                          _buildRatingRow('Positioning', 4),
                          SizedBox(height: 12.h),
                          _buildRatingRow('Communication', 4),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16.w, right: 12.w),
                          child: Container(
                            width: 50.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F5F5),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image(
                                image: AssetImage('assets/images/laliga.png'),
                                width: 24.w,
                                height: 24.h,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFAAB8C7),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 16.w),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Add a comment...',
                                        hintStyle: TextStyle(
                                          color: Color(0xFFB8C9DB),
                                          fontSize: 16.sp,
                                        ),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 12.h,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 12.w),
                                  child: Icon(
                                    Icons.send,
                                    color: Color(0xFF2F4CDD),
                                    size: 24.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                      ],
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Column(
                  children: [
                    CoachReviewWidget(
                      coachName: 'Ahmed Rahman',
                      coachRole: 'Coach- BD Tigers',
                      reviewText:
                      'Jonathan is professional and maintains excellent control over matches. Highly recommended.',
                      overallRating: 4.0,
                      profileImageUrl: 'assets/dynamic/cotch.png',
                      skillRatings: {
                        'Fairness': 4,
                        'Control': 4,
                        'Positioning': 4,
                        'Communication': 4,
                      },
                    ),

                    CoachReviewWidget(
                      coachName: 'Ahmed Rahman',
                      coachRole: 'Coach- BD Tigers',
                      reviewText:
                      'Jonathan is professional and maintains excellent control over matches. Highly recommended.',
                      overallRating: 4.0,
                      profileImageUrl: 'assets/dynamic/cotch.png',
                      skillRatings: {
                        'Fairness': 4,
                        'Control': 4,
                        'Positioning': 4,
                        'Communication': 4,
                      },
                    ),

                    CoachReviewWidget(
                      coachName: 'Ahmed Rahman',
                      coachRole: 'Coach- BD Tigers',
                      reviewText:
                      'Jonathan is professional and maintains excellent control over matches. Highly recommended.',
                      overallRating: 4.0,
                      profileImageUrl: 'assets/dynamic/cotch.png',
                      skillRatings: {
                        'Fairness': 4,
                        'Control': 4,
                        'Positioning': 4,
                        'Communication': 4,
                      },
                    ),

                    CoachReviewWidget(
                      coachName: 'Ahmed Rahman',
                      coachRole: 'Coach- BD Tigers',
                      reviewText:
                      'Jonathan is professional and maintains excellent control over matches. Highly recommended.',
                      overallRating: 4.0,
                      profileImageUrl: 'assets/dynamic/cotch.png',
                      skillRatings: {
                        'Fairness': 4,
                        'Control': 4,
                        'Positioning': 4,
                        'Communication': 4,
                      },
                    ),
                    SizedBox(height: 8.h),

                    //view All Button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Utils.primaryButton(
                        context: context,
                        width: double.infinity,
                        title: 'View All ',
                        backgroundColor: AppColors.accentGreen,
                        textColor: AppColors.white,
                        onTap: () {},
                      ),
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper method to build each rating row
Widget _buildRatingRow(String label, int ratingCount) {
  return Row(
    children: [
      Expanded(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
        ),
      ),
      ...List.generate(5, (index) {
        return Padding(
          padding: EdgeInsets.only(right: index < 0 ? 1.w : 0.4),
          child: Icon(
            Icons.star,
            color: index < ratingCount
                ? const Color(0xFFFFD700) // Gold for filled stars
                : const Color(0xFFD1D5DB), // Grey for empty stars
            size: 20.sp,
          ),
        );
      }),
    ],
  );
}
