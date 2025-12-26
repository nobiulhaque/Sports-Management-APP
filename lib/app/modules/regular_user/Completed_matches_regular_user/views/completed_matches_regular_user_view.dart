import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../widgets/app_bar_widgets.dart';

/// MAIN VIEW WITHOUT CONTROLLER
class CompletedMatchesRegularUserView extends StatelessWidget {
  CompletedMatchesRegularUserView({super.key});

  /// Local filter state using RxString
  final RxString selectedFilter = "All".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Completed Matches'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.h),

                /// Filter Chips
                Obx(
                  () => Row(
                    children: [
                      _buildFilterChip("All"),
                      SizedBox(width: 8.w),
                      _buildFilterChip("This week"),
                      SizedBox(width: 8.w),
                      _buildFilterChip("This month"),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                /// Matches List
                Column(
                  children: matches
                      .map(
                        (match) => Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: CompletedMatchCard(match: match),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Filter Chip widget — NO CONTROLLER REQUIRED
  Widget _buildFilterChip(String label) {
    final isSelected = selectedFilter.value == label;
    return GestureDetector(
      onTap: () => selectedFilter.value = label,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E40AF) : const Color(0xFFD9E1F7),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF1E3A8A),
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////
// MATCH MODEL
//////////////////////////////////////////////////////////////////
class MatchModel {
  final String team1Logo;
  final String team1Name;
  final int t1score;
  final String team2Logo;
  final String team2Name;
  final int t2score;
  final String date;
  final String refereeImage;
  final double rate;
  final VoidCallback onTap;

  MatchModel({
    required this.team1Logo,
    required this.team1Name,
    required this.t1score,
    required this.team2Logo,
    required this.team2Name,
    required this.t2score,
    required this.date,
    required this.refereeImage,
    required this.rate,
    required this.onTap,
  });
}

//////////////////////////////////////////////////////////////////
// DUMMY MATCHES
//////////////////////////////////////////////////////////////////
List<MatchModel> matches = [
  MatchModel(
    team1Logo: 'assets/dynamic/fc_dallas.png',
    team1Name: 'Team A',
    t1score: 2,
    team2Logo: 'assets/dynamic/la_galaxy.png',
    team2Name: 'Team B',
    t2score: 1,
    date: '21 Nov, 2025',
    refereeImage: 'assets/dynamic/referee.png',
    rate: 4.5,
    onTap: () {
      Get.toNamed('/view-details-match');
    },
  ),
  MatchModel(
    team1Logo: 'assets/dynamic/fc_dallas.png',
    team1Name: 'Team C',
    t1score: 0,
    team2Logo: 'assets/dynamic/la_galaxy.png',
    team2Name: 'Team D',
    t2score: 4,
    date: '22 Nov, 2025',
    refereeImage: 'assets/dynamic/referee.png',
    rate: 4.0,
    onTap: () {},
  ),
  MatchModel(
    team1Logo: 'assets/images/barcelona_logo.png',
    team1Name: 'Team C',
    t1score: 2,
    team2Logo: 'assets/images/bayern_logo.png',
    team2Name: 'Team D',
    t2score: 4,
    date: '25 Nov, 2025',
    refereeImage: 'assets/dynamic/referee.png',
    rate: 4.0,
    onTap: () {},
  ),
  MatchModel(
    team1Logo: 'assets/images/barcelona_logo.png',
    team1Name: 'Team C',
    t1score: 9,
    team2Logo: 'assets/images/bayern_logo.png',
    team2Name: 'Team D',
    t2score: 4,
    date: '25 Nov, 2025',
    refereeImage: 'assets/dynamic/referee.png',
    rate: 4.0,
    onTap: () {},
  ),
];

//////////////////////////////////////////////////////////////////
// COMPLETED MATCH CARD (NO CONTROLLER)
//////////////////////////////////////////////////////////////////
class CompletedMatchCard extends StatelessWidget {
  final MatchModel match;

  const CompletedMatchCard({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.transparent, width: 1.w),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Stack(
          children: [
            /// Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/bg/upcoming-matches-bg.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),

            /// Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.5),
                    ],
                  ),
                ),
              ),
            ),

            /// Contentsdasdasd
            Padding(
              padding: EdgeInsets.only(
                left: 10.r,
                right: 100.r,
                top: 16.r,
                bottom: 13.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Teams + Score
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _team(match.team1Logo, match.team1Name),
                      _score(match.t1score, match.t2score),
                      _team(match.team2Logo, match.team2Name),
                    ],
                  ),

                  SizedBox(height: 4.h),

                  /// Date
                  Padding(
                    padding: EdgeInsets.only(left: 10.r),
                    child: Text(
                      match.date,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(height: 8.h),

                  /// View Details Button
                  Padding(
                    padding: EdgeInsets.only(left: 10.r),
                    child: Utils.primaryButton(
                      context: context,
                      title: "View Details",
                      height: 35.h,
                      width: 120.w,
                      fontSize: 14.sp,
                      backgroundColor: AppColors.accentGreen,
                      onTap: match.onTap,
                    ),
                  ),
                ],
              ),
            ),

            /// Referee Image
            Positioned(
              right: 0,
              bottom: 0,
              child: Image.asset(
                match.refereeImage,
                height: 130.h,
                fit: BoxFit.cover,
              ),
            ),

            /// Rating
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                child: Row(
                  children: [
                    Text(
                      '⭐${match.rate}/',
                      style: TextStyle(
                        fontFamily: 'Anton',
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      '5',
                      style: TextStyle(
                        fontFamily: 'Anton',
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Team UI
  Widget _team(String logo, String name) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(5.r),
            child: logo.isEmpty
                ? Icon(Icons.sports_soccer, size: 20.w, color: Colors.grey)
                : (logo.startsWith('http://') || logo.startsWith('https://'))
                ? Image.network(
                    logo,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.sports_soccer,
                      size: 20.w,
                      color: Colors.grey,
                    ),
                  )
                : Icon(Icons.sports_soccer, size: 20.w, color: Colors.grey),
          ),
          SizedBox(height: 4.h),
          Text(
            name,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  /// Score UI
  Widget _score(int a, int b) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        padding: EdgeInsets.all(5.r),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Text(
          '$a - $b',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
