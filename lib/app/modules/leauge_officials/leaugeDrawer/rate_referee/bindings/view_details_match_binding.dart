import 'package:get/get.dart';
import 'package:kaldmv/app/modules/leauge_officials/leaugeDrawer/rate_referee/controllers/view_details_match_controller.dart';

class ViewDetailsMatchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewDetailsMatchController>(
      () => ViewDetailsMatchController(),
    );
  }
}
