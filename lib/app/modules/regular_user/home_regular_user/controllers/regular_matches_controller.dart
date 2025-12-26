import 'package:get/get.dart';
import '../../../../../core/services/api_service.dart';

class RegularMatchesController extends GetxController {
  final ApiService _apiService = ApiService();

  final isLoading = false.obs;
  final matches = <MatchData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllMatches();
  }

  Future<void> fetchAllMatches() async {
    try {
      isLoading.value = true;

      final response = await _apiService.get('/users/all-matches');

      if (response != null && response['success'] == true) {
        final List<dynamic> data = response['data'] ?? [];
        matches.value = data.map((e) => MatchData.fromJson(e)).toList();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load matches: ${e.toString()}');
      print('Error fetching matches: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

class MatchData {
  final String id;
  final String team1Name;
  final String team2Name;
  final String team1Logo;
  final String team2Logo;
  final int? team1Goal;
  final int? team2Goal;
  final String matchDate;
  final String status;
  final bool isMatchReportUpdated;
  final String mainRefereeId;
  final String? refereeName;
  final String? refereeImage;
  final String? refereeRole;
  final String matchStartDate;
  final String matchStatus;

  MatchData({
    required this.id,
    required this.team1Name,
    required this.team2Name,
    required this.team1Logo,
    required this.team2Logo,
    this.team1Goal,
    this.team2Goal,
    required this.matchDate,
    required this.status,
    required this.isMatchReportUpdated,
    required this.mainRefereeId,
    this.refereeName,
    this.refereeImage,
    this.refereeRole,
    required this.matchStartDate,
    required this.matchStatus,
  });

  factory MatchData.fromJson(Map<String, dynamic> json) {
    try {
      final mainRefereeDetails =
          json['mainRefereeDetails'] as Map<String, dynamic>?;
      final referee = mainRefereeDetails?['referee'] as Map<String, dynamic>?;
      final user = referee?['user'] as Map<String, dynamic>?;

      return MatchData(
        id: (json['id'] as String?) ?? '',
        team1Name: (json['team1Name'] as String?) ?? 'Team 1',
        team2Name: (json['team2Name'] as String?) ?? 'Team 2',
        team1Logo: (json['team1Logo'] as String?) ?? '',
        team2Logo: (json['team2Logo'] as String?) ?? '',
        team1Goal: json['team1Goal'] as int?,
        team2Goal: json['team2Goal'] as int?,
        matchDate: (json['matchDate'] as String?) ?? '',
        status: (json['status'] as String?) ?? 'SCHEDULED',
        isMatchReportUpdated: (json['isMatchReportUpdated'] as bool?) ?? false,
        mainRefereeId: (json['mainRefereeId'] as String?) ?? '',
        refereeName: user?['name'] as String?,
        refereeImage: user?['image'] as String?,
        refereeRole: user?['role'] as String?,
        matchStartDate: (json['matchStartDate'] as String?) ?? '',
        matchStatus: (json['matchStatus'] as String?) ?? '',
      );
    } catch (e) {
      print('Error parsing match data: $e');
      print('JSON: $json');
      rethrow;
    }
  }

  // Convert to the format expected by MatchCard widget
  dynamic toMatchCardFormat() {
    return _MatchCardData(
      team1Name: team1Name,
      team2Name: team2Name,
      team1Logo: team1Logo,
      team2Logo: team2Logo,
      t1score: team1Goal ?? 0,
      t2score: team2Goal ?? 0,
      date: matchStartDate,
      status: status,
      refereeName: refereeName ?? '',
      refereeImage: refereeImage ?? '',
      refereeRole: refereeRole ?? '',
    );
  }
}

// Helper class to match the MatchCard widget's expected structure
class _MatchCardData {
  final String team1Name;
  final String team2Name;
  final String team1Logo;
  final String team2Logo;
  final int t1score;
  final int t2score;
  final String date;
  final String status;
  final String refereeName;
  final String refereeImage;
  final String refereeRole;

  _MatchCardData({
    required this.team1Name,
    required this.team2Name,
    required this.team1Logo,
    required this.team2Logo,
    required this.t1score,
    required this.t2score,
    required this.date,
    required this.status,
    required this.refereeName,
    required this.refereeImage,
    required this.refereeRole,
  });
}
