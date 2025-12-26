import 'package:get/get.dart';

import '../controllers/subscribetion_controller.dart';

class SubscribetionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscribetionController>(
      () => SubscribetionController(),
    );
  }
}
