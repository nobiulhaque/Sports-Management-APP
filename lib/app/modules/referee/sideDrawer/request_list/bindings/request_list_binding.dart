import 'package:get/get.dart';

import '../controllers/request_list_controller.dart';

class RequestListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestListController>(
      () => RequestListController(),
    );
  }
}
