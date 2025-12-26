// ignore_for_file: deprecated_member_use

import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/widgets/app_bar_widgets.dart';

import '../controllers/rate_screen_controller.dart';

class RateScreenView extends GetView<RateScreenController> {
  const RateScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: const CustomAppBar(title: 'Rate Team'),
          body: Obx(() {
            if (controller.errorMessage.value.isNotEmpty) {
              return const SizedBox.expand(child: SizedBox.shrink());
            }

            if (controller.matchDetail.value == null) {
              return const Center(child: Text('No match data available'));
            }

            final match = controller.matchDetail.value!;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Match Details Card
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.blue.shade50, Colors.blue.shade100],
                        ),
                        border: Border.all(
                          color: Colors.blue.shade200,
                          width: 1.5.w,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        children: [
                          // Score Section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 50.w,
                                      height: 50.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      padding: EdgeInsets.all(8.w),
                                      child: _buildTeamLogo(
                                        match.team1Logo ?? '',
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Flexible(
                                      child: Text(
                                        match.team1Name ?? 'Team 1',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 8.h,
                                    ),
                                    child: Text(
                                      '${match.team1Goal ?? 0} - ${match.team2Goal ?? 0}',
                                      style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 50.w,
                                      height: 50.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      padding: EdgeInsets.all(8.w),
                                      child: _buildTeamLogo(
                                        match.team2Logo ?? '',
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Flexible(
                                      child: Text(
                                        match.team2Name ?? 'Team 2',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Divider(height: 1.h, color: Colors.blue.shade200),
                          SizedBox(height: 16.h),
                          // Match Info
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 18.sp,
                                color: Colors.grey.shade600,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                match.matchStartDate ?? 'N/A',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              SizedBox(width: 20.w),
                              Icon(
                                Icons.access_time,
                                size: 18.sp,
                                color: Colors.grey.shade600,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                match.matchTime ?? 'N/A',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Divider(height: 1.h, color: Colors.blue.shade200),
                          SizedBox(height: 16.h),
                          // Overall Rating
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 1.w,
                              ),
                            ),
                            padding: EdgeInsets.all(16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Overall Match Rating',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 28.sp,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      match.overallMatchRating?.toString() ??
                                          '0',
                                      style: TextStyle(
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      ' / 5',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  _getRatingLabel(
                                    match.overallMatchRating ?? 0,
                                  ),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF10B93A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.h),
                    // Team Selection
                    Text(
                      'Select a team:',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(() {
                            final isTeam1Selected =
                                controller.selectedTeam.value == 'team1';
                            return GestureDetector(
                              onTap: () =>
                                  controller.selectedTeam.value = 'team1',
                              child: Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: isTeam1Selected
                                      ? Colors.blue.shade50
                                      : Colors.grey.shade100,
                                  border: Border.all(
                                    color: isTeam1Selected
                                        ? Colors.blue
                                        : Colors.grey.shade300,
                                    width: 2.w,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 40.w,
                                      height: 40.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.all(6.w),
                                      child: _buildTeamLogo(
                                        match.team1Logo ?? '',
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      match.team1Name ?? 'Team 1',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Obx(() {
                            final isTeam2Selected =
                                controller.selectedTeam.value == 'team2';
                            return GestureDetector(
                              onTap: () =>
                                  controller.selectedTeam.value = 'team2',
                              child: Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: isTeam2Selected
                                      ? Colors.blue.shade50
                                      : Colors.grey.shade100,
                                  border: Border.all(
                                    color: isTeam2Selected
                                        ? Colors.blue
                                        : Colors.grey.shade300,
                                    width: 2.w,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 40.w,
                                      height: 40.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.all(6.w),
                                      child: _buildTeamLogo(
                                        match.team2Logo ?? '',
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      match.team2Name ?? 'Team 2',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    // Rating Form Title
                    Text(
                      'Rate Team Conduct',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Please rate the conduct of the selected team during this match',
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    ),
                    SizedBox(height: 20.h),
                    // Sportsmanship
                    _buildConductSection(
                      title: 'Sportsmanship',
                      description: 'Fair play and respect for opponents',
                      currentRating: controller.selectedTeam.value == 'team1'
                          ? controller.team1Sportsmanship.value
                          : controller.team2Sportsmanship.value,
                      onRate: (rating) {
                        if (controller.selectedTeam.value == 'team1') {
                          controller.team1Sportsmanship.value = rating;
                        } else {
                          controller.team2Sportsmanship.value = rating;
                        }
                      },
                    ),
                    SizedBox(height: 16.h),
                    // Respect to Officials
                    _buildConductSection(
                      title: 'Respect Towards Officials',
                      description: 'Interactions with officials',
                      currentRating: controller.selectedTeam.value == 'team1'
                          ? controller.team1RespectToOfficials.value
                          : controller.team2RespectToOfficials.value,
                      onRate: (rating) {
                        if (controller.selectedTeam.value == 'team1') {
                          controller.team1RespectToOfficials.value = rating;
                        } else {
                          controller.team2RespectToOfficials.value = rating;
                        }
                      },
                    ),
                    SizedBox(height: 16.h),
                    // Coaching Conduct
                    _buildConductSection(
                      title: 'Coaching Conduct',
                      description: 'Coach and bench behavior',
                      currentRating: controller.selectedTeam.value == 'team1'
                          ? controller.team1CoachingConduct.value
                          : controller.team2CoachingConduct.value,
                      onRate: (rating) {
                        if (controller.selectedTeam.value == 'team1') {
                          controller.team1CoachingConduct.value = rating;
                        } else {
                          controller.team2CoachingConduct.value = rating;
                        }
                      },
                    ),
                    SizedBox(height: 16.h),
                    // Parents/Spectator Behavior
                    _buildConductSection(
                      title: 'Parents/Spectator Behavior',
                      description: 'General team behavior',
                      currentRating: controller.selectedTeam.value == 'team1'
                          ? controller.team1SpectatorBehavior.value
                          : controller.team2SpectatorBehavior.value,
                      onRate: (rating) {
                        if (controller.selectedTeam.value == 'team1') {
                          controller.team1SpectatorBehavior.value = rating;
                        } else {
                          controller.team2SpectatorBehavior.value = rating;
                        }
                      },
                    ),
                    SizedBox(height: 24.h),
                    // Comments Section
                    Text(
                      'Optional Comments',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextField(
                      maxLines: 4,
                      onChanged: (value) {
                        if (controller.selectedTeam.value == 'team1') {
                          controller.team1Comment.value = value;
                        } else {
                          controller.team2Comment.value = value;
                        }
                      },
                      decoration: InputDecoration(
                        hintText:
                            'Leave an optional comment(150 characters max)',
                        hintStyle: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade500,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        contentPadding: EdgeInsets.all(12.w),
                        counterText:
                            'Comments are screened for inappropriate language',
                      ),
                    ),
                    SizedBox(height: 24.h),
                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.isLoading.value = true;
                          controller.submitRating({}).then((_) {
                            controller.isLoading.value = false;
                            if (controller.errorMessage.value.isEmpty) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  content: const Text(
                                    'Rating submitted successfully',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              final errorMsg = controller.errorMessage.value;
                              controller.errorMessage.value = '';
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  content: Text(
                                    errorMsg,
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E3A8A),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          'Submit Rating',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        // Loading overlay covering entire screen including app bar
        Obx(() {
          if (!controller.isLoading.value) {
            return const SizedBox.shrink();
          }
          return Container(
            color: Colors.black.withOpacity(0.3),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade700),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildConductSection({
    required String title,
    required String description,
    required int currentRating,
    required Function(int) onRate,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4.h),
          Text(
            description,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final ratingValue = index + 1;
              final isFilled = ratingValue <= currentRating;
              return GestureDetector(
                onTap: () => onRate(ratingValue),
                child: Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Icon(
                    isFilled ? Icons.star : Icons.star_border,
                    color: isFilled ? Colors.amber : Colors.grey.shade400,
                    size: 45.sp,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  String _getRatingLabel(dynamic rating) {
    final ratingValue = rating is int ? rating : (rating as num?)?.toInt() ?? 0;

    if (ratingValue >= 4) {
      return 'Outstanding Performance';
    } else if (ratingValue >= 3) {
      return 'Good Performance';
    } else if (ratingValue >= 2) {
      return 'Average Performance';
    } else if (ratingValue >= 1) {
      return 'Poor Performance';
    } else {
      return 'Not Rated';
    }
  }

  Widget _buildTeamLogo(String logoUrl) {
    if (logoUrl.isEmpty) {
      return Icon(Icons.sports_soccer, size: 30.sp, color: Colors.grey);
    }

    return Image.network(
      logoUrl,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Log error for debugging (without spamming 403 errors)
        if (!error.toString().contains('403')) {
          developer.log('Image load error: $error', name: 'ImageLoader');
        }
        // Return fallback icon silently for 403 and other errors
        return Icon(Icons.sports_soccer, size: 30.sp, color: Colors.grey);
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: SizedBox(
            width: 30.sp,
            height: 30.sp,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[400]!),
            ),
          ),
        );
      },
      cacheHeight: 50,
      cacheWidth: 50,
    );
  }
}
