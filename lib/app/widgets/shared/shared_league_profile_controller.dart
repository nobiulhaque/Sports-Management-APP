import 'package:get/get.dart';
import 'package:kaldmv/core/services/api_service.dart';
import 'shared_league_profile_model.dart';

class SharedLeagueProfileController extends GetxController {
  final String leagueId;
  final ApiService _apiService = ApiService();

  Rxn<LeagueProfileData> profileData = Rxn();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  SharedLeagueProfileController({required this.leagueId});

  @override
  void onInit() {
    super.onInit();
    fetchLeagueProfile();
  }

  Future<void> fetchLeagueProfile() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiService.get<Map<String, dynamic>>(
        '/referee/all-leagues/$leagueId',
      );

      if (response != null) {
        final data = LeagueProfileResponse.fromJson(response);
        profileData.value = data.data;
        print('✅ League profile loaded: ${data.data.user.name}');
      } else {
        throw Exception('Failed to load league profile');
      }
    } catch (e) {
      errorMessage.value = 'Failed to load league profile: $e';
      print('❌ Error: ${errorMessage.value}');
    } finally {
      isLoading.value = false;
    }
  }
}
