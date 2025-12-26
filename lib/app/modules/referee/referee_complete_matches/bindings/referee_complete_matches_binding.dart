import 'package:get/get.dart';

import '../controllers/referee_complete_matches_controller.dart';

class RefereeCompleteMatchesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RefereeCompleteMatchesController>(
      () => RefereeCompleteMatchesController(),
    );
  }
}
