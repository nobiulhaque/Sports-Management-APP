class Profile {
  final String name;
  final String title;
  final String location;
  final String email;
  final String phone;
  final String avatarUrl;
  final int experienceYears;
  final int matches;
  final double rating; // 0-5
  final double progression; // 0-1

  // Credentials
  final String licenseId;
  final String certifyingAuthority;
  final DateTime issueDate;
  final DateTime validTill;
  final String level;
  final String certFileName;

  // About + availability
  final String about;
  final bool available;
  final bool hasCertificate;

  const Profile({
    required this.name,
    required this.title,
    required this.location,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    required this.experienceYears,
    required this.matches,
    required this.rating,
    required this.progression,
    required this.licenseId,
    required this.certifyingAuthority,
    required this.issueDate,
    required this.validTill,
    required this.level,
    required this.certFileName,
    required this.about,
    required this.available,
    required this.hasCertificate,
  });

  Profile copyWith({
    String? name,
    String? title,
    String? location,
    String? email,
    String? phone,
    String? avatarUrl,
    int? experienceYears,
    int? matches,
    double? rating,
    double? progression,
    String? licenseId,
    String? certifyingAuthority,
    DateTime? issueDate,
    DateTime? validTill,
    String? level,
    String? certFileName,
    String? about,
    bool? available,
    bool? hasCertificate,
  }) {
    return Profile(
      name: name ?? this.name,
      title: title ?? this.title,
      location: location ?? this.location,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      experienceYears: experienceYears ?? this.experienceYears,
      matches: matches ?? this.matches,
      rating: rating ?? this.rating,
      progression: progression ?? this.progression,
      licenseId: licenseId ?? this.licenseId,
      certifyingAuthority: certifyingAuthority ?? this.certifyingAuthority,
      issueDate: issueDate ?? this.issueDate,
      validTill: validTill ?? this.validTill,
      level: level ?? this.level,
      certFileName: certFileName ?? this.certFileName,
      about: about ?? this.about,
      available: available ?? this.available,
      hasCertificate: hasCertificate ?? this.hasCertificate,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'title': title,
    'location': location,
    'email': email,
    'phone': phone,
    'avatarUrl': avatarUrl,
    'experienceYears': experienceYears,
    'matches': matches,
    'rating': rating,
    'progression': progression,
    'licenseId': licenseId,
    'certifyingAuthority': certifyingAuthority,
    'issueDate': issueDate.toIso8601String(),
    'validTill': validTill.toIso8601String(),
    'level': level,
    'certFileName': certFileName,
    'about': about,
    'available': available,
    'hasCertificate': hasCertificate,
  };

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    name: json['name'] as String,
    title: json['title'] as String,
    location: json['location'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
    avatarUrl: json['avatarUrl'] as String,
    experienceYears: json['experienceYears'] as int,
    matches: json['matches'] as int,
    rating: (json['rating'] as num).toDouble(),
    progression: (json['progression'] as num).toDouble(),
    licenseId: json['licenseId'] as String,
    certifyingAuthority: json['certifyingAuthority'] as String,
    issueDate: DateTime.parse(json['issueDate'] as String),
    validTill: DateTime.parse(json['validTill'] as String),
    level: json['level'] as String,
    certFileName: json['certFileName'] as String,
    about: json['about'] as String,
    available: json['available'] as bool,
    hasCertificate: json['hasCertificate'] as bool? ?? false,
  );
}
