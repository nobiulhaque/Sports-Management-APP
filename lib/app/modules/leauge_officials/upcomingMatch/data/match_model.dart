import 'package:intl/intl.dart';

class MatchModel {
  final String id;
  final String team1Name;
  final String team2Name;
  final String team1Logo;
  final String team2Logo;
  final String matchDate;
  final String matchTime;
  final String matchStartDate;
  final int daysUntilMatch;
  final String matchStatus;

  // Additional fields for UI
  final String leagueName;
  final String leagueLogo;
  final String refereeImage;
  final String refereeName;
  final String refereeRole;

  MatchModel({
    required this.id,
    required this.team1Name,
    required this.team2Name,
    required this.team1Logo,
    required this.team2Logo,
    required this.matchDate,
    required this.matchTime,
    required this.matchStartDate,
    required this.daysUntilMatch,
    required this.matchStatus,
    required this.leagueName,
    required this.leagueLogo,
    required this.refereeImage,
    required this.refereeName,
    required this.refereeRole,
  });

  // Formatted date: "Sunday, 21 Dec"
  String get date {
    try {
      // Try parsing the date
      DateTime? dateTime;

      // Try different date formats
      if (matchDate.isNotEmpty) {
        try {
          dateTime = DateTime.parse(matchDate);
        } catch (_) {
          // Try alternative formats
          try {
            dateTime = DateFormat('yyyy-MM-dd').parse(matchDate);
          } catch (_) {
            try {
              dateTime = DateFormat('dd/MM/yyyy').parse(matchDate);
            } catch (_) {
              return matchDate; // Return original if parsing fails
            }
          }
        }
      }

      if (dateTime != null) {
        // Format as "Sunday, 21 Dec"
        return DateFormat('EEEE, d MMM').format(dateTime);
      }

      return matchDate;
    } catch (e) {
      return matchDate;
    }
  }

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    // Extract referee details from mainRefereeDetails if available
    String refereeName = '';
    String refereeRole = '';
    String refereeImage = '';

    if (json['mainRefereeDetails'] != null) {
      final mainRefereeDetails = json['mainRefereeDetails'];
      if (mainRefereeDetails['referee'] != null) {
        final referee = mainRefereeDetails['referee'];
        if (referee['user'] != null) {
          final user = referee['user'];
          refereeName = user['name'] ?? '';
          refereeRole = user['role'] ?? '';
          refereeImage = user['image'] ?? '';
        }
      }
    }

    // Fallback to direct fields if mainRefereeDetails is not available
    refereeName = refereeName.isEmpty
        ? (json['refereeName'] ?? json['referee_name'] ?? '')
        : refereeName;
    refereeRole = refereeRole.isEmpty
        ? (json['refereeRole'] ?? json['referee_role'] ?? '')
        : refereeRole;
    refereeImage = refereeImage.isEmpty
        ? (json['refereeImage'] ?? json['referee_image'] ?? '')
        : refereeImage;

    return MatchModel(
      id: json['id']?.toString() ?? '',
      team1Name: json['team1Name'] ?? json['team1_name'] ?? '',
      team2Name: json['team2Name'] ?? json['team2_name'] ?? '',
      team1Logo: json['team1Logo'] ?? json['team1_logo'] ?? '',
      team2Logo: json['team2Logo'] ?? json['team2_logo'] ?? '',
      matchDate: json['matchDate'] ?? json['match_date'] ?? '',
      matchTime: json['matchTime'] ?? json['match_time'] ?? '',
      matchStartDate: json['matchStartDate'] ?? json['match_start_date'] ?? '',
      daysUntilMatch: json['daysUntilMatch'] ?? json['days_until_match'] ?? 0,
      matchStatus: json['matchStatus'] ?? json['match_status'] ?? '',
      leagueName: json['leagueName'] ?? json['league_name'] ?? '',
      leagueLogo: json['leagueLogo'] ?? json['league_logo'] ?? '',
      refereeImage: refereeImage,
      refereeName: refereeName,
      refereeRole: refereeRole,
    );
  }
}
