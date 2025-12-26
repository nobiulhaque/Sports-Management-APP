import 'package:get/get.dart';
import '../../../../../core/services/api_service.dart';

class RegularMatchDetailsController extends GetxController {
  final ApiService _apiService = ApiService();

  final isLoading = false.obs;
  final matchDetails = Rxn<MatchDetailsData>();

  Future<void> fetchMatchDetails(String matchId) async {
    try {
      isLoading.value = true;

      final response = await _apiService.get('/users/all-matches/$matchId');

      if (response != null && response['success'] == true) {
        matchDetails.value = MatchDetailsData.fromJson(response['data']);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load match details: ${e.toString()}');
      print('Error fetching match details: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

class MatchDetailsData {
  final String id;
  final String team1Name;
  final String team2Name;
  final String team1Logo;
  final String team2Logo;
  final int? team1Goal;
  final int? team2Goal;
  final String matchDate;
  final String matchTime;
  final String location;
  final String division;
  final String status;
  final String matchStartDate;
  final LeagueOfficialData? leagueOfficial;
  final RefereeDetailsData? mainRefereeDetails;
  final RefereeDetailsData? assReferee1Details;
  final RefereeDetailsData? assReferee2Details;
  final RefereeDetailsData? fourthOfficialDetails;
  final List<dynamic> refereeReviews;

  MatchDetailsData({
    required this.id,
    required this.team1Name,
    required this.team2Name,
    required this.team1Logo,
    required this.team2Logo,
    this.team1Goal,
    this.team2Goal,
    required this.matchDate,
    required this.matchTime,
    required this.location,
    required this.division,
    required this.status,
    required this.matchStartDate,
    this.leagueOfficial,
    this.mainRefereeDetails,
    this.assReferee1Details,
    this.assReferee2Details,
    this.fourthOfficialDetails,
    required this.refereeReviews,
  });

  factory MatchDetailsData.fromJson(Map<String, dynamic> json) {
    return MatchDetailsData(
      id: json['id'] ?? '',
      team1Name: json['team1Name'] ?? '',
      team2Name: json['team2Name'] ?? '',
      team1Logo: json['team1Logo'] ?? '',
      team2Logo: json['team2Logo'] ?? '',
      team1Goal: json['team1Goal'] as int?,
      team2Goal: json['team2Goal'] as int?,
      matchDate: json['matchDate'] ?? '',
      matchTime: json['matchTime'] ?? '',
      location: json['location'] ?? '',
      division: json['division'] ?? '',
      status: json['status'] ?? '',
      matchStartDate: json['matchStartDate'] ?? '',
      leagueOfficial: json['leagueOfficial'] != null
          ? LeagueOfficialData.fromJson(json['leagueOfficial'])
          : null,
      mainRefereeDetails: json['mainRefereeDetails'] != null
          ? RefereeDetailsData.fromJson(json['mainRefereeDetails'])
          : null,
      assReferee1Details: json['assReferee1Details'] != null
          ? RefereeDetailsData.fromJson(json['assReferee1Details'])
          : null,
      assReferee2Details: json['assReferee2Details'] != null
          ? RefereeDetailsData.fromJson(json['assReferee2Details'])
          : null,
      fourthOfficialDetails: json['fourthOfficialDetails'] != null
          ? RefereeDetailsData.fromJson(json['fourthOfficialDetails'])
          : null,
      refereeReviews: json['refereeReviews'] ?? [],
    );
  }
}

class LeagueOfficialData {
  final String id;
  final UserBasicData user;

  LeagueOfficialData({required this.id, required this.user});

  factory LeagueOfficialData.fromJson(Map<String, dynamic> json) {
    return LeagueOfficialData(
      id: json['id'] ?? '',
      user: UserBasicData.fromJson(json['user'] ?? {}),
    );
  }
}

class UserBasicData {
  final String id;
  final String name;

  UserBasicData({required this.id, required this.name});

  factory UserBasicData.fromJson(Map<String, dynamic> json) {
    return UserBasicData(id: json['id'] ?? '', name: json['name'] ?? '');
  }
}

class RefereeDetailsData {
  final String id;
  final String status;
  final RefereeData referee;

  RefereeDetailsData({
    required this.id,
    required this.status,
    required this.referee,
  });

  factory RefereeDetailsData.fromJson(Map<String, dynamic> json) {
    return RefereeDetailsData(
      id: json['id'] ?? '',
      status: json['status'] ?? '',
      referee: RefereeData.fromJson(json['referee'] ?? {}),
    );
  }
}

class RefereeData {
  final String id;
  final RefereeUserData user;

  RefereeData({required this.id, required this.user});

  factory RefereeData.fromJson(Map<String, dynamic> json) {
    return RefereeData(
      id: json['id'] ?? '',
      user: RefereeUserData.fromJson(json['user'] ?? {}),
    );
  }
}

class RefereeUserData {
  final String id;
  final String name;
  final String? image;
  final String role;

  RefereeUserData({
    required this.id,
    required this.name,
    this.image,
    required this.role,
  });

  factory RefereeUserData.fromJson(Map<String, dynamic> json) {
    return RefereeUserData(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] as String?,
      role: json['role'] ?? '',
    );
  }
}
