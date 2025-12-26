import 'package:get/get.dart';

import '../controllers/regular_match_controller.dart';

class RegularMatchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegularMatchController>(
      () => RegularMatchController(),
    );
  }
}
