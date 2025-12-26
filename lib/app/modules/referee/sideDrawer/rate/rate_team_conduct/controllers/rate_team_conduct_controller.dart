import 'package:get/get.dart';
import 'package:kaldmv/core/services/api_service.dart';
import 'package:kaldmv/core/services/api_exception.dart';
import 'package:kaldmv/app/routes/app_pages.dart';
import '../models/rate_card_model.dart';

class RateTeamConductController extends GetxController {
  final ApiService _apiService = ApiService();

  final rateCardList = RxList<RateConductData>();
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRateTeamConductData();
  }

  Future<void> fetchRateTeamConductData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      print('🚀 Fetching rate team conduct data...');

      final response = await _apiService.get('/referee/rate-team-conduct');

      print('✅ Raw API Response: $response');

      if (response != null) {
        final rateCard = RateCard.fromJson(response);

        if (rateCard.success == true && rateCard.data != null) {
          rateCardList.value = rateCard.data!;
          print('✅ Loaded ${rateCard.data!.length} matches');
        } else {
          errorMessage.value = rateCard.message ?? 'Failed to load rating data';
          print('⚠️ Response message: ${rateCard.message}');
        }
      } else {
        errorMessage.value = 'No data received from server';
        print('❌ No response from server');
      }
    } on ApiException catch (e) {
      errorMessage.value = 'API Error: ${e.message}';
      print('❌ ApiException: ${e.message} (Status: ${e.statusCode})');
    } catch (e) {
      errorMessage.value = 'Failed to load rating data: $e';
      print('❌ Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void onStartRating(RateConductData rateData) {
    // Navigate to Rate Screen with match ID
    final matchId = rateData.id ?? '';
    if (matchId.isEmpty) {
      print('❌ Error: Match ID is empty');
      return;
    }
    print(
      'Start rating for match: ${rateData.team1Name} vs ${rateData.team2Name} (ID: $matchId)',
    );
    Get.toNamed(Routes.RATE_SCREEN, arguments: matchId);
  }


}
