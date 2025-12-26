import 'package:get/get.dart';
import 'package:kaldmv/app/data/models/match_details_feedback_model.dart';
import 'package:kaldmv/core/services/api_service.dart';
import 'package:kaldmv/core/utils/utils.dart';

class ViewDetailsMatchController extends GetxController {
  final isLoading = false.obs;
  final matchDetails = Rxn<Data>();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map) {
      getMatchDetails(
        refereeId: args['refereeId'],
        matchId: args['matchId'],
      );
    }
  }

  Future<void> getMatchDetails({
    required String? refereeId,
    required String? matchId,
  }) async {
    if (refereeId == null || matchId == null) {
      //Utils.snackBar('Error', 'Invalid match or referee information');
      return;
    }

    try {
      isLoading.value = true;
      final response = await ApiService().get(
        '/matches/match-details-with-referee-feedback',
        data: {
          "refereeId": refereeId,
          "matchId": matchId,
        },
      );

      if (response != null) {
        final model = MatchDetailsFeedbackModel.fromJson(response);
        if (model.success == true && model.data != null) {
          matchDetails.value = model.data;
        } else {
          //Utils.snackBar('Error', model.message ?? 'Failed to load details');
        }
      }
    } catch (e) {
     // Utils.snackBar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
