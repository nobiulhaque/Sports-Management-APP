import 'package:get/get.dart';

import '../controllers/regular_user_set_role_controller.dart';

class RegularUserSetRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegularUserSetRoleController>(
      () => RegularUserSetRoleController(),
    );
  }
}
