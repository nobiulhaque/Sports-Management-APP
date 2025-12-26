import 'package:get/get.dart';
import 'package:kaldmv/app/data/service/profile_service.dart';
import 'package:kaldmv/app/modules/referee/sideDrawer/profle/profile_view/controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileService>(() => ProfileService());
    Get.lazyPut<ProfileController>(() => ProfileController(Get.find()));
  }
}