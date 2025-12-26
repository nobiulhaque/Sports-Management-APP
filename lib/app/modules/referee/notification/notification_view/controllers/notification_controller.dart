import 'package:get/get.dart';
import 'package:kaldmv/core/services/api_service.dart';
import '../models/notification_model.dart';

class NotificationController extends GetxController {
  final notifications = <NotificationModel>[].obs;
  final isLoading = false.obs;
  final error = RxnString();

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    isLoading.value = true;
    error.value = null;
    try {
      final response = await ApiService().get<Map<String, dynamic>>(
        '/notifications',
        
      );
      if (response != null &&
          response['success'] == true &&
          response['data'] is List) {
        notifications.value = (response['data'] as List)
            .map((e) => NotificationModel.fromJson(e))
            .toList();
      } else {
        error.value = response?['message'] ?? 'Failed to load notifications';
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
