class RateTeamConductDetail {
  final String? id;
  final String? team1Name;
  final String? team2Name;
  final int? team1Goal;
  final int? team2Goal;
  final String? team1Logo;
  final String? team2Logo;
  final String? matchDate;
  final String? matchTime;
  final String? matchStartDate;
  final int? overallMatchRating;
  final MainRefereeDetails? mainRefereeDetails;

  RateTeamConductDetail({
    this.id,
    this.team1Name,
    this.team2Name,
    this.team1Goal,
    this.team2Goal,
    this.team1Logo,
    this.team2Logo,
    this.matchDate,
    this.matchTime,
    this.matchStartDate,
    this.overallMatchRating,
    this.mainRefereeDetails,
  });

  factory RateTeamConductDetail.fromJson(Map<String, dynamic> json) {
    return RateTeamConductDetail(
      id: json['_id'] as String?,
      team1Name: json['team1Name'] as String?,
      team2Name: json['team2Name'] as String?,
      team1Goal: json['team1Goal'] as int?,
      team2Goal: json['team2Goal'] as int?,
      team1Logo: json['team1Logo'] as String?,
      team2Logo: json['team2Logo'] as String?,
      matchDate: json['matchDate'] as String?,
      matchTime: json['matchTime'] as String?,
      matchStartDate: json['matchStartDate'] as String?,
      overallMatchRating: json['overallMatchRating'] as int?,
      mainRefereeDetails: json['mainRefereeDetails'] != null
          ? MainRefereeDetails.fromJson(json['mainRefereeDetails'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'team1Name': team1Name,
      'team2Name': team2Name,
      'team1Goal': team1Goal,
      'team2Goal': team2Goal,
      'team1Logo': team1Logo,
      'team2Logo': team2Logo,
      'matchDate': matchDate,
      'matchTime': matchTime,
      'matchStartDate': matchStartDate,
      'overallMatchRating': overallMatchRating,
      'mainRefereeDetails': mainRefereeDetails?.toJson(),
    };
  }
}

class MainRefereeDetails {
  final Referee? referee;

  MainRefereeDetails({this.referee});

  factory MainRefereeDetails.fromJson(Map<String, dynamic> json) {
    return MainRefereeDetails(
      referee: json['referee'] != null
          ? Referee.fromJson(json['referee'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'referee': referee?.toJson()};
  }
}

class Referee {
  final User? user;

  Referee({this.user});

  factory Referee.fromJson(Map<String, dynamic> json) {
    return Referee(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'user': user?.toJson()};
  }
}

class User {
  final String? id;
  final String? name;
  final String? image;

  User({this.id, this.name, this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'name': name, 'image': image};
  }
}
