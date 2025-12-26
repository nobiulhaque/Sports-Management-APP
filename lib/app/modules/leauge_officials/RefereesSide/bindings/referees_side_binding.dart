import 'package:get/get.dart';

import '../controllers/referees_side_controller.dart';

class RefereesSideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RefereesSideController>(
      () => RefereesSideController(),
    );
  }
}
