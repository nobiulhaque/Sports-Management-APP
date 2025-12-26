import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../RefereesSide/controllers/referees_side_controller.dart';
import '../../RefereesSide/views/referee_profile_details_view.dart';
import '../../RefereesSide/views/referees_side_view.dart';
import '../../add_match/modules/views/widgets/referee_screen_widgets.dart';
import '../../upcomingMatch/controllers/upcoming_match_controller.dart';
import '../../upcomingMatch/views/match_detaills_upcoming_match.dart';
import '../../upcomingMatch/views/upcoming_match_view.dart';
import '../../upcomingMatch/views/widgets/match_card_widgets.dart';
import '../../widgets/custom_search_bar.dart';

class LeaugeHomeView extends StatelessWidget {
  const LeaugeHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpcomingMatchController());
    final refereesController = Get.put(RefereesSideController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              CustomSearchBar(hintText: 'Search Jobs'),

              SizedBox(height: 6.h),

              // Title + Action
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upcoming Matches',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UpcomingMatchView(),
                        ),
                      );
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E40AF),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // Horizontal Match Cards
              SizedBox(
                height: 168.h,
                child: Obx(
                  () => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.filteredMatches.length,
                    itemBuilder: (context, index) {
                      final match = controller.filteredMatches[index];
                      return SizedBox(
                        width: 320.w,
                        child: Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: MatchCard(
                            match: match,
                            onViewDetails: () {
                              Get.to(
                                () => MatchDetailsScreenDetaislUpcomming(),
                                arguments: match.id,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              // Referee Section Label
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Referees',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RefereesSideView(),
                        ),
                      );
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E40AF),
                      ),
                    ),
                  ),
                ],
              ),

              // Referee Profile Cards
              Obx(() {
                if (refereesController.isLoading.value) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: const CircularProgressIndicator(),
                    ),
                  );
                }

                final refereesToShow = refereesController.referees
                    .take(3)
                    .toList();

                return Column(
                  children: refereesToShow.map((item) {
                    final referee = item.referee;
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: RefereeProfileCard(
                        name: referee.user.name,
                        rating: referee.averageRating,
                        experience:
                            '${referee.experience ?? 0} Years Experience',
                        imagePath: referee.user.image ?? '',
                        onTap: () {
                          Get.to(
                            () => ProfileDetailsRefereeSide(),
                            arguments: referee.user.id,
                          );
                        },
                        buttonText: 'View Profile',

                      ),
                    );
                  }).toList(),
                );
              }),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
