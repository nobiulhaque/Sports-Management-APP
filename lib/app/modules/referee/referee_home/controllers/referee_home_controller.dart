import 'package:get/get.dart';
import 'package:kaldmv/app/data/models/referee_performance_stats_model.dart';
import 'package:kaldmv/app/data/service/drawer_service.dart';
import 'package:kaldmv/core/services/api_service.dart';

class RefereeHomeController extends GetxController {
  RefereeHomeController({DrawerService? drawerService})
    : _drawerService = drawerService;

  final DrawerService? _drawerService;
  final ApiService _apiService = ApiService();

  // Bottom navigation
  final RxInt currentIndex = 0.obs;
  void changeIndex(int index) {
    currentIndex.value = index;
  }

  // Profile data from API
  final isLoading = true.obs;
  final name = 'Loading...'.obs;
  final role = 'Referee'.obs;
  final image = ''.obs;
  final notificationCount = 0.obs;

  // Performance Stats data from API
  final performanceStats = Rx<RefereePerformanceStats?>(null);
  final statsLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
    loadPerformanceStats();
    loadNotificationCount();
  }

  Future<void> loadProfileData() async {
    try {
      isLoading.value = true;
      if (_drawerService != null) {
        final data = await _drawerService.fetchDrawerProfileDetails();

        name.value = data['name'] ?? 'Unknown';
        role.value = data['role'] ?? 'Referee';
        image.value = data['image'] ?? '';

        print("✅ Home profile data updated");
      }
    } catch (e) {
      print("❌ Error loading profile data: $e");
      // Keep default values on error
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadPerformanceStats() async {
    try {
      statsLoading.value = true;
      final response = await _apiService.get<Map<String, dynamic>>(
        '/referee/referee-performance-stats',
      );

      if (response != null) {
        if (response['success'] == true && response['data'] != null) {
          final data = response['data'] as Map<String, dynamic>;
          performanceStats.value = RefereePerformanceStats.fromJson(data);
          print(
            "✅ Performance stats loaded: ${performanceStats.value?.averageRating}",
          );
        } else {
          print("❌ API returned false success or null data");
        }
      }
    } catch (e) {
      print("❌ Error loading performance stats: $e");
      // Set default values on error
      performanceStats.value = RefereePerformanceStats(
        averageRating: 0.0,
        level: 'REGIONAL_LEVEL',
        totalMatches: 0,
      );
    } finally {
      statsLoading.value = false;
    }
  }

  Future<void> loadNotificationCount() async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/notifications',
      );

      if (response != null &&
          response['success'] == true &&
          response['data'] is List) {
        final notifications = response['data'] as List;
        notificationCount.value = notifications.length;
        print("✅ Notification count loaded: ${notificationCount.value}");
      } else {
        notificationCount.value = 0;
        print("❌ Failed to load notification count");
      }
    } catch (e) {
      print("❌ Error loading notification count: $e");
      notificationCount.value = 0;
    }
  }
}
