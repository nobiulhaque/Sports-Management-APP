import 'package:get/get.dart';

import '../controllers/referee_home_controller.dart';
import 'package:kaldmv/app/modules/referee/sideDrawer/controllers/drawer_controller.dart';
import 'package:kaldmv/app/data/service/drawer_service.dart';
import 'package:kaldmv/core/services/api_service.dart';

class RefereeHomeBinding extends Bindings {
  @override
  void dependencies() {
    // Bind DrawerService with its dependencies
    Get.lazyPut<DrawerService>(() {
      final apiService = Get.isRegistered<ApiService>()
          ? Get.find<ApiService>()
          : ApiService();
      return DrawerService(apiService);
    });

    // Bind RefereeHomeController with DrawerService
    Get.lazyPut<RefereeHomeController>(
      () => RefereeHomeController(drawerService: Get.find<DrawerService>()),
    );

    // Bind SideDrawerController
    Get.lazyPut<SideDrawerController>(
      () => SideDrawerController(Get.find<DrawerService>()),
    );
  }
}
