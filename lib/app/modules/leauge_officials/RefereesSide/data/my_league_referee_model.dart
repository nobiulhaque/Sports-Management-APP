class MyLeagueRefereeResponse {
  final bool success;
  final int statusCode;
  final String message;
  final List<MyLeagueReferee> data;

  MyLeagueRefereeResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory MyLeagueRefereeResponse.fromJson(Map<String, dynamic> json) {
    return MyLeagueRefereeResponse(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: (json['data'] as List)
          .map((e) => MyLeagueReferee.fromJson(e))
          .toList(),
    );
  }
}

class MyLeagueReferee {
  final String id;
  final String status;
  final Referee referee;

  MyLeagueReferee({
    required this.id,
    required this.status,
    required this.referee,
  });

  factory MyLeagueReferee.fromJson(Map<String, dynamic> json) {
    return MyLeagueReferee(
      id: json['id'],
      status: json['status'],
      referee: Referee.fromJson(json['referee']),
    );
  }
}

class Referee {
  final int? experience;
  final String? location;
  final String badge;
  final double averageRating;
  final int totalMatches;
  final RefereeUser user;

  Referee({
    this.experience,
    this.location,
    required this.badge,
    required this.averageRating,
    required this.totalMatches,
    required this.user,
  });

  factory Referee.fromJson(Map<String, dynamic> json) {
    return Referee(
      experience: json['experience'],
      location: json['location'],
      badge: json['badge'],
      averageRating:
      (json['averageRating'] ?? 0).toDouble(),
      totalMatches: json['totalMatches'] ?? 0,
      user: RefereeUser.fromJson(json['user']),
    );
  }
}

class RefereeUser {
  final String id;
  final String name;
  final String? image;
  final String role;

  RefereeUser({
    required this.id,
    required this.name,
    this.image,
    required this.role,
  });

  factory RefereeUser.fromJson(Map<String, dynamic> json) {
    return RefereeUser(
      id: json['id'] ?? '',
      name: json['name'],
      image: json['image'],
      role: json['role'],
    );
  }
}
