import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../widgets/league_card.dart';
import '../controllers/regular_league_controller.dart';

class RegularLeagueView extends GetView<RegularLeagueController> {
  const RegularLeagueView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.errorMessage.isNotEmpty) {
        return Center(
          child: Text(
            controller.errorMessage.value,
            style: const TextStyle(color: Colors.red),
          ),
        );
      }

      if (controller.leagues.isEmpty) {
        return const Center(child: Text('No leagues found'));
      }

      return RefreshIndicator(
        onRefresh: () => controller.fetchLeagues(),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          itemCount: controller.leagues.length,
          itemBuilder: (context, index) {
            final league = controller.leagues[index];
            return LeagueCard(
              league: league,
              onRequest: () {}, // Not used for regular users
              onToggleSave: (id) => controller.toggleSaveLeague(id),
              isRegularUser: true,
              showSaveButton: true,
            );
          },
        ),
      );
    });
  }
}
