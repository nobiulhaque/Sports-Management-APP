import 'package:get/get.dart';
import 'package:kaldmv/app/modules/regular_user/LeaguesRegularUser/controllers/league_profile_controller.dart';

import '../controllers/leagues_regular_user_controller.dart';

class LeaguesRegularUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaguesRegularUserController>(
      () => LeaguesRegularUserController(),
    );
    Get.lazyPut< LeagueProfileController>(
          () => LeagueProfileController(),
    );
  }
}
