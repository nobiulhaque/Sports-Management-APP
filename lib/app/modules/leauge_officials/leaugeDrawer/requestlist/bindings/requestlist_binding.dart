import 'package:get/get.dart';

import '../controllers/requestlist_controller.dart';

class RequestlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestlistController>(
      () => RequestlistController(),
    );
  }
}
