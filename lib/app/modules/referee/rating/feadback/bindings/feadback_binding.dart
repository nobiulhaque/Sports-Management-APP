import 'package:get/get.dart';

import '../controllers/feadback_controller.dart';

class FeadbackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeadbackController>(
      () => FeadbackController(),
    );
  }
}
