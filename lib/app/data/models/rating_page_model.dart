class RatingPageResponse {
  bool? success;
  int? statusCode;
  String? message;
  RatingPageData? data;

  RatingPageResponse({this.success, this.statusCode, this.message, this.data});

  RatingPageResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? RatingPageData.fromJson(json['data']) : null;
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

class RatingPageData {
  RefereeInfo? referee;
  PerformanceDataInfo? performanceData;
  List<MatchInfo>? matches;

  RatingPageData({this.referee, this.performanceData, this.matches});

  RatingPageData.fromJson(Map<String, dynamic> json) {
    referee = json['referee'] != null
        ? RefereeInfo.fromJson(json['referee'])
        : null;
    performanceData = json['performanceData'] != null
        ? PerformanceDataInfo.fromJson(json['performanceData'])
        : null;
    if (json['matches'] != null) {
      matches = <MatchInfo>[];
      json['matches'].forEach((v) {
        matches!.add(MatchInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (referee != null) {
      data['referee'] = referee!.toJson();
    }
    if (performanceData != null) {
      data['performanceData'] = performanceData!.toJson();
    }
    if (matches != null) {
      data['matches'] = matches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RefereeInfo {
  String? id;
  String? refereeId;
  String? name;
  String? image;
  String? role;
  int? roundedAverage;
  int? experience;
  String? location;
  String? availability;
  int? totalMatches;

  RefereeInfo({
    this.id,
    this.refereeId,
    this.name,
    this.image,
    this.role,
    this.roundedAverage,
    this.experience,
    this.location,
    this.availability,
    this.totalMatches,
  });

  RefereeInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refereeId = json['refereeId'];
    name = json['name'];
    image = json['image'];
    role = json['role'];
    roundedAverage = json['roundedAverage'];
    experience = json['experience'];
    location = json['location'];
    availability = json['availability'];
    totalMatches = json['totalMatches'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['refereeId'] = refereeId;
    data['name'] = name;
    data['image'] = image;
    data['role'] = role;
    data['roundedAverage'] = roundedAverage;
    data['experience'] = experience;
    data['location'] = location;
    data['availability'] = availability;
    data['totalMatches'] = totalMatches;
    return data;
  }
}

class PerformanceDataInfo {
  int? currentYear;
  List<MonthlyRatings>? monthlyRatings;
  dynamic overallAverage;
  int? totalReviews;

  PerformanceDataInfo({
    this.currentYear,
    this.monthlyRatings,
    this.overallAverage,
    this.totalReviews,
  });

  PerformanceDataInfo.fromJson(Map<String, dynamic> json) {
    currentYear = json['currentYear'];
    if (json['monthlyRatings'] != null) {
      monthlyRatings = <MonthlyRatings>[];
      json['monthlyRatings'].forEach((v) {
        monthlyRatings!.add(MonthlyRatings.fromJson(v));
      });
    }
    overallAverage = json['overallAverage'];
    totalReviews = json['totalReviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentYear'] = currentYear;
    if (monthlyRatings != null) {
      data['monthlyRatings'] = monthlyRatings!.map((v) => v.toJson()).toList();
    }
    data['overallAverage'] = overallAverage;
    data['totalReviews'] = totalReviews;
    return data;
  }
}

class MonthlyRatings {
  int? month;
  String? monthName;
  dynamic averageRating;
  int? reviewCount;

  MonthlyRatings({
    this.month,
    this.monthName,
    this.averageRating,
    this.reviewCount,
  });

  MonthlyRatings.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    monthName = json['monthName'];
    averageRating = json['averageRating'];
    reviewCount = json['reviewCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['monthName'] = monthName;
    data['averageRating'] = averageRating;
    data['reviewCount'] = reviewCount;
    return data;
  }
}

class MatchInfo {
  String? id;
  String? team1Name;
  String? team2Name;
  String? team1Logo;
  String? team2Logo;
  int? team1Goal;
  int? team2Goal;
  String? matchDate;
  String? matchTime;
  String? status;
  String? refereeImage;
  dynamic refereeOverallRating;

  MatchInfo({
    this.id,
    this.team1Name,
    this.team2Name,
    this.team1Logo,
    this.team2Logo,
    this.team1Goal,
    this.team2Goal,
    this.matchDate,
    this.matchTime,
    this.status,
    this.refereeImage,
    this.refereeOverallRating,
  });

  MatchInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    team1Name = json['team1Name'];
    team2Name = json['team2Name'];
    team1Logo = json['team1Logo'];
    team2Logo = json['team2Logo'];
    team1Goal = json['team1Goal'];
    team2Goal = json['team2Goal'];
    matchDate = json['matchDate'];
    matchTime = json['matchTime'];
    status = json['status'];
    refereeImage = json['refereeImage'];
    refereeOverallRating = json['refereeOverallRating'];
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
    data['status'] = status;
    data['refereeImage'] = refereeImage;
    data['refereeOverallRating'] = refereeOverallRating;
    return data;
  }
}
