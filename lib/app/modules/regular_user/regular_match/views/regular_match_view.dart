import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../home_regular_user/controllers/regular_matches_controller.dart';
import '../../../../widgets/match_card.dart';
import '../../match_details/views/regular_match_details_view.dart';

class RegularMatchView extends StatelessWidget {
  const RegularMatchView({super.key});

  @override
  Widget build(BuildContext context) {
    final matchesController = Get.find<RegularMatchesController>();

    return Obx(() {
      if (matchesController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (matchesController.matches.isEmpty) {
        return const Center(child: Text('No matches available'));
      }

      return ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: matchesController.matches.length,
        itemBuilder: (context, index) {
          final matchData = matchesController.matches[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: MatchCard(
              match: matchData.toMatchCardFormat(),
              onViewDetails: () {
                Get.to(
                  () => const RegularMatchDetailsView(),
                  arguments: matchData.id,
                );
              },
            ),
          );
        },
      );
    });
  }
}
