import 'package:get/get.dart';
import '../../../../../core/services/api_service.dart';

class RegularRefereesController extends GetxController {
  final ApiService _apiService = ApiService();

  final isLoading = false.obs;
  final referees = <RefereeData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllReferees();
  }

  Future<void> fetchAllReferees() async {
    try {
      isLoading.value = true;

      final response = await _apiService.get('/users/all-referees');

      if (response != null && response['success'] == true) {
        final List<dynamic> data = response['data'] ?? [];
        referees.value = data.map((e) => RefereeData.fromJson(e)).toList();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load referees: ${e.toString()}');
      print('Error fetching referees: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

class RefereeData {
  final String id;
  final String userId;
  final String name;
  final String? image;
  final String role;
  final double averageRating;
  final int totalReviews;
  final int? experience;
  final String level;
  final int totalMatches;

  RefereeData({
    required this.id,
    required this.userId,
    required this.name,
    this.image,
    required this.role,
    required this.averageRating,
    required this.totalReviews,
    this.experience,
    required this.level,
    required this.totalMatches,
  });

  factory RefereeData.fromJson(Map<String, dynamic> json) {
    try {
      // The data is nested: json -> referee -> user
      final referee = json['referee'] as Map<String, dynamic>? ?? {};
      final user = referee['user'] as Map<String, dynamic>? ?? {};

      return RefereeData(
        id: (json['id'] as String?) ?? '',
        userId: (user['id'] as String?) ?? '',
        name: (user['name'] as String?) ?? 'Unknown',
        image: user['image'] as String?,
        role: (user['role'] as String?) ?? 'Referee',
        averageRating: _toDouble(referee['averageRating']),
        totalReviews: (referee['totalReviews'] as int?) ?? 0,
        experience: referee['experience'] as int?,
        level: (referee['level'] as String?) ?? 'REGIONAL_LEVEL',
        totalMatches: (referee['totalMatches'] as int?) ?? 0,
      );
    } catch (e) {
      print('Error parsing referee data: $e');
      print('JSON: $json');
      rethrow;
    }
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}
