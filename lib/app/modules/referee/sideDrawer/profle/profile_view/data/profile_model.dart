class ProfileModel {
  final bool success;
  final int statusCode;
  final String message;
  final ProfileData? data;

  ProfileModel({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? ProfileData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class ProfileData {
  final User? user;
  final Referee? referee;

  ProfileData({this.user, this.referee});

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      referee: json['referee'] != null ? Referee.fromJson(json['referee']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'referee': referee?.toJson(),
    };
  }
}

class User {
  final String? id;
  final String? name;
  final String? email;
  final String? image;
  final String? role;
  final int? roundedAverage;

  User({
    this.id,
    this.name,
    this.email,
    this.image,
    this.role,
    this.roundedAverage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
      role: json['role'],
      roundedAverage: json['roundedAverage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image,
      'role': role,
      'roundedAverage': roundedAverage,
    };
  }
}

class Referee {
  final String? id;
  final String? bio;
  final String? location;
  final String? experience;
  final String? licenseId;
  final String? certifyingAuthority;
  final String? licenseValid;
  final String? level;
  final String? certificate;
  final String? aboutMe;
  final String? phone;
  final String? availability;
  final int? totalMatches;

  Referee({
    this.id,
    this.bio,
    this.location,
    this.experience,
    this.licenseId,
    this.certifyingAuthority,
    this.licenseValid,
    this.level,
    this.certificate,
    this.aboutMe,
    this.phone,
    this.availability,
    this.totalMatches,
  });

  factory Referee.fromJson(Map<String, dynamic> json) {
    return Referee(
      id: json['id'],
      bio: json['bio'],
      location: json['location'],
      experience: json['experience'],
      licenseId: json['licenseId'],
      certifyingAuthority: json['certifyingAuthority'],
      licenseValid: json['licenseValid'],
      level: json['level'],
      certificate: json['certificate'],
      aboutMe: json['aboutMe'],
      phone: json['phone'],
      availability: json['availability'],
      totalMatches: json['totalMatches'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bio': bio,
      'location': location,
      'experience': experience,
      'licenseId': licenseId,
      'certifyingAuthority': certifyingAuthority,
      'licenseValid': licenseValid,
      'level': level,
      'certificate': certificate,
      'aboutMe': aboutMe,
      'phone': phone,
      'availability': availability,
      'totalMatches': totalMatches,
    };
  }
}
