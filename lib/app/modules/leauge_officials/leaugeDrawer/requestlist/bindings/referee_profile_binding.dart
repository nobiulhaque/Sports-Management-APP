import 'package:get/get.dart';
import '../controllers/referee_profile_controller.dart';

class RefereeProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RefereeProfileController>(
      () => RefereeProfileController(),
    );
  }
}
