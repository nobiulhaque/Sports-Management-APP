import 'package:get/get.dart';
import 'package:kaldmv/core/services/api_service.dart';
import '../../../../data/models/upcoming_single_match_model.dart';

class MatchDetailsController extends GetxController {
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
      fetchMatchDetails(matchId);
    }
  }

  Future<void> fetchMatchDetails(String matchId) async {
    try {
      isLoading.value = true;

      final response = await _apiService.get<Map<String, dynamic>>(
        '/referee/referee-upcoming-matches/$matchId',
      );

      if (response != null) {
        final model = UpcomingSingleMatchModel.fromJson(response);
        if (model.success == true && model.data != null) {
          matchDetails.value = model.data;
          _calculateTotalCompensation();
          print('✅ Match details loaded successfully');
        } else {
          print('❌ Error: ${model.message}');
          Get.snackbar(
            'Error',
            model.message ?? 'Failed to load match details',
          );
        }
      }
    } catch (e) {
      print('❌ Error fetching match details: $e');
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
