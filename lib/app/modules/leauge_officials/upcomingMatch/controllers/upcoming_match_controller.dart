import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/match_model.dart';
import 'match_details_model.dart';
import 'match_repository.dart';

class UpcomingMatchController extends GetxController {
  final selectedFilter = 'All'.obs;

  final allMatches = <MatchModel>[].obs;
  final filteredMatches = <MatchModel>[].obs;

  final isLoading = false.obs;

  final MatchRepository _repository = MatchRepository();

  @override
  void onInit() {
    super.onInit();
    loadMatches();
  }

  Future<void> loadMatches() async {
    try {
      isLoading.value = true;

      final matches = await _repository.getUpcomingMatches();
      allMatches.assignAll(matches);
      filteredMatches.assignAll(matches);

      if (matches.isEmpty) {
        Get.snackbar(
          'Info',
          'No upcoming matches available',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load matches: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFEF4444),
        colorText: const Color(0xFFFFFFFF),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;

    if (filter == 'All') {
      filteredMatches.assignAll(allMatches);
    } else if (filter == 'This week') {
      filteredMatches.assignAll(allMatches.where((e) => e.daysUntilMatch <= 7));
    } else if (filter == 'This month') {
      filteredMatches.assignAll(
        allMatches.where((e) => e.daysUntilMatch <= 30),
      );
    }
  }
}

class MatchDetailsController extends GetxController {
  final Rx<MatchDetailsModel?> matchDetails = Rx<MatchDetailsModel?>(null);
  final RxBool isLoading = false.obs;
  final MatchRepository _repository = MatchRepository();

  String? matchId;

  @override
  void onInit() {
    super.onInit();
    // Get matchId from arguments
    matchId = Get.arguments as String?;
    if (matchId != null) {
      loadMatchDetails(matchId!);
    }
  }

  Future<void> loadMatchDetails(String id) async {
    try {
      isLoading.value = true;

      final details = await _repository.getMatchDetails(id);

      if (details != null) {
        matchDetails.value = details;
      } else {
        Get.snackbar(
          'Error',
          'Failed to load match details',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFEF4444),
          colorText: const Color(0xFFFFFFFF),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load match details: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFEF4444),
        colorText: const Color(0xFFFFFFFF),
      );
    } finally {
      isLoading.value = false;
    }
  }

  double get totalCompensation {
    if (matchDetails.value == null) return 0.0;
    return matchDetails.value!.totalCompensation;
  }
}
