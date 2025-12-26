import 'package:get/get.dart';
import 'package:kaldmv/core/services/api_service.dart';

class NavItem {
  final String svgIcon;
  final String label;
  final int index;

  NavItem({required this.svgIcon, required this.label, required this.index});
}

class HomeRegularUserController extends GetxController {
  final count = 0.obs;
  var currentIndex = 0.obs;
  final notificationCount = 0.obs;
  final _apiService = ApiService();

  // Navigation items list
  late List<NavItem> navItems;

  @override
  void onInit() {
    super.onInit();
    _initializeNavItems();
    loadNotificationCount();
  }

  void _initializeNavItems() {
    navItems = [
      NavItem(svgIcon: 'assets/icons/home.svg', label: 'Home', index: 0),
      NavItem(svgIcon: 'assets/icons/football.svg', label: 'Matches', index: 1),
      NavItem(svgIcon: 'assets/icons/league.svg', label: 'Leagues', index: 2),
      NavItem(svgIcon: 'assets/images/profile.svg', label: 'Account', index: 3),
    ];
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

  void updateNavIndex(int index) {
    currentIndex.value = index;
  }



  void increment() => count.value++;
}
