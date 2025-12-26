import 'package:get/get.dart';

import '../../../../data/models/leauge_card_model.dart';

class LeaguesRegularUserController extends GetxController {
  var selectedFilter = 'All'.obs;
  var savedLeagues = <Data>[].obs;
  var isLoading = false.obs;

}
