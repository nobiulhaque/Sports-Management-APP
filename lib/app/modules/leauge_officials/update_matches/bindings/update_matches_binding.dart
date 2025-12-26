import 'package:get/get.dart';

import '../controllers/update_matches_controller.dart';

class UpdateMatchesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateMatchesController>(
      () => UpdateMatchesController(),
    );
  }
}
