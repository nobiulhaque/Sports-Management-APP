import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../widgets/app_bar_widgets.dart';
import '../controllers/regular_match_details_controller.dart';
import 'regular_referee_match_ratings_view.dart';

class RegularMatchDetailsView extends StatelessWidget {
  const RegularMatchDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegularMatchDetailsController());
    final matchId = Get.arguments as String? ?? '';

    if (matchId.isNotEmpty) {
      controller.fetchMatchDetails(matchId);
    }

    return Scaffold(
      appBar: const CustomAppBar(title: 'Match Details'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final match = controller.matchDetails.value;
        if (match == null) {
          return const Center(child: Text('No match details available'));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Match Info Card
              _buildMatchInfoCard(match),

              SizedBox(height: 24.h),

              // Rate Referees Section
              _buildRateRefereesSection(match),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildMatchInfoCard(MatchDetailsData match) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EAFF),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          // Team Logos and Score
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Team 1
              _buildTeamInfo(logo: match.team1Logo, name: match.team1Name),

              // Score
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF6B7280),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  match.team1Goal != null && match.team2Goal != null
                      ? '${match.team1Goal} - ${match.team2Goal}'
                      : '0 - 0',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),

              // Team 2
              _buildTeamInfo(logo: match.team2Logo, name: match.team2Name),
            ],
          ),

          SizedBox(height: 16.h),

          // Match Details
          _buildMatchDetail(Icons.calendar_today, match.matchStartDate),
          SizedBox(height: 8.h),
          _buildMatchDetail(Icons.access_time, match.matchTime),
          SizedBox(height: 8.h),
          _buildMatchDetail(Icons.location_on, match.location),
        ],
      ),
    );
  }

  Widget _buildTeamInfo({required String logo, required String name}) {
    return Column(
      children: [
        Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: EdgeInsets.all(12.w),
          child: _buildTeamLogo(logo),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: 80.w,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1F2937),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildTeamLogo(String logo) {
    if (logo.isEmpty) {
      return Icon(Icons.sports_soccer, size: 30.w, color: Colors.grey);
    }

    // Check if it's a URL
    if (logo.startsWith('http://') || logo.startsWith('https://')) {
      return CachedNetworkImage(
        imageUrl: logo,
        fit: BoxFit.contain,
        placeholder: (context, url) => SizedBox(
          width: 20.w,
          height: 20.w,
          child: const CircularProgressIndicator(strokeWidth: 2),
        ),
        errorWidget: (context, url, error) {
          print('Error loading team logo: $error');
          return Icon(Icons.sports_soccer, size: 30.w, color: Colors.grey);
        },
      );
    }

    // Fallback for non-URL logos
    return Icon(Icons.sports_soccer, size: 30.w, color: Colors.grey);
  }

  Widget _buildMatchDetail(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 16.w, color: const Color(0xFF6B7280)),
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }

  Widget _buildRateRefereesSection(MatchDetailsData match) {
    final referees = <Map<String, dynamic>>[];

    if (match.mainRefereeDetails != null) {
      referees.add({'data': match.mainRefereeDetails!, 'title': 'Referee'});
    }

    if (match.assReferee1Details != null) {
      referees.add({
        'data': match.assReferee1Details!,
        'title': 'Asst. Referee',
      });
    }

    if (match.assReferee2Details != null) {
      referees.add({
        'data': match.assReferee2Details!,
        'title': 'Asst. Referee',
      });
    }

    if (match.fourthOfficialDetails != null) {
      referees.add({
        'data': match.fourthOfficialDetails!,
        'title': '4th Official',
      });
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EAFF),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.sports,
                  size: 20.w,
                  color: const Color(0xFF1E40AF),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Rate Referees',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1F2937),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          ...referees.map((ref) {
            final refereeDetails = ref['data'] as RefereeDetailsData;
            final title = ref['title'] as String;

            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: _buildRefereeCard(
                name: refereeDetails.referee.user.name,
                role: title,
                image: refereeDetails.referee.user.image,
                userId: refereeDetails.referee.user.id,
                refereeId: refereeDetails.referee.id,
                matchId: match.id,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildRefereeCard({
    required String name,
    required String role,
    String? image,
    required String userId,
    required String refereeId,
    required String matchId,
  }) {
    return InkWell(
      onTap: () => Get.to(
        () => const RegularRefereeMatchRatingsView(),
        arguments: {'matchId': matchId, 'refereeId': refereeId},
      ),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE8EAFF),
              ),
              child: ClipOval(
                child: image != null && image.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.person,
                          size: 24.w,
                          color: const Color(0xFF6B7280),
                        ),
                      )
                    : Icon(
                        Icons.person,
                        size: 24.w,
                        color: const Color(0xFF6B7280),
                      ),
              ),
            ),

            SizedBox(width: 12.w),

            // Name and Role
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    role,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),

            // Arrow
            Icon(
              Icons.chevron_right,
              size: 24.w,
              color: const Color(0xFF9CA3AF),
            ),
          ],
        ),
      ),
    );
  }
}
