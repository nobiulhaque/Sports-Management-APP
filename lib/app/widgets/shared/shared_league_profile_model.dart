class LeagueProfileResponse {
  final bool success;
  final int statusCode;
  final String message;
  final LeagueProfileData data;

  LeagueProfileResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory LeagueProfileResponse.fromJson(Map<String, dynamic> json) {
    return LeagueProfileResponse(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: LeagueProfileData.fromJson(json['data']),
    );
  }
}

class LeagueProfileData {
  final String id;
  final String status;
  final String leagueStatus;
  final int founded;
  final String organizationId;
  final String country;
  final String certifyingAuthority;
  final String licenseValid;
  final String level;
  final String officialName;
  final String officialDesignation;
  final String officialPhone;
  final String officialImage;
  final String officialEmail;
  final String lastLogin;
  final String createdAt;
  final String updatedAt;
  final String userId;
  final LeagueUser user;
  final String joinedOn;
  final String licenseValidTill;
  final int refereesHired;
  final int ongoingMatches;
  final int pendingMatches;
  final int completedMatches;

  LeagueProfileData({
    required this.id,
    required this.status,
    required this.leagueStatus,
    required this.founded,
    required this.organizationId,
    required this.country,
    required this.certifyingAuthority,
    required this.licenseValid,
    required this.level,
    required this.officialName,
    required this.officialDesignation,
    required this.officialPhone,
    required this.officialImage,
    required this.officialEmail,
    required this.lastLogin,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.user,
    required this.joinedOn,
    required this.licenseValidTill,
    required this.refereesHired,
    required this.ongoingMatches,
    required this.pendingMatches,
    required this.completedMatches,
  });

  factory LeagueProfileData.fromJson(Map<String, dynamic> json) {
    return LeagueProfileData(
      id: json['id'] ?? '',
      status: json['status'] ?? '',
      leagueStatus: json['leagueStatus'] ?? '',
      founded: json['founded'] ?? 0,
      organizationId: json['organizationId'] ?? '',
      country: json['country'] ?? '',
      certifyingAuthority: json['certifyingAuthority'] ?? '',
      licenseValid: json['licenseValid'] ?? '',
      level: json['level'] ?? '',
      officialName: json['officialName'] ?? '',
      officialDesignation: json['officialDesignation'] ?? '',
      officialPhone: json['officialPhone'] ?? '',
      officialImage: json['officialImage'] ?? '',
      officialEmail: json['officialEmail'] ?? '',
      lastLogin: json['lastLogin'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      userId: json['userId'] ?? '',
      user: LeagueUser.fromJson(json['user'] ?? {}),
      joinedOn: json['joinedOn'] ?? '',
      licenseValidTill: json['licenseValidTill'] ?? '',
      refereesHired: json['refereesHired'] ?? 0,
      ongoingMatches: json['ongoingMatches'] ?? 0,
      pendingMatches: json['pendingMatches'] ?? 0,
      completedMatches: json['completedMatches'] ?? 0,
    );
  }
}

class LeagueUser {
  final String id;
  final String name;
  final String email;
  final String? image;
  final String? createdAt;

  LeagueUser({
    required this.id,
    required this.name,
    required this.email,
    this.image,
    this.createdAt,
  });

  factory LeagueUser.fromJson(Map<String, dynamic> json) {
    return LeagueUser(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      image: json['image'],
      createdAt: json['createdAt'],
    );
  }
}
