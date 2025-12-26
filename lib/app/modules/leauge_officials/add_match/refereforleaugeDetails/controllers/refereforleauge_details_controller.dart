import 'package:get/get.dart';
import 'package:kaldmv/app/data/models/my_league_referees_model.dart';
import 'package:kaldmv/app/data/models/referee_details_model.dart';
import 'package:kaldmv/core/services/api_service.dart';
import 'package:kaldmv/core/utils/utils.dart';

class RefereforleaugeDetailsController extends GetxController {
  final isLoading = false.obs;
  final refereeDetails = Rxn<Referee>();

  @override
  void onInit() {
    super.onInit();
    final refereeId = Get.arguments;
    if (refereeId != null && refereeId is String) {
      getRefereeDetails(refereeId);
    } else {
      // Handle case where id is missing if needed, or just let it stay empty
    }
  }

  Future<void> getRefereeDetails(String refereeId) async {
    try {
      isLoading.value = true;
      final response = await ApiService().get('/league-officials/referee-details/$refereeId');

      if (response != null) {
        final model = RefereeDetailsModel.fromJson(response);
        if (model.success == true && model.data != null) {
          refereeDetails.value = model.data;
          print('Referee Role: ${model.data?.user?.role}');
        } else {
          //Utils.snackBar('Error', model.message ?? 'Failed to load referee details');
        }
      }
    } catch (e) {
     // Utils.snackBar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
