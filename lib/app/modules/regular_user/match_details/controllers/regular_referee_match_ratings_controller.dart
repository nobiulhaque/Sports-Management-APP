import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/services/api_exception.dart';
import '../../../../../core/services/api_service.dart';

class RegularRefereeMatchRatingsController extends GetxController {
  final ApiService _apiService = ApiService();

  final isLoading = false.obs;
  final isSubmitting = false.obs;
  final ratingsData = Rxn<RefereeMatchRatingsData>();

  // Review Input States
  final fairness = 0.obs;
  final control = 0.obs;
  final positioning = 0.obs;
  final communication = 0.obs;
  final commentController = TextEditingController();

  Future<void> fetchRefereeMatchRatings(
    String matchId,
    String refereeId,
  ) async {
    try {
      isLoading.value = true;

      final response = await _apiService.get(
        '/users/single-match/single-referee/$matchId/$refereeId',
      );

      if (response != null && response['success'] == true) {
        print('Parsing ratings data: ${response['data']}');
        ratingsData.value = RefereeMatchRatingsData.fromJson(response['data']);
        print(
          'Parsed match stats: YC: ${ratingsData.value?.match.yellowCards}, RC: ${ratingsData.value?.match.redCards}',
        );
        print('Feedback count: ${ratingsData.value?.allFeedback.length}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load ratings: ${e.toString()}');
      print('Error fetching referee match ratings: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitReview(String matchId, String refereeId) async {
    if (fairness.value == 0 ||
        control.value == 0 ||
        positioning.value == 0 ||
        communication.value == 0) {
      Get.snackbar('Required', 'Please rate all categories before submitting');
      return;
    }

    if (commentController.text.trim().isEmpty) {
      Get.snackbar('Required', 'Please add a comment');
      return;
    }

    try {
      isSubmitting.value = true;

      final data = {
        "refereeId": refereeId,
        "fairness": fairness.value,
        "control": control.value,
        "positioning": positioning.value,
        "communication": communication.value,
        "comment": commentController.text.trim(),
      };

      final response = await _apiService.post(
        path: '/reviews/$matchId/create',
        data: data,
      );

      if (response != null) {
        if (response['success'] == true) {
          if (response['data'] != null &&
              response['data']['moderation'] == true) {
            Get.snackbar(
              'Moderation Required',
              response['message'] ?? 'Review content requires moderation',
              backgroundColor: const Color(0xFFFEF3C7),
              colorText: const Color(0xFFD97706),
            );
          } else {
            Get.snackbar(
              'Success',
              'Review submitted successfully',
              backgroundColor: const Color(0xFFD1FAE5),
              colorText: const Color(0xFF065F46),
            );
            // Reset fields
            fairness.value = 0;
            control.value = 0;
            positioning.value = 0;
            communication.value = 0;
            commentController.clear();
            // Refresh data
            fetchRefereeMatchRatings(matchId, refereeId);
          }
        } else {
          Get.snackbar('Message', response['message'] ?? 'Failed to submit');
        }
      }
    } catch (e) {
      print('Error submitting review: $e');

      String errorMsg = e.toString();
      if (e is ApiException) {
        errorMsg = e.message;
      }

      if (errorMsg.contains('Review submission window has closed')) {
        Get.dialog(
          AlertDialog(
            title: const Text('Window Closed'),
            content: Text(errorMsg),
            actions: [
              TextButton(onPressed: () => Get.back(), child: const Text('OK')),
            ],
          ),
        );
        commentController.clear();
      } else {
        Get.snackbar(
          'Error',
          errorMsg,
          backgroundColor: const Color(0xFFFEE2E2),
          colorText: const Color(0xFF991B1B),
        );
      }
    } finally {
      isSubmitting.value = false;
    }
  }

  @override
  void onClose() {
    commentController.dispose();
    super.onClose();
  }
}

class RefereeMatchRatingsData {
  final MatchRatingsBasicInfo match;
  final String matchStartDate;
  final RatingsRefereeInfo referee;
  final double roundedAverage;
  final List<FeedbackItem> allFeedback;

  // Category Averages from API
  final double avgFairness;
  final double avgControl;
  final double avgPositioning;
  final double avgCommunication;

  RefereeMatchRatingsData({
    required this.match,
    required this.matchStartDate,
    required this.referee,
    required this.roundedAverage,
    required this.allFeedback,
    this.avgFairness = 0,
    this.avgControl = 0,
    this.avgPositioning = 0,
    this.avgCommunication = 0,
  });

  factory RefereeMatchRatingsData.fromJson(Map<String, dynamic> json) {
    // Support both nested 'match' object and flat structure where stats are at the root
    final matchData = (json['match'] != null && json['match'] is Map)
        ? json['match']
        : json;

    return RefereeMatchRatingsData(
      match: MatchRatingsBasicInfo.fromJson(matchData),
      matchStartDate: json['matchStartDate']?.toString() ?? '',
      referee: RatingsRefereeInfo.fromJson(json['referee'] ?? {}),
      roundedAverage: (json['roundedAverage'] as num?)?.toDouble() ?? 0.0,
      avgFairness: (json['fairness'] as num?)?.toDouble() ?? 0.0,
      avgControl: (json['control'] as num?)?.toDouble() ?? 0.0,
      avgPositioning: (json['positioning'] as num?)?.toDouble() ?? 0.0,
      avgCommunication: (json['communication'] as num?)?.toDouble() ?? 0.0,
      allFeedback:
          (json['allFeedback'] as List?)
              ?.map((e) => FeedbackItem.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class MatchRatingsBasicInfo {
  final String id;
  final String team1Name;
  final String team2Name;
  final String team1Logo;
  final String team2Logo;
  final int team1Goal;
  final int team2Goal;
  final String matchDate;
  final String matchTime;
  final String location;
  final int yellowCards;
  final int redCards;
  final int offsides;
  final int foulsCalled;

  MatchRatingsBasicInfo({
    required this.id,
    required this.team1Name,
    required this.team2Name,
    required this.team1Logo,
    required this.team2Logo,
    required this.team1Goal,
    required this.team2Goal,
    required this.matchDate,
    required this.matchTime,
    required this.location,
    required this.yellowCards,
    required this.redCards,
    required this.offsides,
    required this.foulsCalled,
  });

  factory MatchRatingsBasicInfo.fromJson(Map<String, dynamic> json) {
    // Helper to safely parse numbers from various formats (int, double, string)
    int parseSafeInt(dynamic value) {
      if (value == null) return 0;
      if (value is num) return value.toInt();
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    return MatchRatingsBasicInfo(
      id: json['id']?.toString() ?? '',
      team1Name: json['team1Name']?.toString() ?? '',
      team2Name: json['team2Name']?.toString() ?? '',
      team1Logo: json['team1Logo']?.toString() ?? '',
      team2Logo: json['team2Logo']?.toString() ?? '',
      team1Goal: parseSafeInt(json['team1Goal']),
      team2Goal: parseSafeInt(json['team2Goal']),
      matchDate: json['matchDate']?.toString() ?? '',
      matchTime: json['matchTime']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      // Broad check for statistics keys (snake_case and variants)
      yellowCards: parseSafeInt(
        json['yellowCards'] ?? json['yellow_cards'] ?? json['yellow_card'],
      ),
      redCards: parseSafeInt(
        json['redCards'] ?? json['red_cards'] ?? json['red_card'],
      ),
      offsides: parseSafeInt(
        json['offsides'] ?? json['off_sides'] ?? json['offside'],
      ),
      foulsCalled: parseSafeInt(
        json['foulsCalled'] ?? json['fouls_called'] ?? json['foul_called'],
      ),
    );
  }
}

class RatingsRefereeInfo {
  final String id;
  final RatingsRefereeUser user;

  RatingsRefereeInfo({required this.id, required this.user});

  factory RatingsRefereeInfo.fromJson(Map<String, dynamic> json) {
    return RatingsRefereeInfo(
      id: json['id'] ?? '',
      user: RatingsRefereeUser.fromJson(json['user'] ?? {}),
    );
  }
}

class RatingsRefereeUser {
  final String id;
  final String name;
  final String? image;
  final String role;

  RatingsRefereeUser({
    required this.id,
    required this.name,
    this.image,
    required this.role,
  });

  factory RatingsRefereeUser.fromJson(Map<String, dynamic> json) {
    return RatingsRefereeUser(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'],
      role: json['role'] ?? '',
    );
  }
}

class FeedbackItem {
  final String id;
  final int fairness;
  final int control;
  final int positioning;
  final int communication;
  final int overallRating;
  final String comment;
  final ReviewerInfo reviewer;

  FeedbackItem({
    required this.id,
    required this.fairness,
    required this.control,
    required this.positioning,
    required this.communication,
    required this.overallRating,
    required this.comment,
    required this.reviewer,
  });

  factory FeedbackItem.fromJson(Map<String, dynamic> json) {
    return FeedbackItem(
      id: json['id'] ?? '',
      fairness: (json['fairness'] as num?)?.toInt() ?? 0,
      control: (json['control'] as num?)?.toInt() ?? 0,
      positioning: (json['positioning'] as num?)?.toInt() ?? 0,
      communication: (json['communication'] as num?)?.toInt() ?? 0,
      overallRating: (json['overallRating'] as num?)?.toInt() ?? 0,
      comment: json['comment'] ?? '',
      reviewer: ReviewerInfo.fromJson(json['reviewer'] ?? {}),
    );
  }
}

class ReviewerInfo {
  final String id;
  final String name;
  final String? image;
  final String role;

  ReviewerInfo({
    required this.id,
    required this.name,
    this.image,
    required this.role,
  });

  factory ReviewerInfo.fromJson(Map<String, dynamic> json) {
    return ReviewerInfo(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'],
      role: json['role'] ?? '',
    );
  }
}
