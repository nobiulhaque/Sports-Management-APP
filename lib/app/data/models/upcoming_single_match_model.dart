class UpcomingSingleMatchModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  UpcomingSingleMatchModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  UpcomingSingleMatchModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? team1Name;
  String? team2Name;
  String? team1Logo;
  String? team2Logo;
  int? team1Goal;
  int? team2Goal;
  int? yellowCards;
  int? redCards;
  int? offsides;
  int? foulsCalled;
  String? matchStage;
  String? matchDate;
  String? matchTime;
  String? location;
  String? division;
  String? mainRefereeId;
  String? assReferee1Id;
  String? assReferee2Id;
  String? fourthOfficialId;
  int? mainRefereeFee;
  int? mainRefereeTravelAllowance;
  String? status;
  String? guidelinesRequirements;
  String? matchStartDate;
  MainRefereeDetails? mainRefereeDetails;
  MainRefereeDetails? assReferee1Details;
  MainRefereeDetails? assReferee2Details;
  MainRefereeDetails? fourthOfficialDetails;
  bool? isAssigned;

  Data({
    this.id,
    this.team1Name,
    this.team2Name,
    this.team1Logo,
    this.team2Logo,
    this.team1Goal,
    this.team2Goal,
    this.yellowCards,
    this.redCards,
    this.offsides,
    this.foulsCalled,
    this.matchStage,
    this.matchDate,
    this.matchTime,
    this.location,
    this.division,
    this.mainRefereeId,
    this.assReferee1Id,
    this.assReferee2Id,
    this.fourthOfficialId,
    this.mainRefereeFee,
    this.mainRefereeTravelAllowance,
    this.status,
    this.guidelinesRequirements,
    this.matchStartDate,
    this.mainRefereeDetails,
    this.assReferee1Details,
    this.assReferee2Details,
    this.fourthOfficialDetails,
    this.isAssigned,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    team1Name = json['team1Name'];
    team2Name = json['team2Name'];
    team1Logo = json['team1Logo'];
    team2Logo = json['team2Logo'];
    team1Goal = json['team1Goal'];
    team2Goal = json['team2Goal'];
    yellowCards = json['yellowCards'];
    redCards = json['redCards'];
    offsides = json['offsides'];
    foulsCalled = json['foulsCalled'];
    matchStage = json['matchStage'];
    matchDate = json['matchDate'];
    matchTime = json['matchTime'];
    location = json['location'];
    division = json['division'];
    mainRefereeId = json['mainRefereeId'];
    assReferee1Id = json['assReferee1Id'];
    assReferee2Id = json['assReferee2Id'];
    fourthOfficialId = json['fourthOfficialId'];
    mainRefereeFee = json['mainRefereeFee'];
    mainRefereeTravelAllowance = json['mainRefereeTravelAllowance'];
    status = json['status'];
    guidelinesRequirements = json['guidelinesRequirements'];
    matchStartDate = json['matchStartDate'];
    mainRefereeDetails = json['mainRefereeDetails'] != null
        ? MainRefereeDetails.fromJson(json['mainRefereeDetails'])
        : null;
    assReferee1Details = json['assReferee1Details'] != null
        ? MainRefereeDetails.fromJson(json['assReferee1Details'])
        : null;
    assReferee2Details = json['assReferee2Details'] != null
        ? MainRefereeDetails.fromJson(json['assReferee2Details'])
        : null;
    fourthOfficialDetails = json['fourthOfficialDetails'] != null
        ? MainRefereeDetails.fromJson(json['fourthOfficialDetails'])
        : null;
    isAssigned = json['isAssigned'];
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
    data['yellowCards'] = yellowCards;
    data['redCards'] = redCards;
    data['offsides'] = offsides;
    data['foulsCalled'] = foulsCalled;
    data['matchStage'] = matchStage;
    data['matchDate'] = matchDate;
    data['matchTime'] = matchTime;
    data['location'] = location;
    data['division'] = division;
    data['mainRefereeId'] = mainRefereeId;
    data['assReferee1Id'] = assReferee1Id;
    data['assReferee2Id'] = assReferee2Id;
    data['fourthOfficialId'] = fourthOfficialId;
    data['mainRefereeFee'] = mainRefereeFee;
    data['mainRefereeTravelAllowance'] = mainRefereeTravelAllowance;
    data['status'] = status;
    data['guidelinesRequirements'] = guidelinesRequirements;
    data['matchStartDate'] = matchStartDate;
    if (mainRefereeDetails != null) {
      data['mainRefereeDetails'] = mainRefereeDetails!.toJson();
    }
    if (assReferee1Details != null) {
      data['assReferee1Details'] = assReferee1Details!.toJson();
    }
    if (assReferee2Details != null) {
      data['assReferee2Details'] = assReferee2Details!.toJson();
    }
    if (fourthOfficialDetails != null) {
      data['fourthOfficialDetails'] = fourthOfficialDetails!.toJson();
    }
    data['isAssigned'] = isAssigned;
    return data;
  }
}

class MainRefereeDetails {
  String? id;
  String? status;
  Referee? referee;

  MainRefereeDetails({this.id, this.status, this.referee});

  MainRefereeDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    referee = json['referee'] != null
        ? Referee.fromJson(json['referee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
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
