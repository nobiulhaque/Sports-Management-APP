import 'package:get/get.dart';
import '../../../../../core/services/api_service.dart';

class RefereeProfileDetailsController extends GetxController {
  final ApiService _api = ApiService();

  // LOADING STATE
  var isLoading = false.obs;

  // USER DATA
  final userId = ''.obs;
  final userName = ''.obs;
  final userEmail = ''.obs;
  final userImage = RxnString();
  final userRole = ''.obs;
  final userRating = 0.obs;

  // REFEREE DATA
  final refereeId = ''.obs;
  final bio = RxnString();
  final location = RxnString();
  final experience = RxnInt();
  final licenseId = RxnString();
  final certifyingAuthority = RxnString();
  final licenseValid = RxnString();
  final level = ''.obs;
  final certificate = RxnString();
  final aboutMe = RxnString();
  final phone = RxnString();
  final availability = RxnString();
  final totalMatches = 0.obs;

  // FETCH API DATA
  Future<void> fetchRefereeDetails(
    String userId, {
    bool isRegularUser = false,
  }) async {
    try {
      isLoading.value = true;

      // Use different endpoint based on user type
      final endpoint = isRegularUser
          ? "/users/league-referee-details/$userId"
          : "/league-officials/referee-details/$userId";

      final response = await _api.get(endpoint);

      if (response != null && response['success'] == true) {
        final data = response['data'];

        // USER DATA
        final user = data['user'];
        this.userId.value = user['id'] ?? '';
        userName.value = user['name'] ?? '';
        userEmail.value = user['email'] ?? '';
        userImage.value = user['image'];
        userRole.value = user['role'] ?? '';
        userRating.value = user['roundedAverage'] ?? 0;

        // REFEREE DATA
        final referee = data['referee'];
        refereeId.value = referee['id'] ?? '';
        bio.value = referee['bio'];
        location.value = referee['location'];
        experience.value = referee['experience'];
        licenseId.value = referee['licenseId'];
        certifyingAuthority.value = referee['certifyingAuthority'];
        licenseValid.value = referee['licenseValid'];
        level.value = referee['level'] ?? '';
        certificate.value = referee['certificate'];
        aboutMe.value = referee['aboutMe'];
        phone.value = referee['phone'];
        availability.value = referee['availability'];
        totalMatches.value = referee['totalMatches'] ?? 0;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
