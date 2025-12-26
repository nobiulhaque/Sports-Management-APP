import 'package:get/get.dart';
import 'package:kaldmv/app/data/models/leauge_card_model.dart';
import 'package:kaldmv/core/services/api_service.dart';

class SavedPageController extends GetxController {
  final ApiService _apiService = ApiService();

  var selectedFilter = 'All'.obs;
  var savedLeagues = <Data>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSavedLeagues();
  }

  Future<void> fetchSavedLeagues() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Build query parameters based on selected filter
      Map<String, dynamic> queryParams = {};
      if (selectedFilter.value != 'All') {
        queryParams['timeFilter'] = selectedFilter.value.toLowerCase();
      }

      final response = await _apiService.get<Map<String, dynamic>>(
        '/referee/saved-leagues',
        query: queryParams,
      );

      if (response != null) {
        if (response['success'] == true) {
          // Extract the data array from response
          final dataList = response['data'] as List?;
          if (dataList != null) {
            // Map each saved league item to Data object (extract the 'league' field)
            final leagues = dataList.map((item) {
              final league = Data.fromJson(
                item['league'] as Map<String, dynamic>,
              );
              // Ensure isSaved is true since these are saved leagues
              league.isSaved = true;
              return league;
            }).toList();

            savedLeagues.assignAll(leagues);
            print('✅ Saved leagues loaded: ${savedLeagues.length}');
          } else {
            throw Exception('No data found in response');
          }
        } else {
          throw Exception(
            response['message'] ?? 'Failed to load saved leagues',
          );
        }
      } else {
        throw Exception('No data received from server');
      }
    } catch (e) {
      errorMessage.value = 'Failed to load saved leagues: $e';
      print('❌ Error: ${errorMessage.value}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onFilterChanged(String filter) async {
    selectedFilter.value = filter;
    await fetchSavedLeagues();
  }

  Future<void> toggleSaveLeague(String leagueId) async {
    try {
      // Find the league
      final leagueIndex = savedLeagues.indexWhere((l) => l.id == leagueId);
      if (leagueIndex == -1) return;

      // Optimistic UI update - change immediately for fast feedback
      final previousState = savedLeagues[leagueIndex].isSaved;
      savedLeagues[leagueIndex].isSaved =
          !(savedLeagues[leagueIndex].isSaved ?? false);
      savedLeagues.refresh();
      print('🔄 Toggling save for league: $leagueId (UI updated immediately)');

      // Call API in background
      final response = await _apiService.post<Map<String, dynamic>>(
        path: '/referee/toggle-save',
        data: {'leagueId': leagueId},
      );

      if (response != null && response['success'] == true) {
        print('✅ League saved status synced with server');
        // If league is unsaved (isSaved is now false), remove it from the saved list
        if (savedLeagues[leagueIndex].isSaved == false) {
          savedLeagues.removeAt(leagueIndex);
          print('🗑️ League removed from saved list');
        }
      } else {
        // Revert UI if API fails
        savedLeagues[leagueIndex].isSaved = previousState;
        savedLeagues.refresh();
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
      final leagueIndex = savedLeagues.indexWhere((l) => l.id == leagueId);
      if (leagueIndex != -1) {
        savedLeagues[leagueIndex].isSaved =
            !(savedLeagues[leagueIndex].isSaved ?? false);
        savedLeagues.refresh();
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
