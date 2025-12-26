import 'package:get/get.dart';
import '../controllers/saved_profile_controller.dart';

class SavedProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SavedProfileController>(
      () => SavedProfileController(),
    );
  }
}
