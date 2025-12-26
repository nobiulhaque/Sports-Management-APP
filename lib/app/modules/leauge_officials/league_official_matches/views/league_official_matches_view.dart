import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kaldmv/app/modules/leauge_officials/league_official_matches/views/widgets/matches_tab_bar.dart';
import 'package:kaldmv/app/modules/leauge_officials/leaugeDrawer/rate_referee/views/widgets/completed_match_card.dart';
import 'package:kaldmv/app/modules/leauge_officials/upcomingMatch/views/match_detaills_upcoming_match.dart';
import 'package:kaldmv/app/modules/leauge_officials/widgets/custom_search_bar.dart';
import 'package:kaldmv/app/routes/app_pages.dart';
import 'package:kaldmv/core/constants/app_colors.dart';

import '../../widgets/custom_app_bar.dart';
import '../controllers/league_official_matches_controller.dart';

class LeagueOfficialMatchesView
    extends GetView<LeagueOfficialMatchesController> {
  const LeagueOfficialMatchesView({super.key});

  String _formatDate(String? dateStr, String? status) {
    if (dateStr == null) return '';
    try {
      final date = DateTime.parse(dateStr);
      final formatted = DateFormat('EEEE, d MMM').format(date);
      // Add status
      String statusText = '';
      if (status == 'COMPLETED') {
        statusText = ' (Completed)';
      } else if (status == 'SCHEDULED') {
        statusText = ' (Upcoming)';
      } else if (status != null) {
        statusText = ' ($status)';
      }
      return '$formatted$statusText';
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // appBar: CustomAppBarLeauge(title: 'Matches'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: CustomSearchBar(hintText: 'Search'),
            ),
            SizedBox(height: 24.h),
            MatchesTabBar(),
            SizedBox(height: 4.h),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.matchList.isEmpty) {
                return Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Text("No matches found"),
                );
              }

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.matchList.length,
                  itemBuilder: (context, index) {
                    final leagueMatch = controller.matchList[index];
                    final isCompleted = leagueMatch.status == 'COMPLETED';

                    final t1Score = isCompleted
                        ? (leagueMatch.team1Goal ?? 0)
                        : 0;
                    final t2Score = isCompleted
                        ? (leagueMatch.team2Goal ?? 0)
                        : 0;

                    final matchModel = MatchModel(
                      team1Logo: leagueMatch.team1Logo ?? '',
                      team1Name: leagueMatch.team1Name ?? 'Team 1',
                      t1score: t1Score,
                      team2Logo: leagueMatch.team2Logo ?? '',
                      team2Name: leagueMatch.team2Name ?? 'Team 2',
                      t2score: t2Score,
                      date: _formatDate(
                        leagueMatch.matchDate,
                        leagueMatch.status,
                      ),
                      refereeImage:
                          leagueMatch
                              .mainRefereeDetails
                              ?.referee
                              ?.user
                              ?.image ??
                          '',
                      rate: 0.0,
                      onTap: () {},
                    );

                    final refereeName =
                        leagueMatch.mainRefereeDetails?.referee?.user?.name ??
                        'Official';

                    return Padding(
                      padding: EdgeInsets.only(top: index == 0 ? 12.h : 0),
                      child: CompletedMatchCard(
                        match: matchModel,
                        updateButton: isCompleted ? 'Update' : null,
                        onTapUpdate: () {
                          Get.toNamed(
                            Routes.UPDATE_MATCHES,
                            arguments: {
                              'matchId': leagueMatch.id,
                              'matchData': leagueMatch,
                            },
                          );
                        },
                        onTapViewDetails: () {
                          if (!isCompleted) {
                            Get.to(
                              () => MatchDetailsScreenDetaislUpcomming(),
                              arguments: leagueMatch.id,
                            );
                          } else {
                            Get.toNamed(
                              Routes.VIEW_DETAILS_MATCH,
                              arguments: {
                                'refereeId': leagueMatch.mainRefereeDetails?.referee?.id,
                                'matchId': leagueMatch.id,
                              },
                            );
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(4.r),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(2.r),
                              topRight: Radius.circular(2.r),
                              bottomRight: Radius.circular(10.r),
                            ),
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: '$refereeName/ ',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primary,
                                      ),
                                ),
                                TextSpan(
                                  text: 'Match Official',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.sp,
                                        color: AppColors.primarySubtle,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16.h);
                  },
                ),
              );
            }),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
