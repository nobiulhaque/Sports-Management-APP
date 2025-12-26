import 'package:get/get.dart';

class RateRefereeController extends GetxController {
  final selectedFilter = 'All'.obs;

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }
}
