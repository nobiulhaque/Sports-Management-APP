import 'package:get/get.dart';

import '../../../../../core/services/api_service.dart';
import '../../../referee/message/controllers/message_controller.dart';

class HomeLeaugeController extends GetxController {
  final ApiService _apiService = ApiService();

  var currentIndex = 0.obs;
  var isLoading = false.obs;
  var notificationCount = 0.obs;

  var profileName = ''.obs;
  var profileEmail = ''.obs;
  var profileImage = ''.obs;
  var profileRole = ''.obs;

  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchProfileDetails();
  //   loadNotificationCount();
  //   ever(currentIndex, (idx) {
  //     if (idx == 4) {
  //       // Message tab selected, trigger chat API and show loading
  //       try {
  //         final msgController = Get.find<MessageController>();
  //         msgController.isLoading.value = true; // Show loading indicator
  //         msgController.fetchChats().then((_) {
  //           print(
  //             'API call completed. Success: ${msgController.error.value == null}',
  //           );
  //           if (msgController.error.value != null) {
  //             print('API error: ${msgController.error.value}');
  //           }
  //         });
  //       } catch (e) {
  //         print('MessageSideController not found: $e');
  //       }
  //     }
  //   });
  // }

  Future<void> fetchProfileDetails() async {
    try {
      isLoading.value = true;
      final response = await _apiService.get(
        '/league-officials/league-officials-profile-details',
      );

      if (response['success'] == true) {
        final data = response['data'];
        profileName.value = data['name'] ?? '';
        profileEmail.value = data['email'] ?? '';
        profileImage.value = data['image'] ?? '';
        profileRole.value = data['role'] ?? '';
      }
    } catch (e) {
      print('Error fetching profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadNotificationCount() async {
    try {
      final response = await _apiService.get('/notifications');
      if (response['success'] == true && response['data'] != null) {
        final List<dynamic> notifications = response['data'] as List<dynamic>;
        notificationCount.value = notifications.length;
      } else {
        notificationCount.value = 0;
      }
    } catch (e) {
      print('Error loading notification count: $e');
      notificationCount.value = 0;
    }
  }
}
