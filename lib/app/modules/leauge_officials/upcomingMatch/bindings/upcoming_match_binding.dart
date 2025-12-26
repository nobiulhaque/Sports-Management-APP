import 'package:get/get.dart';

import '../controllers/upcoming_match_controller.dart';

class UpcomingMatchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpcomingMatchController>(
      () => UpcomingMatchController(),
    );
  }
}
