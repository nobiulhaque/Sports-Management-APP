import 'package:get/get.dart';
import '../../../../data/models/leauge_card_model.dart';
import '../../../../../core/services/api_service.dart';

class RegularLeagueController extends GetxController {
  final ApiService _apiService = ApiService();

  final isLoading = false.obs;
  final leagues = <Data>[].obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLeagues();
  }

  Future<void> fetchLeagues() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiService.get<Map<String, dynamic>>(
        '/users/all-leagues',
      );

      if (response != null && response['success'] == true) {
        final List<dynamic> dataList = response['data'] ?? [];
        leagues.value = dataList.map((json) => Data.fromJson(json)).toList();
      } else {
        errorMessage.value = response?['message'] ?? 'Failed to load leagues';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      print('Error fetching leagues: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void toggleSaveLeague(String leagueId) async {
    // Basic implementation for saving a league if supported for regular users
    // For now, just toggle locally to show it works
    final index = leagues.indexWhere((l) => l.id == leagueId);
    if (index != -1) {
      leagues[index].isSaved = !(leagues[index].isSaved ?? false);
      leagues.refresh();
    }
  }
}
