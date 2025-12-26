import 'package:get/get.dart';
import 'package:kaldmv/core/services/api_service.dart';

class RefereeProfileController extends GetxController {
  final ApiService _api = ApiService();

  // LOADING STATE
  var isLoading = false.obs;

  // USER DATA
  final userName = ''.obs;
  final userEmail = ''.obs;
  final userImage = ''.obs;
  final userRole = ''.obs;
  final userRating = 0.obs;

  // REFEREE DATA
  final bio = ''.obs;
  final location = ''.obs;
  final experience = 0.obs;
  final licenseId = ''.obs;
  final certifyingAuthority = ''.obs;
  final licenseValid = ''.obs;
  final level = ''.obs;
  final certificate = RxnString();
  final aboutMe = RxnString();
  final phone = ''.obs;
  final availability = ''.obs;
  final totalMatches = 0.obs;

  // REQUEST ID (needed for accept/decline)
  String? requestId;

  // FETCH API DATA
  Future<void> fetchRefereeDetails(String refereeId) async {
    try {
      isLoading.value = true;

      final response = await _api.get(
        "/league-officials/referee-details/$refereeId",
      );

      final data = response['data'];

      // USER DATA
      final user = data['user'];
      userName.value = user['name'] ?? '';
      userEmail.value = user['email'] ?? '';
      userImage.value = user['image'] ?? '';
      userRole.value = user['role'] ?? '';
      userRating.value = user['roundedAverage'] ?? 0;

      // REFEREE DATA
      final referee = data['referee'];
      bio.value = referee['bio'] ?? '';
      location.value = referee['location'] ?? '';
      experience.value = referee['experience'] ?? 0;
      licenseId.value = referee['licenseId'] ?? '';
      certifyingAuthority.value = referee['certifyingAuthority'] ?? '';
      licenseValid.value = referee['licenseValid'] ?? '';
      level.value = referee['level'] ?? '';
      certificate.value = referee['certificate'];
      aboutMe.value = referee['aboutMe']?? '';
      phone.value = referee['phone'] ?? '';
      availability.value = referee['availability'] ?? '';
      totalMatches.value = referee['totalMatches'] ?? 0;

    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // OPTIONAL: Request Actions
  Future<void> acceptRequest() async {
    if (requestId == null || requestId!.isEmpty) {
      Get.snackbar(
        'Error',
        'Request ID not found',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      final response = await _api.patch<Map<String, dynamic>>(
        path: "/league-officials/respond-request/$requestId",
        data: {"status": "APPROVED"},
      );

      if (response != null && response['success'] == true) {
        Get.snackbar(
          'Success',
          'Referee request accepted successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.back(result: true);
      } else {
        Get.snackbar(
          'Error',
          response?['message'] ?? 'Failed to accept request',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> declineRequest() async {
    if (requestId == null || requestId!.isEmpty) {
      Get.snackbar(
        'Error',
        'Request ID not found',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      final response = await _api.patch<Map<String, dynamic>>(
        path: "/league-officials/respond-request/$requestId",
        data: {"status": "REJECTED"},
      );

      if (response != null && response['success'] == true) {
        Get.snackbar(
          'Success',
          'Referee request declined',
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.back(result: true);
      } else {
        Get.snackbar(
          'Error',
          response?['message'] ?? 'Failed to decline request',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
