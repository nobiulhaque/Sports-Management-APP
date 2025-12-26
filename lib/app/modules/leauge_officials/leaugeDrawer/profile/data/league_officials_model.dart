class LeagueOfficialsResponse {
  final bool success;
  final int statusCode;
  final String message;
  final LeagueOfficialsData data;

  LeagueOfficialsResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory LeagueOfficialsResponse.fromJson(Map<String, dynamic> json) {
    return LeagueOfficialsResponse(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: LeagueOfficialsData.fromJson(json['data']),
    );
  }
}

class LeagueOfficialsData {
  final User user;
  final LeagueOfficialsId leagueOfficialsId;
  final int totalReferees;
  final int totalMatches;
  final int ongoingMatches;
  final int pendingMatches;
  final int completedMatches;

  LeagueOfficialsData({
    required this.user,
    required this.leagueOfficialsId,
    required this.totalReferees,
    required this.totalMatches,
    required this.ongoingMatches,
    required this.pendingMatches,
    required this.completedMatches,
  });

  factory LeagueOfficialsData.fromJson(Map<String, dynamic> json) {
    return LeagueOfficialsData(
      user: User.fromJson(json['user']),
      leagueOfficialsId: LeagueOfficialsId.fromJson(json['leagueOfficialsId']),
      totalReferees: json['totalReferees'],
      totalMatches: json['totalMatches'],
      ongoingMatches: json['ongoingMatches'],
      pendingMatches: json['pendingMatches'],
      completedMatches: json['completedMatches'],
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String? image;
  final String role;
  final String status;
  final String joinedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.image,
    required this.role,
    required this.status,
    required this.joinedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
      role: json['role'],
      status: json['status'],
      joinedAt: json['joinedAt'],
    );
  }
}

class LeagueOfficialsId {
  final String id;
  final String status;
  final int founded;
  final String? organizationId;
  final String? country;
  final String? certifyingAuthority;
  final String? licenseValid;
  final String level;
  final String? officialName;
  final String? officialDesignation;
  final String? officialPhone;
  final String? officialImage;
  final String? officialEmail;

  LeagueOfficialsId({
    required this.id,
    required this.status,
    required this.founded,
    this.organizationId,
    this.country,
    this.certifyingAuthority,
    this.licenseValid,
    required this.level,
    this.officialName,
    this.officialDesignation,
    this.officialPhone,
    this.officialImage,
    this.officialEmail,
  });

  factory LeagueOfficialsId.fromJson(Map<String, dynamic> json) {
    return LeagueOfficialsId(
      id: json['id'],
      status: json['status'],
      founded: json['founded'],
      organizationId: json['organizationId'],
      country: json['country'],
      certifyingAuthority: json['certifyingAuthority'],
      licenseValid: json['licenseValid'],
      level: json['level'],
      officialName: json['officialName'],
      officialDesignation: json['officialDesignation'],
      officialPhone: json['officialPhone'],
      officialImage: json['officialImage'],
      officialEmail: json['officialEmail'],
    );
  }
}
