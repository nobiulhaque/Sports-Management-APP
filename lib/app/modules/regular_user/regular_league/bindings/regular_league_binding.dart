import 'package:get/get.dart';

import '../controllers/regular_league_controller.dart';

class RegularLeagueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegularLeagueController>(
      () => RegularLeagueController(),
    );
  }
}
