import 'package:get/get.dart';
import 'package:kaldmv/app/data/models/my_league_referees_model.dart';
import 'package:kaldmv/core/services/api_service.dart';
import 'package:kaldmv/core/utils/utils.dart';

class RefereforleaugeController extends GetxController {
  final isLoading = false.obs;
  final refereeList = <MyLeagueRefereesData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchReferees();
  }

  Future<void> fetchReferees() async {
    try {
      isLoading.value = true;
      final response = await ApiService().get('/league-officials/my-league-referee');

      if (response != null) {
        final model = MyLeagueRefereesModel.fromJson(response);
        if (model.success == true && model.data != null) {
          var data = model.data!;
          final args = Get.arguments;
          
          if (args != null && args is Map && args['role'] != null && args['role'].toString().isNotEmpty) {
             final filterRole = args['role'].toString().toUpperCase();
             data = data.where((element) => 
               element.referee?.user?.role?.toUpperCase() == filterRole
             ).toList();
          }

          refereeList.assignAll(data);
        } else {
          //Utils.snackBar('Error', model.message ?? 'Failed to load referees');
        }
      }
    } catch (e) {
      //Utils.snackBar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
