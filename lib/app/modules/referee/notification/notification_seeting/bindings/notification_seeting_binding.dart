import 'package:get/get.dart';

import '../controllers/notification_seeting_controller.dart';

class NotificationSeetingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationSeetingController>(
      () => NotificationSeetingController(),
    );
  }
}
