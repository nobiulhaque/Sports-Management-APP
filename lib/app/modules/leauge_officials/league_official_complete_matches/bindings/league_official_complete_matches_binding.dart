import 'package:get/get.dart';

import '../controllers/league_official_complete_matches_controller.dart';

class LeagueOfficialCompleteMatchesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeagueOfficialCompleteMatchesController>(
      () => LeagueOfficialCompleteMatchesController(),
    );
  }
}
