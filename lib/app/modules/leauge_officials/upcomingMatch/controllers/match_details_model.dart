// match_details_model.dart

class MatchDetailsModel {
  final String id;
  final String team1Name;
  final String team2Name;
  final String team1Logo;
  final String team2Logo;
  final String matchStage;
  final String matchDate;
  final String matchTime;
  final String location;
  final String division;
  final double mainRefereeFee;
  final double mainRefereeTravelAllowance;
  final String guidelinesRequirements;
  final String matchStartDate;
  final List<RefereeDetailModel> refereeTeam;

  MatchDetailsModel({
    required this.id,
    required this.team1Name,
    required this.team2Name,
    required this.team1Logo,
    required this.team2Logo,
    required this.matchStage,
    required this.matchDate,
    required this.matchTime,
    required this.location,
    required this.division,
    required this.mainRefereeFee,
    required this.mainRefereeTravelAllowance,
    required this.guidelinesRequirements,
    required this.matchStartDate,
    required this.refereeTeam,
  });

  factory MatchDetailsModel.fromJson(Map<String, dynamic> json) {
    List<RefereeDetailModel> referees = [];

    // Main Referee
    if (json['mainRefereeDetails'] != null) {
      referees.add(
        RefereeDetailModel.fromJson(json['mainRefereeDetails'], 'Main Referee'),
      );
    }

    // Assistant Referee 1
    if (json['assReferee1Details'] != null) {
      referees.add(
        RefereeDetailModel.fromJson(
          json['assReferee1Details'],
          'Assistant Referee 1',
        ),
      );
    }

    // Assistant Referee 2
    if (json['assReferee2Details'] != null) {
      referees.add(
        RefereeDetailModel.fromJson(
          json['assReferee2Details'],
          'Assistant Referee 2',
        ),
      );
    }

    // Fourth Official
    if (json['fourthOfficialDetails'] != null) {
      referees.add(
        RefereeDetailModel.fromJson(
          json['fourthOfficialDetails'],
          'Fourth Official',
        ),
      );
    }

    return MatchDetailsModel(
      id: json['id'] ?? '',
      team1Name: json['team1Name'] ?? '',
      team2Name: json['team2Name'] ?? '',
      team1Logo: json['team1Logo'] ?? '',
      team2Logo: json['team2Logo'] ?? '',
      matchStage: json['matchStage'] ?? '',
      matchDate: json['matchDate'] ?? '',
      matchTime: json['matchTime'] ?? '',
      location: json['location'] ?? '',
      division: json['division'] ?? '',
      mainRefereeFee: (json['mainRefereeFee'] ?? 0).toDouble(),
      mainRefereeTravelAllowance: (json['mainRefereeTravelAllowance'] ?? 0)
          .toDouble(),
      guidelinesRequirements: json['guidelinesRequirements'] ?? '',
      matchStartDate: json['matchStartDate'] ?? '',
      refereeTeam: referees,
    );
  }

  double get totalCompensation => mainRefereeFee + mainRefereeTravelAllowance;
}

class RefereeDetailModel {
  final String id;
  final String name;
  final String? image;
  final String role;
  final String displayRole;
  final String status;

  RefereeDetailModel({
    required this.id,
    required this.name,
    this.image,
    required this.role,
    required this.displayRole,
    required this.status,
  });

  factory RefereeDetailModel.fromJson(
    Map<String, dynamic> json,
    String displayRole,
  ) {
    final referee = json['referee'];
    final user = referee?['user'];

    return RefereeDetailModel(
      id: user?['id'] ?? '',
      name: user?['name'] ?? '',
      image: user?['image'],
      role: user?['role'] ?? '',
      displayRole: displayRole,
      status: json['status'] ?? '',
    );
  }

  String get initials {
    if (name.isEmpty) return '';
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
  }

  bool get isLead => role == 'MAIN_REFEREE';
}

// Legacy model for backward compatibility
class RefereeModel {
  final String initials;
  final String name;
  final String role;
  final bool isLead;

  RefereeModel({
    required this.initials,
    required this.name,
    required this.role,
    required this.isLead,
  });
}
