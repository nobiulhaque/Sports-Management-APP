import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/leauge_officials/update_matches/controllers/update_matches_controller.dart';
import 'package:kaldmv/app/modules/leauge_officials/league_official_matches/data/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaldmv/core/constants/app_colors.dart';

class MatchScoreLine extends StatelessWidget {
  const MatchScoreLine({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UpdateMatchesController>();

    String team1Name = 'Team 1';
    String team2Name = 'Team 2';
    String team1Logo = '';
    String team2Logo = '';

    final args = Get.arguments;
    // Safety check for args being a Map and having matchData
    if (args != null &&
        args is Map &&
        args.containsKey('matchData') &&
        args['matchData'] is LeagueMatchData) {
      final match = args['matchData'] as LeagueMatchData;
      team1Name = match.team1Name ?? 'Team 1';
      team2Name = match.team2Name ?? 'Team 2';
      team1Logo = match.team1Logo ?? '';
      team2Logo = match.team2Logo ?? '';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              if (team1Logo.isNotEmpty)
                CachedNetworkImage(
                  imageUrl: team1Logo,
                  height: 50.h,
                  width: 50.w,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.sports_soccer),
                )
              else
                Icon(Icons.sports_soccer, size: 50.h),
              SizedBox(height: 16.h),
              Text(
                team1Name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.hintTextColor,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            _buildScoreInput(
              context,
              controller.team1Goal,
              (val) => controller.team1Goal.value = int.tryParse(val) ?? 0,
            ),
            Container(
              color: AppColors.hintTextColor,
              height: 1.h,
              width: 12.w,
              margin: EdgeInsets.symmetric(horizontal: 6.w),
            ),
            _buildScoreInput(
              context,
              controller.team2Goal,
              (val) => controller.team2Goal.value = int.tryParse(val) ?? 0,
            ),
          ],
        ),
        Expanded(
          child: Column(
            children: [
              if (team2Logo.isNotEmpty)
                CachedNetworkImage(
                  imageUrl: team2Logo,
                  height: 50.h,
                  width: 50.w,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.sports_soccer),
                )
              else
                Icon(Icons.sports_soccer, size: 50.h),
              SizedBox(height: 16.h),
              Text(
                team2Name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.hintTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScoreInput(
    BuildContext context,
    RxInt scoreObs,
    Function(String) onChanged,
  ) {
    return Container(
      width: 40.w,
      height: 40.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: Color(0xFFA2A6B1)),
      ),
      child: Obx(() {
        // We use key to recreate widget if value changes externally (not by typing) to keep sync,
        // but for TextField it's tricky.
        // Better: just init controller once or use a Key.
        // Simplified:
        var textController =
            TextEditingController(text: scoreObs.value.toString())
              ..selection = TextSelection.fromPosition(
                TextPosition(offset: scoreObs.value.toString().length),
              );

        return TextField(
          controller: textController,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            isDense: true,
          ),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.hintTextColor,
          ),
          onChanged: onChanged,
        );
      }),
    );
  }
}
