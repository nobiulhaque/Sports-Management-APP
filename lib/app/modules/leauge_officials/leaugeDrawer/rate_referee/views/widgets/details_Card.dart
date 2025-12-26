import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaldmv/app/data/models/match_details_feedback_model.dart';
import 'package:kaldmv/core/constants/app_colors.dart';
import 'package:kaldmv/core/utils/utils.dart';
import 'package:intl/intl.dart';

class DetailsCard extends StatelessWidget {
  final Data? matchDetails;
  const DetailsCard({super.key, this.matchDetails});

  @override
  Widget build(BuildContext context) {
    var match = matchDetails?.match;
    
    // Format Date and Time
    String formattedDate = 'Date';
    String formattedTime = 'Time';
    
    // Use matchStartDate from API if available, otherwise parse matchDate
    if (matchDetails?.matchStartDate != null) {
      formattedDate = matchDetails!.matchStartDate!;
    } else if (match?.matchDate != null) {
      try {
        DateTime date = DateTime.parse(match!.matchDate!);
        formattedDate = DateFormat('d MMM, yyyy').format(date);
      } catch (e) {
        formattedDate = match!.matchDate!;
      }
    }

    if (match?.matchTime != null) {
      formattedTime = match!.matchTime!;
    }
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: Color(0xFFDBEAFE),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Team 1
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(5.r),
                      child: match?.team1Logo != null
                          ? CachedNetworkImage(
                              imageUrl: match!.team1Logo!,
                              fit: BoxFit.contain,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.sports_soccer),
                            )
                          : Image.asset(
                              '',
                              fit: BoxFit.contain,
                            ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      match?.team1Name ?? 'Team 1',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),

              // Score
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: Color(0xFF3D455C).withAlpha(122),
                  borderRadius: BorderRadius.circular(2.r),
                ),
                child: Text(
                  '${match?.team1Goal ?? 0} - ${match?.team2Goal ?? 0}',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ),
              SizedBox(width: 16.w),

              // Team 2
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(5.r),
                      child: match?.team2Logo != null
                          ? CachedNetworkImage(
                              imageUrl: match!.team2Logo!,
                              fit: BoxFit.contain,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.sports_soccer),
                            )
                          : Image.asset(
                              '',
                              fit: BoxFit.contain,
                            ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      match?.team2Name ?? 'Team 2',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 14.sp,
                  color: Color(0xFF6B7280),
                ),
                SizedBox(width: 4.w),
                Text(
                  formattedDate,
                  style: TextStyle(fontSize: 12.sp, color: Color(0xFF364153)),
                ),
                SizedBox(width: 4.w),
                Icon(Icons.access_time, size: 14.sp, color: Color(0xFF6B7280)),
                SizedBox(width: 4.w),
                Text(
                  formattedTime,
                  style: TextStyle(fontSize: 12.sp, color: Color(0xFF364153)),
                ),
              ],
            ),
          ),

          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, size: 14.sp, color: Color(0xFF6B7280)),
              Flexible(
                child: Text(
                  match?.location ?? 'Unknown Location',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF364153),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),
          Divider(color: Color(0xFFBEDBFF), thickness: 1.h),
          SizedBox(height: 8.h),
          // Referee Information
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: Color(0xFFDBEAFE), width: 1.w),
            ),
            padding: EdgeInsets.all(12.r),
            child: Column(
              children: [
                Text(
                  'Overall Match Rating',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 40.sp),
                    SizedBox(width: 4.w),
                    Text(
                      '${matchDetails?.roundedAverage ?? 0}/',
                      style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      '5',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'Match Performance', // Dynamic text can be added here based on rating
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.accentGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
