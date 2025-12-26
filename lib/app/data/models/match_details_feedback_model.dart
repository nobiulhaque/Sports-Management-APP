class MatchDetailsFeedbackModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  MatchDetailsFeedbackModel({this.success, this.statusCode, this.message, this.data});

  MatchDetailsFeedbackModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Match? match;
  String? matchStartDate;
  Referee? referee;
  num? roundedAverage;
  List<AllFeedback>? allFeedback;

  Data(
      {this.match,
      this.matchStartDate,
      this.referee,
      this.roundedAverage,
      this.allFeedback});

  Data.fromJson(Map<String, dynamic> json) {
    match = json['match'] != null ? Match.fromJson(json['match']) : null;
    matchStartDate = json['matchStartDate'];
    referee =
        json['referee'] != null ? Referee.fromJson(json['referee']) : null;
    roundedAverage = json['roundedAverage'];
    if (json['allFeedback'] != null) {
      allFeedback = <AllFeedback>[];
      json['allFeedback'].forEach((v) {
        allFeedback!.add(AllFeedback.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (match != null) {
      data['match'] = match!.toJson();
    }
    data['matchStartDate'] = matchStartDate;
    if (referee != null) {
      data['referee'] = referee!.toJson();
    }
    data['roundedAverage'] = roundedAverage;
    if (allFeedback != null) {
      data['allFeedback'] = allFeedback!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Match {
  String? id;
  String? team1Name;
  String? team2Name;
  String? team1Logo;
  String? team2Logo;
  int? team1Goal;
  int? team2Goal;
  String? matchDate;
  String? matchTime;
  String? location;
  int? yellowCards;
  int? redCards;
  int? offsides;
  int? foulsCalled;

  Match(
      {this.id,
      this.team1Name,
      this.team2Name,
      this.team1Logo,
      this.team2Logo,
      this.team1Goal,
      this.team2Goal,
      this.matchDate,
      this.matchTime,
      this.location,
      this.yellowCards,
      this.redCards,
      this.offsides,
      this.foulsCalled});

  Match.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    team1Name = json['team1Name'];
    team2Name = json['team2Name'];
    team1Logo = json['team1Logo'];
    team2Logo = json['team2Logo'];
    team1Goal = json['team1Goal'];
    team2Goal = json['team2Goal'];
    matchDate = json['matchDate'];
    matchTime = json['matchTime'];
    location = json['location'];
    yellowCards = json['yellowCards'];
    redCards = json['redCards'];
    offsides = json['offsides'];
    foulsCalled = json['foulsCalled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['team1Name'] = team1Name;
    data['team2Name'] = team2Name;
    data['team1Logo'] = team1Logo;
    data['team2Logo'] = team2Logo;
    data['team1Goal'] = team1Goal;
    data['team2Goal'] = team2Goal;
    data['matchDate'] = matchDate;
    data['matchTime'] = matchTime;
    data['location'] = location;
    data['yellowCards'] = yellowCards;
    data['redCards'] = redCards;
    data['offsides'] = offsides;
    data['foulsCalled'] = foulsCalled;
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

class AllFeedback {
  String? id;
  int? fairness;
  int? control;
  int? positioning;
  int? communication;
  int? overallRating;
  String? comment;
  User? reviewer;

  AllFeedback(
      {this.id,
      this.fairness,
      this.control,
      this.positioning,
      this.communication,
      this.overallRating,
      this.comment,
      this.reviewer});

  AllFeedback.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fairness = json['fairness'];
    control = json['control'];
    positioning = json['positioning'];
    communication = json['communication'];
    overallRating = json['overallRating'];
    comment = json['comment'];
    reviewer = json['reviewer'] != null ? User.fromJson(json['reviewer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fairness'] = fairness;
    data['control'] = control;
    data['positioning'] = positioning;
    data['communication'] = communication;
    data['overallRating'] = overallRating;
    data['comment'] = comment;
    if (reviewer != null) {
      data['reviewer'] = reviewer!.toJson();
    }
    return data;
  }
}
