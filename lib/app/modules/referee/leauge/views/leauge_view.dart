import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/widgets/app_bar_widgets.dart';
import 'package:kaldmv/app/widgets/league_card.dart';
import 'widgets/league_search_bar.dart';
import 'widgets/league_skeleton_loader.dart';
import '../controllers/leauge_controller.dart';

class LeaugeView extends GetView<LeaugeController> {
  const LeaugeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Leauge'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                // Search Bar
                const LeagueSearchBar(),
                SizedBox(height: 16.h),

                // League text and See All
                Text(
                  'Leauge',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 12.h),

                // Loading state with skeleton
                if (controller.isLoading.value) const LeagueSkeletonLoader(),

                // Error Message
                if (controller.errorMessage.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B6B).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: const Color(0xFFFF6B6B),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        controller.errorMessage.value,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFFF6B6B),
                        ),
                      ),
                    ),
                  ),

                // Saved Leagues List
                if (!controller.isLoading.value)
                  (controller.leagues.isEmpty
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 32.h),
                          child: Center(
                            child: Text(
                              'No leagues found',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF9CA3AF),
                              ),
                            ),
                          ),
                        )
                      : Column(
                          children: List.generate(
                            controller.leagues
                                .where(
                                  (league) =>
                                      league.requestStatus?.toUpperCase() !=
                                      'APPROVED',
                                )
                                .length,
                            (index) {
                              final filteredLeagues = controller.leagues
                                  .where(
                                    (league) =>
                                        league.requestStatus?.toUpperCase() !=
                                        'APPROVED',
                                  )
                                  .toList();
                              final league = filteredLeagues[index];
                              return Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: LeagueCard(
                                  league: league,
                                  onRequest: () {
                                    // Handle request
                                    controller.fetchLeagues();
                                  },
                                  onToggleSave: (leagueId) {
                                    controller.toggleSaveLeague(leagueId);
                                  },
                                ),
                              );
                            },
                          ),
                        )),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
