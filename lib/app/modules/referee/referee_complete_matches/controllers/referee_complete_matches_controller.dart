import 'package:get/get.dart';
import 'package:kaldmv/core/services/api_service.dart';
import '../../../../data/models/upcoming_single_match_model.dart';

class RefereeCompleteMatchesController extends GetxController {
  final ApiService _apiService = ApiService();

  final isLoading = true.obs;
  final matchDetails = Rx<Data?>(null);
  final totalCompensation = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    // Get match ID from arguments
    final matchId = Get.arguments as String?;
    if (matchId != null) {
      fetchCompletedMatchDetails(matchId);
    }
  }

  Future<void> fetchCompletedMatchDetails(String matchId) async {
    try {
      isLoading.value = true;

      final response = await _apiService.get<Map<String, dynamic>>(
        '/referee/referee-all-matches/$matchId',
      );

      if (response != null) {
        final model = UpcomingSingleMatchModel.fromJson(response);
        if (model.success == true && model.data != null) {
          // Extract matchDetails from the nested data structure
          final responseData = response['data'] as Map<String, dynamic>?;
          if (responseData != null &&
              responseData.containsKey('matchDetails')) {
            final matchDetailsJson =
                responseData['matchDetails'] as Map<String, dynamic>;
            final extractedData = Data.fromJson(matchDetailsJson);
            matchDetails.value = extractedData;
            _calculateTotalCompensation();
            print('✅ Completed match details loaded successfully');
          } else {
            matchDetails.value = model.data;
            _calculateTotalCompensation();
            print('✅ Match details loaded successfully');
          }
        } else {
          print('❌ Error: ${model.message}');
          Get.snackbar(
            'Error',
            model.message ?? 'Failed to load match details',
          );
        }
      }
    } catch (e) {
      print('❌ Error fetching completed match details: $e');
      Get.snackbar('Error', 'Failed to load match details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _calculateTotalCompensation() {
    final match = matchDetails.value;
    if (match != null) {
      totalCompensation.value =
          (match.mainRefereeFee ?? 0).toDouble() +
          (match.mainRefereeTravelAllowance ?? 0).toDouble();
    }
  }
}
