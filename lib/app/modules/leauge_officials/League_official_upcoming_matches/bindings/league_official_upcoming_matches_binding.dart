import 'package:get/get.dart';

import '../controllers/league_official_upcoming_matches_controller.dart';

class LeagueOfficialUpcomingMatchesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeagueOfficialUpcomingMatchesController>(
      () => LeagueOfficialUpcomingMatchesController(),
    );
  }
}
