// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:kaldmv/core/services/api_service.dart';
import 'package:kaldmv/core/services/api_exception.dart';

import '../../../leauge_officials/upcomingMatch/data/match_model.dart';
import '../data/upcoming_match_response_model.dart';

class UpcomingMatchesController extends GetxController {
  final RxString selectedFilter = 'All'.obs;
  final RxList<MatchModel> allMatches = <MatchModel>[].obs;
  final RxList<MatchModel> filteredMatches = <MatchModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    loadMatches();
  }

  Future<void> loadMatches() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      print('🚀 Starting to fetch upcoming matches...');

      // Call the API to fetch referee upcoming matches
      final response = await _apiService.get(
        '/referee/referee-upcoming-matches',
      );

      print('✅ Raw API Response: $response');

      if (response != null) {
        // Parse the response using UpcomingMatchResponse model
        final UpcomingMatchResponse matchResponse =
            UpcomingMatchResponse.fromJson(response);

        print(
          '✅ Parsed Response - Success: ${matchResponse.success}, Message: ${matchResponse.message}',
        );

        if (matchResponse.success == true &&
            matchResponse.data != null &&
            matchResponse.data!.isNotEmpty) {
          print('📊 Total matches from API: ${matchResponse.data!.length}');

          // Convert MatchData objects to MatchModel objects
          final matches = matchResponse.data!.map((matchData) {
            print(
              '🏆 Processing match: ${matchData.team1Name} vs ${matchData.team2Name}',
            );

            // Convert MatchData to MatchModel
            return MatchModel(
              id: matchData.id ?? '',
              team1Name: matchData.team1Name ?? '',
              team2Name: matchData.team2Name ?? '',
              team1Logo: matchData.team1Logo ?? '',
              team2Logo: matchData.team2Logo ?? '',
              matchDate: matchData.matchDate ?? '',
              matchTime: matchData.matchTime ?? '',
              matchStartDate: matchData.matchStartDate ?? '',
              daysUntilMatch: matchData.daysUntilMatch ?? 0,
              matchStatus: matchData.matchStatus ?? '',
              leagueName: '', // Not provided by API
              leagueLogo: '', // Not provided by API
              refereeImage:
                  matchData.mainRefereeDetails?.referee?.user?.image ?? '',
              refereeName:
                  matchData.mainRefereeDetails?.referee?.user?.name ?? '',
              refereeRole:
                  matchData.mainRefereeDetails?.referee?.user?.role ?? '',
            );
          }).toList();

          // Debug: Print the first match's logos
          if (matches.isNotEmpty) {
            print('🖼️ Match 1 Team Logos:');
            print('   Team 1: ${matches.first.team1Logo}');
            print('   Team 2: ${matches.first.team2Logo}');
          }

          allMatches.value = matches;
          filteredMatches.value = matches;

          print('✅ Matches loaded successfully: ${matches.length} matches');
        } else {
          errorMessage.value = matchResponse.message ?? 'No matches found';
          print('⚠️ No matches in response: ${matchResponse.message}');
        }
      } else {
        errorMessage.value = 'No data received from server';
        print('❌ No response from server');
      }
    } on ApiException catch (e) {
      errorMessage.value = 'API Error: ${e.message}';
      print('❌ ApiException caught: ${e.message} (Status: ${e.statusCode})');
    } catch (e) {
      errorMessage.value = 'Error fetching matches: ${e.toString()}';
      print('❌ Unexpected error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;

    // Apply filtering based on selected filter
    if (filter == 'All') {
      filteredMatches.value = allMatches;
    } else {
      filteredMatches.value = allMatches
          .where(
            (match) => match.matchStatus.toLowerCase() == filter.toLowerCase(),
          )
          .toList();
    }
  }
}
