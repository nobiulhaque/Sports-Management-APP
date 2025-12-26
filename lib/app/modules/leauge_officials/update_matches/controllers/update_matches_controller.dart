import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaldmv/app/modules/leauge_officials/league_official_matches/data/match_model.dart';
import 'package:kaldmv/core/services/api_service.dart';

class UpdateMatchesController extends GetxController {
  var yellowCards = 0.obs;
  var redCards = 0.obs;
  var foulsCalled = 0.obs;
  var offsides = 0.obs;

  var team1Goal = 0.obs;
  var team2Goal = 0.obs;

  var isLoading = false.obs;
  late String matchId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map) {
      matchId = args['matchId'] ?? '';
      if (args['matchData'] != null && args['matchData'] is LeagueMatchData) {
        final match = args['matchData'] as LeagueMatchData;
        team1Goal.value = match.team1Goal ?? 0;
        team2Goal.value = match.team2Goal ?? 0;
        // Other stats might not be in the list API, so we might start at 0 or fetch details
        // If API provided stats in get-all, we would map them here.
        // Current JSON response for get-all doesn't show stats, so defaulting to 0 is fine.
      }
    }
  }

  void incrementTeam1Goal() => team1Goal++;
  void decrementTeam1Goal() {
    if (team1Goal.value > 0) team1Goal--;
  }

  void incrementTeam2Goal() => team2Goal++;
  void decrementTeam2Goal() {
    if (team2Goal.value > 0) team2Goal--;
  }

  void incrementYellowCards() => yellowCards++;
  void decrementYellowCards() {
    if (yellowCards.value > 0) yellowCards--;
  }

  void incrementRedCards() => redCards++;
  void decrementRedCards() {
    if (redCards.value > 0) redCards--;
  }

  void incrementFoulsCalled() => foulsCalled++;
  void decrementFoulsCalled() {
    if (foulsCalled.value > 0) foulsCalled--;
  }

  void incrementOffsides() => offsides++;
  void decrementOffsides() {
    if (offsides.value > 0) offsides--;
  }

  Future<void> submitMatchUpdate() async {
    if (matchId.isEmpty) {
      Get.snackbar('Error', 'Match ID is missing');
      return;
    }

    try {
      isLoading.value = true;
      debugPrint("Starting submitMatchUpdate...");

      final body = {
        "team1Goal": team1Goal.value,
        "team2Goal": team2Goal.value,
        "yellowCards": yellowCards.value,
        "redCards": redCards.value,
        "foulsCalled": foulsCalled.value,
        "offsides": offsides.value,
      };

      debugPrint("API Endpoint: /matches/update-match-result/$matchId");
      debugPrint("Request Body: $body");

      final response = await ApiService().patch(
        path: '/matches/update-match-result/$matchId',
        data: body,
      );

      debugPrint("API Response: $response");

      if (response != null && response['success'] == true) {
        debugPrint("Update Successful!");
        Get.back(); // Go back to the list
        Get.snackbar('Success', 'Match result updated successfully');
      } else {
        debugPrint("Update Failed: ${response?['message']}");
        Get.snackbar('Error', response['message'] ?? 'Failed to update match');
      }
    } catch (e) {
      debugPrint("Error updating match: $e");
      Get.snackbar('Error', 'An error occurred while updating the match');
    } finally {
      isLoading.value = false;
      debugPrint("submitMatchUpdate finished.");
    }
  }
}
