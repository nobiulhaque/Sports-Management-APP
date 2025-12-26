import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../widgets/app_bar_widgets.dart';
import '../../../../widgets/custom_svg_icon.dart';
import '../../../../widgets/league_card.dart';
import '../controllers/leagues_regular_user_controller.dart';

class LeaguesRegularUserView extends GetView<LeaguesRegularUserController> {
  const LeaguesRegularUserView({super.key});

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
                Container(
                  height: 52.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(30),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search jobs',
                            hintStyle: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF9CA3AF),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 16.h,
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        width: 40.w,
                        height: 40.h,
                        margin: EdgeInsets.only(right: 8.w),
                        decoration: const BoxDecoration(
                          color: Color(0xFF1E40AF),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: CustomSvgIcon(
                            assetName: 'assets/icons/search-lg.svg',
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                // League text and See All
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Leauge',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle "See All" tap
                      },
                      child: Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF1E40AF),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Saved Leagues List
                controller.savedLeagues.isEmpty
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
                          controller.savedLeagues.length,
                          (index) {
                            final league = controller.savedLeagues[index];
                            league.isSaved = false;
                            return Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: LeagueCard(
                                league: league,
                                onRequest: () {},
                                onToggleSave: (leagueId) {
                                  // Handle toggle save
                                },
                              ),
                            );
                          },
                        ),
                      ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
