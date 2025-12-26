import 'package:get/get.dart';

import '../controllers/league_official_matches_controller.dart';

class LeagueOfficialMatchesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeagueOfficialMatchesController>(
      () => LeagueOfficialMatchesController(),
    );
  }
}
