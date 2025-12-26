import 'package:get/get.dart';
import '../controllers/upcoming_matches_controller.dart';

class UpcomingMatchesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpcomingMatchesController>(() => UpcomingMatchesController());
  }
}
