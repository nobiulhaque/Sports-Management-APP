import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../widgets/custom_profile_card.dart';
import '../../../../../widgets/performance_progress_widget.dart';
import '../controllers/rating_controller.dart';
import 'match_performance_card.dart';

class RatingView extends GetView<RatingController> {
  RatingView({super.key});
  @override
  final controller = Get.put(RatingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${controller.errorMessage.value}'),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () => controller.fetchRatingPageData(),
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Card
              if (controller.profile.value != null)
                CustomProfileCard(
                  elevation: 2,
                  color: const Color.fromARGB(255, 24, 58, 131),
                  borderRadius: 20,
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        Center(
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 45.r,
                                backgroundImage: NetworkImage(
                                  controller.profile.value!.avatarUrl,
                                ),
                                onBackgroundImageError: (_, __) {
                                  // Fallback
                                },
                              ),
                              Container(
                                padding: EdgeInsets.all(4.w),
                                decoration: const BoxDecoration(
                                  color: Colors.amber,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.workspace_premium_outlined,
                                  size: 16.r,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Center(
                          child: Text(
                            controller.profile.value!.name,
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            controller.profile.value!.title,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Center(
                          child: Text(
                            controller.profile.value!.location,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Center(
                          child: Text(
                            '${controller.profile.value!.experienceYears} Years Experience',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16.sp),
                            SizedBox(width: 4.w),
                            Text(
                              '${controller.profile.value!.averageRating.toStringAsFixed(1)}/5',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 20.h),

              // Performance Progress Section
              if (controller.performanceData.isNotEmpty)
                PerformanceProgressWidget(
                  performanceData: controller.performanceData.toList(),
                ),
              SizedBox(height: 24.h),

              // Match Performance Statistics Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Match Performance Statistics',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Explore your match-by-match performance feedback from league officials and assessors.',
                    style: TextStyle(fontSize: 12.sp, color: Colors.black54),
                  ),
                  SizedBox(height: 16.h),
                  if (controller.matchPerformances.isEmpty)
                    Center(child: Text('No match data available'))
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.matchPerformances.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final match = controller.matchPerformances[index];
                        return MatchPerformanceCard(match: match);
                      },
                    ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
