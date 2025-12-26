import 'package:get/get.dart';

import '../controllers/home_regular_user_controller.dart';
import '../controllers/regular_matches_controller.dart';
import '../controllers/regular_referees_controller.dart';
import '../../regular_league/controllers/regular_league_controller.dart';
import '../../account_regular_page/controllers/account_regular_page_controller.dart';

class HomeRegularUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeRegularUserController>(() => HomeRegularUserController());
    Get.lazyPut<RegularMatchesController>(() => RegularMatchesController());
    Get.lazyPut<RegularLeagueController>(() => RegularLeagueController());
    Get.lazyPut<RegularRefereesController>(() => RegularRefereesController());
    Get.lazyPut<AccountRegularPageController>(
      () => AccountRegularPageController(),
    );
  }
}
