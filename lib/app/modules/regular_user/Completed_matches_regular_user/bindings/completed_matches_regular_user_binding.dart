import 'package:get/get.dart';

import '../controllers/completed_matches_regular_user_controller.dart';

class CompletedMatchesRegularUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompletedMatchesRegularUserController>(
      () => CompletedMatchesRegularUserController(),
    );
  }
}
