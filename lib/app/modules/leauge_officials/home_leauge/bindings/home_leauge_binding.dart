import 'package:get/get.dart';

import '../controllers/home_leauge_controller.dart';

class HomeLeaugeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeLeaugeController>(
      () => HomeLeaugeController(),
    );
  }
}
