import 'package:get/get.dart';

import '../controllers/account_regular_page_controller.dart';

class AccountRegularPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountRegularPageController>(
      () => AccountRegularPageController(),
    );
  }
}
