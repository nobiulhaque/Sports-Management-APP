import 'package:get/get.dart';
import 'package:kaldmv/core/services/api_service.dart';

import '../../data/league_officials_model.dart';

class LeaugeProfileController extends GetxController {
  var isLoading = true.obs;
  LeagueOfficialsData? profileData;

  @override
  void onInit() {
    super.onInit();
    fetchLeagueProfile();
  }

  Future<void> fetchLeagueProfile() async {
    try {
      isLoading(true);

      final response = await ApiService().get<Map<String, dynamic>>(
        "/league-officials",
      );

      if (response != null) {
        final data = LeagueOfficialsResponse.fromJson(response);
        profileData = data.data;
      }
    } catch (e) {
      print("ERROR FETCHING PROFILE: $e");
    } finally {
      isLoading(false);
    }
  }
}
