import 'package:get/get.dart';

class NotificationSeetingController extends GetxController {
  // Reactive variable to track notification state
  var isNotificationOn = false.obs;




  // Method to toggle notification
  void toggleNotification() {
    isNotificationOn.value = !isNotificationOn.value;
  }
}
