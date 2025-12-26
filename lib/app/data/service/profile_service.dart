// ignore_for_file: avoid_print

import 'dart:async';
import 'package:kaldmv/app/data/models/profile_model.dart';
import 'package:kaldmv/core/services/api_service.dart';

class ProfileService {
  Future<Profile> fetchProfile() async {
    try {
      // Fetch profile data from universal API service
      final response = await ApiService().get<Map<String, dynamic>>('/referee');

      print("========================================");
      print("FULL RESPONSE: $response");
      print("Response type: ${response.runtimeType}");
      print("========================================");

      if (response == null) {
        throw Exception('API returned null');
      }

      // The API wraps the response with success, statusCode, message, data
      // Check if this is the wrapped response
      final success = response['success'];
      final statusCode = response['statusCode'];
      final data = response['data'];

      print("Success: $success, StatusCode: $statusCode");
      print("Data: $data");

      if (success != true || data == null) {
        throw Exception(
          'Failed to fetch profile: success=$success, data=$data',
        );
      }

      // Extract user and referee data from the data object
      final userData = data['user'] as Map<String, dynamic>?;
      final refereeData = data['referee'] as Map<String, dynamic>?;

      print("USER DATA: $userData");
      print("REFEREE DATA: $refereeData");

      if (userData == null || refereeData == null) {
        throw Exception('User or Referee data is null');
      }

      // Map API response to Profile model
      final hasCertificate =
          refereeData['certificate'] != null &&
          (refereeData['certificate'] as String).isNotEmpty;

      final profile = Profile(
        name: userData['name'] ?? 'Unknown',
        title: refereeData['bio'] ?? '',
        location: refereeData['location'] ?? '',
        email: userData['email'] ?? '',
        phone: refereeData['phone'] ?? '',
        avatarUrl: userData['image'] ?? '',
        experienceYears: _parseExperienceYears(refereeData['experience']),
        matches: refereeData['totalMatches'] ?? 0,
        rating: (userData['roundedAverage'] ?? 0).toDouble(),
        progression: ((userData['roundedAverage'] ?? 0) / 5.0).clamp(0.0, 1.0),
        licenseId: refereeData['licenseId'] ?? 'N/A',
        certifyingAuthority: refereeData['certifyingAuthority'] ?? '',
        issueDate: _parseDate(refereeData['issueDate']),
        validTill: _parseDate(refereeData['licenseValid']),
        level: refereeData['level'] ?? 'N/A',
        certFileName: _extractFileName(refereeData['certificate'] ?? ''),
        certificateUrl: refereeData['certificate'] ?? '',
        about: refereeData['aboutMe'] ?? refereeData['bio'] ?? '',
        available: refereeData['availability'] ?? 'N/A',
        hasCertificate: hasCertificate,
      );

      print("✅ Profile successfully created: ${profile.name}");
      return profile;
    } catch (e) {
      print("❌ ERROR FETCHING PROFILE: $e");
      rethrow;
    }
  }

  // Helper method to parse experience years - handles both int and String
  int _parseExperienceYears(dynamic experience) {
    if (experience == null) return 0;

    // If it's already an int, return it directly
    if (experience is int) {
      return experience;
    }

    // If it's a string, try to extract the number
    if (experience is String) {
      final regExp = RegExp(r'(\d+)');
      final match = regExp.firstMatch(experience);
      return match != null ? int.parse(match.group(1)!) : 0;
    }

    return 0;
  }

  // Helper method to parse date strings from API
  DateTime _parseDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return DateTime.now();
    }
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      print("Error parsing date: $dateString");
      return DateTime.now();
    }
  }

  // Helper method to extract filename from full URL/path
  String _extractFileName(String urlOrPath) {
    if (urlOrPath.isEmpty) return '';
    // Extract filename from URL or path
    // e.g., "https://example.com/uploads/certificate.pdf" -> "certificate.pdf"
    return urlOrPath.split('/').last;
  }
}
