import 'package:get/get.dart';
import 'package:kaldmv/core/services/api_service.dart';
import 'package:kaldmv/app/modules/referee/rating/rating_home/models/match_performance.dart';
import '../../../../../widgets/performance_progress_widget.dart';
import '../models/user_profile.dart';

class RatingController extends GetxController {
  late final ApiService apiService;

  late Rx<UserProfile?> profile = Rx<UserProfile?>(null);
  late RxList<PerformanceData> performanceData = RxList<PerformanceData>([]);
  late RxList<MatchPerformance> matchPerformances = RxList<MatchPerformance>(
    [],
  );

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    apiService = ApiService();
    fetchRatingPageData();
  }

  Future<void> fetchRatingPageData() async {
    try {
      isLoading(true);
      errorMessage('');

      final response = await apiService.get('/referee/referee-rating-page');

      if (response != null && response['success'] == true) {
        final data = response['data'];

        // Map referee info to profile
        if (data['referee'] != null) {
          final referee = data['referee'];
          profile.value = UserProfile(
            avatarUrl: referee['image'] ?? '',
            name: referee['name'] ?? 'Referee',
            title: 'Professional Referee',
            location: referee['location'] ?? 'Unknown',
            experienceYears: referee['experience'] ?? 0,
            averageRating: (referee['roundedAverage'] ?? 0).toDouble(),
            progressionValue: ((referee['roundedAverage'] ?? 0) / 5).toDouble(),
            thisSeasonMatches: referee['totalMatches'] ?? 0,
            yellowCards: 0,
            redCards: 0,
          );
        }

        // Map monthly performance data
        if (data['performanceData'] != null &&
            data['performanceData']['monthlyRatings'] != null) {
          final monthlyRatings =
              data['performanceData']['monthlyRatings'] as List;
          performanceData.value = monthlyRatings
              .map(
                (month) => PerformanceData(
                  month: month['monthName'] ?? 'Jan',
                  rating: (month['averageRating'] ?? 0.0).toDouble(),
                ),
              )
              .toList();
        }

        // Map matches to MatchPerformance
        if (data['matches'] != null) {
          final matches = data['matches'] as List;
          matchPerformances.value = matches
              .map(
                (match) => MatchPerformance(
                  team1Name: match['team1Name'] ?? 'Team 1',
                  team2Name: match['team2Name'] ?? 'Team 2',
                  team1Logo: match['team1Logo'] ?? '',
                  team2Logo: match['team2Logo'] ?? '',
                  team1Goal: match['team1Goal'],
                  team2Goal: match['team2Goal'],
                  matchDate: match['matchDate'] ?? '',
                  matchTime: match['matchTime'] ?? '',
                  status: match['status'] ?? 'Pending',
                  refereeImage: match['refereeImage'],
                  refereeOverallRating: match['refereeOverallRating']
                      ?.toDouble(),
                  yellowCards: match['yellowCards'] ?? 0,
                  redCards: match['redCards'] ?? 0,
                  foulsCall: match['foulsCall'] ?? 0,
                  offsides: match['offsides'] ?? 0,
                  location: match['location'] ?? 'Unknown Location',
                ),
              )
              .toList();
        }

        errorMessage('');
      } else {
        errorMessage('Failed to load rating data');
      }
    } catch (e) {
      errorMessage('Error: ${e.toString()}');
      print('Error fetching rating page data: $e');
    } finally {
      isLoading(false);
    }
  }
}
