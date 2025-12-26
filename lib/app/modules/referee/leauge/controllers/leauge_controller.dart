import 'package:get/get.dart';
import 'package:kaldmv/app/data/models/leauge_card_model.dart';
import 'package:kaldmv/core/services/api_service.dart';

class LeaugeController extends GetxController {
  final ApiService _apiService = ApiService();

  var selectedFilter = 'All'.obs;
  var leagues = <Data>[].obs;
  var isLoading = false.obs;
  var searchQuery = ''.obs;
  var errorMessage = ''.obs;

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
        '/referee/all-leagues',
      );

      if (response != null) {
        if (response['success'] == true) {
          final leagueResponse = League.fromJson(response);
          leagues.assignAll(leagueResponse.data ?? []);
          print('✅ Leagues loaded: ${leagues.length}');
        } else {
          throw Exception(response['message'] ?? 'Failed to load leagues');
        }
      } else {
        throw Exception('No data received from server');
      }
    } catch (e) {
      errorMessage.value = 'Failed to load leagues: $e';
      print('❌ Error: ${errorMessage.value}');
    } finally {
      isLoading.value = false;
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void toggleSaved(int index) {
    if (index < leagues.length) {
      leagues[index].isSaved = !(leagues[index].isSaved ?? false);
      leagues.refresh();
    }
  }

  Future<void> toggleSaveLeague(String leagueId) async {
    try {
      // Find the league
      final leagueIndex = leagues.indexWhere((l) => l.id == leagueId);
      if (leagueIndex == -1) return;

      // Optimistic UI update - change immediately for fast feedback
      final previousState = leagues[leagueIndex].isSaved;
      leagues[leagueIndex].isSaved = !(leagues[leagueIndex].isSaved ?? false);
      leagues.refresh();
      print('🔄 Toggling save for league: $leagueId (UI updated immediately)');

      // Call API in background
      final response = await _apiService.post<Map<String, dynamic>>(
        path: '/referee/toggle-save',
        data: {'leagueId': leagueId},
      );

      if (response != null && response['success'] == true) {
        print('✅ League saved status synced with server');
      } else {
        // Revert UI if API fails
        leagues[leagueIndex].isSaved = previousState;
        leagues.refresh();
        Get.snackbar(
          'Error',
          'Failed to save league. Please try again.',
          duration: const Duration(seconds: 2),
        );
        print(
          '❌ Failed to toggle save: ${response?['message'] ?? 'Unknown error'}',
        );
      }
    } catch (e) {
      // Revert on error
      final leagueIndex = leagues.indexWhere((l) => l.id == leagueId);
      if (leagueIndex != -1) {
        leagues[leagueIndex].isSaved = !(leagues[leagueIndex].isSaved ?? false);
        leagues.refresh();
      }
      Get.snackbar(
        'Error',
        'Network error. Please try again.',
        duration: const Duration(seconds: 2),
      );
      print('❌ Error toggling save: $e');
    }
  }
}
