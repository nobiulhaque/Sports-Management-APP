import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/leauge_officials/league_official_matches/views/widgets/matches_tab_bar.dart';
import 'package:kaldmv/app/modules/leauge_officials/widgets/custom_search_bar.dart';
import 'package:kaldmv/app/routes/app_pages.dart';
import 'package:kaldmv/app/widgets/match_card.dart';
import '../controllers/referee_matches_controller.dart';

class RefereeMatchesView extends GetView<RefereeMatchesController> {
  const RefereeMatchesView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RefereeMatchesController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: CustomSearchBar(hintText: 'Search'),
            ),
            SizedBox(height: 24.h),
            MatchesTabBar(),
            SizedBox(height: 4.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(40.h),
                      child: const CircularProgressIndicator(),
                    ),
                  );
                }

                if (controller.errorMessage.value.isNotEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Text(
                        controller.errorMessage.value,
                        style: TextStyle(fontSize: 14.sp, color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                if (controller.matches.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(40.h),
                      child: Text(
                        'No matches available',
                        style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.matches.length,
                  itemBuilder: (context, index) {
                    final refereeMatch = controller.matches[index];

                    // Create a match object compatible with MatchCard
                    final matchData = _MatchCardData(
                      team1Logo: refereeMatch.team1Logo,
                      team1Name: refereeMatch.team1Name,
                      team2Logo: refereeMatch.team2Logo,
                      team2Name: refereeMatch.team2Name,
                      date: refereeMatch.matchStartDate,
                      refereeImage:
                          refereeMatch.mainRefereeDetails.referee.user.image,
                      refereeName:
                          refereeMatch.mainRefereeDetails.referee.user.name,
                      refereeRole:
                          refereeMatch.mainRefereeDetails.referee.user.role,
                      status: refereeMatch.status, // COMPLETED or SCHEDULED
                      t1score: refereeMatch.team1Goal ?? 0,
                      t2score: refereeMatch.team2Goal ?? 0,
                    );

                    return Padding(
                      padding: EdgeInsets.only(
                        top: index == 0 ? 12.h : 0,
                        bottom: 16.h,
                      ),
                      child: MatchCard(
                        match: matchData,
                        onViewDetails: () {
                          // Navigate based on match status
                          if (refereeMatch.status.toLowerCase() ==
                              'completed') {
                            // Navigate to completed match view
                            Get.toNamed(
                              Routes.REFEREE_COMPLETE_MATCHES,
                              arguments: refereeMatch.id,
                            );
                          } else {
                            // Navigate to upcoming/match details view
                            Get.toNamed(
                              Routes.MATCH_DETAILS,
                              arguments: refereeMatch.id,
                            );
                          }
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox.shrink();
                  },
                );
              }),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}

// Helper class to match MatchCard data structure
class _MatchCardData {
  final String team1Logo;
  final String team1Name;
  final String team2Logo;
  final String team2Name;
  final String date;
  final String refereeImage;
  final String refereeName;
  final String refereeRole;
  final String status; // COMPLETED or SCHEDULED
  final int t1score;
  final int t2score;

  _MatchCardData({
    required this.team1Logo,
    required this.team1Name,
    required this.team2Logo,
    required this.team2Name,
    required this.date,
    required this.refereeImage,
    required this.refereeName,
    required this.refereeRole,
    required this.status,
    required this.t1score,
    required this.t2score,
  });
}
