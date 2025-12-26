import 'package:get/get.dart';
import 'package:kaldmv/app/modules/referee/rating/rating_home/models/match_performance.dart';

class ViwDetailsController extends GetxController {
  late Rx<MatchPerformance?> matchData = Rx<MatchPerformance?>(null);

  @override
  void onInit() {
    super.onInit();
    // Get the match data from arguments passed during navigation
    final args = Get.arguments;
    if (args != null && args is MatchPerformance) {
      matchData.value = args;
    }
  }
}
