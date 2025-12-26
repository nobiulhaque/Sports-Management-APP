import 'package:get/get.dart';

import '../controllers/referee_matches_controller.dart';

class RefereeMatchesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RefereeMatchesController>(
      () => RefereeMatchesController(),
    );
  }
}
