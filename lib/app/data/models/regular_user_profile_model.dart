class RegularUserProfile {
  final String id;
  final String name;
  final String email;
  final String? image;
  final String role;
  final String? userAddress;
  final String? userType;
  final String? phone;
  final String? createdAt;

  RegularUserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.image,
    required this.role,
    this.userAddress,
    this.userType,
    this.phone,
    this.createdAt,
  });

  factory RegularUserProfile.fromJson(Map<String, dynamic> json) {
    return RegularUserProfile(
      id: json['id']?.toString().trim() ?? '',
      name: json['name']?.toString().trim() ?? 'Unknown',
      email: json['email']?.toString().trim() ?? '',
      image: json['image']?.toString().trim(),
      role: json['role']?.toString().trim() ?? 'USER',
      userAddress: json['userAddress']?.toString().trim() ?? 'N/A',
      userType: json['userType']?.toString().trim() ?? 'N/A',
      phone: json['phone']?.toString().trim() ?? 'N/A',
      createdAt: json['createdAt']?.toString().trim(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image,
      'role': role,
      'userAddress': userAddress,
      'userType': userType,
      'phone': phone,
      'createdAt': createdAt,
    };
  }
}
