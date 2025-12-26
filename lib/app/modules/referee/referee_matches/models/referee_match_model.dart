class RefereeMatch {
  final String id;
  final String team1Name;
  final String team2Name;
  final String team1Logo;
  final String team2Logo;
  final int? team1Goal;
  final int? team2Goal;
  final String matchDate;
  final String matchTime;
  final bool isMatchReportUpdated;
  final String status;
  final String mainRefereeId;
  final MainRefereeDetails mainRefereeDetails;
  final String matchStartDate;
  final String matchStatus;

  RefereeMatch({
    required this.id,
    required this.team1Name,
    required this.team2Name,
    required this.team1Logo,
    required this.team2Logo,
    required this.team1Goal,
    required this.team2Goal,
    required this.matchDate,
    required this.matchTime,
    required this.isMatchReportUpdated,
    required this.status,
    required this.mainRefereeId,
    required this.mainRefereeDetails,
    required this.matchStartDate,
    required this.matchStatus,
  });

  factory RefereeMatch.fromJson(Map<String, dynamic> json) {
    return RefereeMatch(
      id: json['id'] as String? ?? '',
      team1Name: json['team1Name'] as String? ?? '',
      team2Name: json['team2Name'] as String? ?? '',
      team1Logo: json['team1Logo'] as String? ?? '',
      team2Logo: json['team2Logo'] as String? ?? '',
      team1Goal: json['team1Goal'] as int?,
      team2Goal: json['team2Goal'] as int?,
      matchDate: json['matchDate'] as String? ?? '',
      matchTime: json['matchTime'] as String? ?? '',
      isMatchReportUpdated: json['isMatchReportUpdated'] as bool? ?? false,
      status: json['status'] as String? ?? '',
      mainRefereeId: json['mainRefereeId'] as String? ?? '',
      mainRefereeDetails: MainRefereeDetails.fromJson(
        json['mainRefereeDetails'] as Map<String, dynamic>? ?? {},
      ),
      matchStartDate: json['matchStartDate'] as String? ?? '',
      matchStatus: json['matchStatus'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'team1Name': team1Name,
      'team2Name': team2Name,
      'team1Logo': team1Logo,
      'team2Logo': team2Logo,
      'team1Goal': team1Goal,
      'team2Goal': team2Goal,
      'matchDate': matchDate,
      'matchTime': matchTime,
      'isMatchReportUpdated': isMatchReportUpdated,
      'status': status,
      'mainRefereeId': mainRefereeId,
      'mainRefereeDetails': mainRefereeDetails.toJson(),
      'matchStartDate': matchStartDate,
      'matchStatus': matchStatus,
    };
  }
}

class MainRefereeDetails {
  final String id;
  final RefereeInfo referee;

  MainRefereeDetails({required this.id, required this.referee});

  factory MainRefereeDetails.fromJson(Map<String, dynamic> json) {
    return MainRefereeDetails(
      id: json['id'] as String? ?? '',
      referee: RefereeInfo.fromJson(
        json['referee'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'referee': referee.toJson()};
  }
}

class RefereeInfo {
  final String id;
  final UserInfo user;

  RefereeInfo({required this.id, required this.user});

  factory RefereeInfo.fromJson(Map<String, dynamic> json) {
    return RefereeInfo(
      id: json['id'] as String? ?? '',
      user: UserInfo.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'user': user.toJson()};
  }
}

class UserInfo {
  final String id;
  final String name;
  final String image;
  final String role;

  UserInfo({
    required this.id,
    required this.name,
    required this.image,
    required this.role,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      image: json['image'] as String? ?? '',
      role: json['role'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': image, 'role': role};
  }
}
