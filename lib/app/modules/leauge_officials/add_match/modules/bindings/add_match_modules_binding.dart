import 'package:get/get.dart';

import '../controllers/add_match_modules_controller.dart';

class AddMatchModulesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddMatchModulesController>(
      () => AddMatchModulesController(),
    );
  }
}
