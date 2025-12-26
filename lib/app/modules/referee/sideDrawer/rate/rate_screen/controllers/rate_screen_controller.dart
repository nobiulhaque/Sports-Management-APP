import 'dart:developer' as developer;
import 'package:get/get.dart';
import 'package:kaldmv/core/services/api_service.dart';
import 'package:kaldmv/core/services/api_exception.dart';
import '../models/rate_team_conduct_detail_model.dart';

class RateScreenController extends GetxController {
  final ApiService _apiService = ApiService();

  final matchDetail = Rx<RateTeamConductDetail?>(null);
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  late String matchId;

  // Rating state management
  final selectedTeam = 'team1'.obs; // team1 or team2

  // Team 1 ratings
  final team1Sportsmanship = 0.obs;
  final team1RespectToOfficials = 0.obs;
  final team1CoachingConduct = 0.obs;
  final team1SpectatorBehavior = 0.obs;
  final team1Comment = ''.obs;

  // Team 2 ratings
  final team2Sportsmanship = 0.obs;
  final team2RespectToOfficials = 0.obs;
  final team2CoachingConduct = 0.obs;
  final team2SpectatorBehavior = 0.obs;
  final team2Comment = ''.obs;

  @override
  void onInit() {
    super.onInit();
    matchId = Get.arguments as String? ?? '';
    if (matchId.isNotEmpty) {
      fetchMatchDetails();
    }
  }

  Future<void> fetchMatchDetails() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      developer.log(
        'Fetching match details for ID: $matchId',
        name: 'RateScreenController',
      );

      final response = await _apiService.get(
        '/referee/rate-team-conduct/$matchId',
      );

      developer.log(
        'Raw API Response: $response',
        name: 'RateScreenController',
      );

      if (response != null) {
        // Handle both cases: if response is the data directly or wrapped in data field
        final matchData =
            response is Map<String, dynamic> && response.containsKey('data')
            ? response['data']
            : response;

        developer.log(
          'Match Data to parse: $matchData',
          name: 'RateScreenController',
        );

        matchDetail.value = RateTeamConductDetail.fromJson(matchData);

        final m = matchDetail.value;
        developer.log(
          'Match details loaded: Team 1: ${m?.team1Name}, Team 2: ${m?.team2Name}, Score: ${m?.team1Goal} - ${m?.team2Goal}',
          name: 'RateScreenController',
        );
      } else {
        errorMessage.value = 'No match data received';
        developer.log(
          'No response from server',
          name: 'RateScreenController',
          level: 900,
        );
      }
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      developer.log(
        'ApiException: ${e.message}',
        name: 'RateScreenController',
        level: 900,
      );
    } catch (e) {
      errorMessage.value = e.toString();
      developer.log('Error: $e', name: 'RateScreenController', level: 900);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitRating(Map<String, dynamic> ratingData) async {
    try {
      isLoading.value = true;
      developer.log(
        'Submitting rating for match: $matchId',
        name: 'RateScreenController',
      );

      final match = matchDetail.value;
      if (match == null) {
        errorMessage.value = 'Match data not loaded';
        return;
      }

      // Prepare both team ratings
      final team1Data = {
        "sportsmanship": team1Sportsmanship.value,
        "respectToOfficials": team1RespectToOfficials.value,
        "coachingConduct": team1CoachingConduct.value,
        "spectatorBehavior": team1SpectatorBehavior.value,
        "comment": team1Comment.value,
        "teamName": match.team1Name,
        "teamLogo": match.team1Logo,
      };

      final team2Data = {
        "sportsmanship": team2Sportsmanship.value,
        "respectToOfficials": team2RespectToOfficials.value,
        "coachingConduct": team2CoachingConduct.value,
        "spectatorBehavior": team2SpectatorBehavior.value,
        "comment": team2Comment.value,
        "teamName": match.team2Name,
        "teamLogo": match.team2Logo,
      };

      developer.log('Team 1 Data: $team1Data', name: 'RateScreenController');
      developer.log('Team 2 Data: $team2Data', name: 'RateScreenController');

      // You can submit both teams or one at a time
      // Here submitting both
      await _apiService.post(
        path: '/reviews/referee-review/$matchId',
        data: team1Data,
      );

      await _apiService.post(
        path: '/reviews/referee-review/$matchId',
        data: team2Data,
      );

      developer.log(
        'Both ratings submitted successfully',
        name: 'RateScreenController',
      );
      Get.back();
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      developer.log(
        'ApiException: ${e.message}',
        name: 'RateScreenController',
        level: 900,
      );
    } catch (e) {
      errorMessage.value = e.toString();
      developer.log('Error: $e', name: 'RateScreenController', level: 900);
    } finally {
      isLoading.value = false;
    }
  }
}
