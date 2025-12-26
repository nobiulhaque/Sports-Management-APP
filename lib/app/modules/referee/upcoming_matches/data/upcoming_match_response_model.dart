class UpcomingMatchResponse {
  bool? success;
  int? statusCode;
  String? message;
  List<MatchData>? data;

  UpcomingMatchResponse({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  UpcomingMatchResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MatchData>[];
      json['data'].forEach((v) {
        data!.add(MatchData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MatchData {
  String? id;
  String? team1Name;
  String? team2Name;
  String? team1Logo;
  String? team2Logo;
  String? matchDate;
  String? matchTime;
  bool? isMatchReportUpdated;
  String? status;
  String? mainRefereeId;
  dynamic mainReferee;
  MainRefereeDetails? mainRefereeDetails;
  String? matchStartDate;
  int? daysUntilMatch;
  String? matchStatus;

  MatchData({
    this.id,
    this.team1Name,
    this.team2Name,
    this.team1Logo,
    this.team2Logo,
    this.matchDate,
    this.matchTime,
    this.isMatchReportUpdated,
    this.status,
    this.mainRefereeId,
    this.mainReferee,
    this.mainRefereeDetails,
    this.matchStartDate,
    this.daysUntilMatch,
    this.matchStatus,
  });

  MatchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    team1Name = json['team1Name'];
    team2Name = json['team2Name'];
    team1Logo = json['team1Logo'];
    team2Logo = json['team2Logo'];
    matchDate = json['matchDate'];
    matchTime = json['matchTime'];
    isMatchReportUpdated = json['isMatchReportUpdated'];
    status = json['status'];
    mainRefereeId = json['mainRefereeId'];
    mainReferee = json['mainReferee'];
    mainRefereeDetails = json['mainRefereeDetails'] != null
        ? MainRefereeDetails.fromJson(json['mainRefereeDetails'])
        : null;
    matchStartDate = json['matchStartDate'];
    daysUntilMatch = json['daysUntilMatch'];
    matchStatus = json['matchStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['team1Name'] = team1Name;
    data['team2Name'] = team2Name;
    data['team1Logo'] = team1Logo;
    data['team2Logo'] = team2Logo;
    data['matchDate'] = matchDate;
    data['matchTime'] = matchTime;
    data['isMatchReportUpdated'] = isMatchReportUpdated;
    data['status'] = status;
    data['mainRefereeId'] = mainRefereeId;
    data['mainReferee'] = mainReferee;
    if (mainRefereeDetails != null) {
      data['mainRefereeDetails'] = mainRefereeDetails!.toJson();
    }
    data['matchStartDate'] = matchStartDate;
    data['daysUntilMatch'] = daysUntilMatch;
    data['matchStatus'] = matchStatus;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (referee != null) {
      data['referee'] = referee!.toJson();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['role'] = role;
    return data;
  }
}
