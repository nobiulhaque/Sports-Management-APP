class LeagueMatchResponse {
  bool? success;
  int? statusCode;
  String? message;
  List<LeagueMatchData>? data;

  LeagueMatchResponse({this.success, this.statusCode, this.message, this.data});

  LeagueMatchResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LeagueMatchData>[];
      json['data'].forEach((v) {
        data!.add(LeagueMatchData.fromJson(v));
      });
    }
  }
}

class LeagueMatchData {
  String? id;
  String? team1Name;
  String? team2Name;
  String? team1Logo;
  String? team2Logo;
  int? team1Goal;
  int? team2Goal;
  String? matchDate;
  String? matchTime;
  bool? isMatchReportUpdated;
  String? status;
  String? mainRefereeId;
  MainRefereeDetails? mainRefereeDetails;
  String? matchStartDate;
  String? matchStatus;

  LeagueMatchData({
    this.id,
    this.team1Name,
    this.team2Name,
    this.team1Logo,
    this.team2Logo,
    this.team1Goal,
    this.team2Goal,
    this.matchDate,
    this.matchTime,
    this.isMatchReportUpdated,
    this.status,
    this.mainRefereeId,
    this.mainRefereeDetails,
    this.matchStartDate,
    this.matchStatus,
  });

  LeagueMatchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    team1Name = json['team1Name'];
    team2Name = json['team2Name'];
    team1Logo = json['team1Logo'];
    team2Logo = json['team2Logo'];
    team1Goal = json['team1Goal'];
    team2Goal = json['team2Goal'];
    matchDate = json['matchDate'];
    matchTime = json['matchTime'];
    isMatchReportUpdated = json['isMatchReportUpdated'];
    status = json['status'];
    mainRefereeId = json['mainRefereeId'];
    mainRefereeDetails = json['mainRefereeDetails'] != null
        ? MainRefereeDetails.fromJson(json['mainRefereeDetails'])
        : null;
    matchStartDate = json['matchStartDate'];
    matchStatus = json['matchStatus'];
  }
}

class MainRefereeDetails {
  String? id;
  Referee? referee;

  MainRefereeDetails({this.id, this.referee});

  MainRefereeDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referee = json['referee'] != null
        ? Referee.fromJson(json['referee'])
        : null;
  }
}

class Referee {
  String? id;
  User? user;

  Referee({this.id, this.user});

  Referee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class User {
  String? id;
  String? name;
  String? image;
  String? role;

  User({this.id, this.name, this.image, this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    role = json['role'];
  }
}
