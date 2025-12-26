import 'package:get/get.dart';

import '../controllers/rate_team_conduct_controller.dart';

class RateTeamConductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RateTeamConductController>(
      () => RateTeamConductController(),
    );
  }
}
