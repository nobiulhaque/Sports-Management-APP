import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/leauge_officials/widgets/custom_app_bar.dart';
import '../controllers/referee_complete_matches_controller.dart';

class RefereeCompletedMatchViewDetails
    extends GetView<RefereeCompleteMatchesController> {
  const RefereeCompletedMatchViewDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarLeauge(title: 'Complete Match'),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final match = controller.matchDetails.value;

        if (match == null) {
          return const Center(child: Text('No match details available'));
        }

        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Match Card
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFEBF4FF), Color(0xFFF3E8FF)],
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      // Teams and Score
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Team 1
                          Column(
                            children: [
                              Container(
                                width: 48.w,
                                height: 48.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24.r),
                                ),
                                child: Center(
                                  child:
                                      match.team1Logo != null &&
                                          match.team1Logo!.isNotEmpty
                                      ? Image.network(
                                          match.team1Logo!,
                                          width: 32.w,
                                          height: 32.w,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Icon(
                                                  Icons.sports_soccer,
                                                  color: Colors.grey,
                                                  size: 28.r,
                                                );
                                              },
                                        )
                                      : Icon(
                                          Icons.sports_soccer,
                                          color: Colors.grey,
                                          size: 28.r,
                                        ),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              SizedBox(
                                width: 70.w,
                                child: Text(
                                  match.team1Name ?? 'Team 1',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1A1A1A),
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 16.w),
                          // Score
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF9E9E9E),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              '${match.team1Goal ?? 0} - ${match.team2Goal ?? 0}',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          // Team 2
                          Column(
                            children: [
                              Container(
                                width: 48.w,
                                height: 48.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24.r),
                                ),
                                child: Center(
                                  child:
                                      match.team2Logo != null &&
                                          match.team2Logo!.isNotEmpty
                                      ? Image.network(
                                          match.team2Logo!,
                                          width: 32.w,
                                          height: 32.w,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Icon(
                                                  Icons.sports_soccer,
                                                  color: Colors.grey,
                                                  size: 28.r,
                                                );
                                              },
                                        )
                                      : Icon(
                                          Icons.sports_soccer,
                                          color: Colors.grey,
                                          size: 28.r,
                                        ),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              SizedBox(
                                width: 70.w,
                                child: Text(
                                  match.team2Name ?? 'Team 2',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1A1A1A),
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      // Date and Time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 14.sp,
                            color: const Color(0xFF666666),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            match.matchStartDate ?? 'Oct 12, 2025',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xFF666666),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Icon(
                            Icons.access_time,
                            size: 14.sp,
                            color: const Color(0xFF666666),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            match.matchTime ?? '3:00 PM',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xFF666666),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      // Location
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14.sp,
                            color: const Color(0xFF666666),
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              match.location ??
                                  'National Sports Complex, Field 3',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(0xFF666666),
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                // Match Statistics
                Text(
                  'Match Statistics',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF8E1),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Yellow Cards',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: const Color(0xFF666666),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    '${match.yellowCards ?? 0}',
                                    style: TextStyle(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFFFFA726),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFEBEE),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Red Cards',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: const Color(0xFF666666),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    '${match.redCards ?? 0}',
                                    style: TextStyle(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFFE53935),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE3F2FD),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Fouls Called',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: const Color(0xFF666666),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    '${match.foulsCalled ?? 0}',
                                    style: TextStyle(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF2196F3),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3E5F5),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Offsides',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: const Color(0xFF666666),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    '${match.offsides ?? 0}',
                                    style: TextStyle(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF9C27B0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                // Referees Section
                Row(
                  children: [
                    Icon(
                      Icons.sports_soccer,
                      size: 20.sp,
                      color: const Color(0xFF1A1A1A),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Referees',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                // Main Referee
                if (match.mainRefereeDetails != null)
                  _buildRefereeItem(
                    match.mainRefereeDetails?.referee?.user?.name ?? 'Referee',
                    'Referee',
                    match.mainRefereeDetails?.referee?.user?.image,
                  ),
                // Assistant Referee 1
                if (match.assReferee1Details != null)
                  _buildRefereeItem(
                    match.assReferee1Details?.referee?.user?.name ??
                        'Asst. Referee',
                    'Asst. Referee',
                    match.assReferee1Details?.referee?.user?.image,
                  ),
                // Assistant Referee 2
                if (match.assReferee2Details != null)
                  _buildRefereeItem(
                    match.assReferee2Details?.referee?.user?.name ??
                        'Asst. Referee',
                    'Asst. Referee',
                    match.assReferee2Details?.referee?.user?.image,
                  ),
                // Fourth Official
                if (match.fourthOfficialDetails != null)
                  _buildRefereeItem(
                    match.fourthOfficialDetails?.referee?.user?.name ??
                        '4th Official',
                    '4th Official',
                    match.fourthOfficialDetails?.referee?.user?.image,
                  ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildRefereeItem(String name, String role, String? image) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFE0E0E0), width: 1.w),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundImage: image != null && image.isNotEmpty
                  ? NetworkImage(image)
                  : null,
              child: image == null || image.isEmpty
                  ? Icon(Icons.person, size: 20.sp)
                  : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  Text(
                    role,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 20.sp,
              color: const Color(0xFF999999),
            ),
          ],
        ),
      ),
    );
  }
}
