class LeagueRequestList {
  final bool? success;
  final int? statusCode;
  final String? message;
  final List<LeagueRequestData>? data;

  const LeagueRequestList({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory LeagueRequestList.fromJson(Map<String, dynamic> json) {
    return LeagueRequestList(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: (json['data'] as List?)
          ?.map((e) => LeagueRequestData.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'statusCode': statusCode,
    'message': message,
    'data': data?.map((e) => e.toJson()).toList(),
  };
}

class LeagueRequestData {
  final String? id;
  final String? status;
  final String? requestedAt;
  final LeagueOfficial? leagueOfficial;
  final bool? isAssignedAnyLeague;

  const LeagueRequestData({
    this.id,
    this.status,
    this.requestedAt,
    this.leagueOfficial,
    this.isAssignedAnyLeague,
  });

  factory LeagueRequestData.fromJson(Map<String, dynamic> json) {
    return LeagueRequestData(
      id: json['id'],
      status: json['status'],
      requestedAt: json['requestedAt'],
      leagueOfficial: json['leagueOfficial'] != null
          ? LeagueOfficial.fromJson(json['leagueOfficial'])
          : null,
      isAssignedAnyLeague: json['isAssignedAnyLeague'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'status': status,
    'requestedAt': requestedAt,
    'leagueOfficial': leagueOfficial?.toJson(),
    'isAssignedAnyLeague': isAssignedAnyLeague,
  };
}

class LeagueOfficial {
  final String? id;
  final String? organizationId;
  final int? founded;
  final String? country;
  final String? level;
  final String? userId;
  final User? user;

  const LeagueOfficial({
    this.id,
    this.organizationId,
    this.founded,
    this.country,
    this.level,
    this.userId,
    this.user,
  });

  factory LeagueOfficial.fromJson(Map<String, dynamic> json) {
    return LeagueOfficial(
      id: json['id'],
      organizationId: json['organizationId'],
      founded: json['founded'],
      country: json['country'],
      level: json['level'],
      userId: json['userId'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'organizationId': organizationId,
    'founded': founded,
    'country': country,
    'level': level,
    'userId': userId,
    'user': user?.toJson(),
  };
}

class User {
  final String? id;
  final String? name;
  final String? image;

  const User({this.id, this.name, this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], name: json['name'], image: json['image']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'image': image};
}
