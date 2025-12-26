import 'package:get/get.dart';
import 'package:kaldmv/app/modules/leauge_officials/league_official_matches/data/match_model.dart';
import 'package:kaldmv/core/services/api_service.dart';
import 'package:flutter/material.dart';

class LeagueOfficialMatchesController extends GetxController {
  var selectedMatchTab = 0.obs;
  final RxList<String> matchTabs = [
    'All',
    'Update Matches',
    'Upcoming Matches',
    'Complete Matches',
  ].obs;

  var isLoading = false.obs;
  var matchList = <LeagueMatchData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMatches();
  }

  void changeMatchTab(int index) {
    selectedMatchTab.value = index;
    // You might want to filter matches based on tab here if needed
  }

  Future<void> fetchMatches() async {
    try {
      isLoading.value = true;
      final response = await ApiService().get('/matches/league-all-matches');

      if (response != null) {
        final matchesResponse = LeagueMatchResponse.fromJson(response);
        if (matchesResponse.success == true && matchesResponse.data != null) {
          matchList.assignAll(matchesResponse.data!);
        }
      }
    } catch (e) {
      debugPrint("Error fetching matches: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
