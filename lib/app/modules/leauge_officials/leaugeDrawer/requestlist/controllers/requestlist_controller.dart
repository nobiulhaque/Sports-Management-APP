import 'package:get/get.dart';
import 'package:kaldmv/core/services/api_service.dart';

class RefereeRequest {
  final String id;
  final String refereeUserId;
  final String name;
  final String email;
  final String? image;
  final String? experience;
  final String? location;
  final String? certifyingAuthority;
  final String status;
  final String requestedAt;
  final String? respondedAt;
  final String? notes;

  RefereeRequest({
    required this.id,
    required this.refereeUserId,
    required this.name,
    required this.email,
    this.image,
    this.experience,
    this.location,
    this.certifyingAuthority,
    required this.status,
    required this.requestedAt,
    this.respondedAt,
    this.notes,
  });

  factory RefereeRequest.fromJson(Map<String, dynamic> json) {
    final referee = json['referee'] ?? {};
    final user = referee['user'] ?? {};
    
    return RefereeRequest(
      id: json['id'] ?? '',
      refereeUserId: user['id'] ?? '',
      name: user['name'] ?? 'Unknown',
      email: user['email'] ?? '',
      image: user['image'],
      experience: referee['experience']?.toString(),
      location: referee['location']?.toString(),
      certifyingAuthority: referee['certifyingAuthority']?.toString(),
      status: json['status'] ?? 'PENDING',
      requestedAt: json['requestedAt'] ?? '',
      respondedAt: json['respondedAt'],
      notes: json['notes'],
    );
  }
}

class RequestlistController extends GetxController {
  final ApiService _apiService = ApiService();
  
  final isLoading = false.obs;
  final refereeRequests = <RefereeRequest>[].obs;
  final allRequests = <RefereeRequest>[].obs;
  final errorMessage = ''.obs;
  final selectedFilter = 0.obs;
  final filters = ['All', 'This Week', 'This Month'];

  @override
  void onInit() {
    super.onInit();
    loadRefereeRequests();
  }

  void selectFilter(int index) {
    selectedFilter.value = index;
    filterRequests();
  }

  void filterRequests() {
    if (selectedFilter.value == 0) {
      // All
      refereeRequests.value = allRequests;
    } else if (selectedFilter.value == 1) {
      // This Week
      final now = DateTime.now();
      final weekAgo = now.subtract(const Duration(days: 7));
      refereeRequests.value = allRequests.where((request) {
        final requestDate = DateTime.parse(request.requestedAt);
        return requestDate.isAfter(weekAgo);
      }).toList();
    } else if (selectedFilter.value == 2) {
      // This Month
      final now = DateTime.now();
      final monthAgo = now.subtract(const Duration(days: 30));
      refereeRequests.value = allRequests.where((request) {
        final requestDate = DateTime.parse(request.requestedAt);
        return requestDate.isAfter(monthAgo);
      }).toList();
    }
  }

  Future<void> loadRefereeRequests() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // GET request - only token needed (auto-added by ApiService)
      final response = await _apiService.get<Map<String, dynamic>>(
        '/league-officials/league-requests',
      );

      if (response != null && response['success'] == true) {
        final data = response['data'] as List;
        allRequests.value = data
            .map((item) => RefereeRequest.fromJson(item))
            .where((request) => request.status.toUpperCase() == 'PENDING')
            .toList();
        
        filterRequests();
        print('✅ API Success: ${refereeRequests.length} pending requests loaded');
      } else {
        errorMessage.value = response?['message'] ?? 'Failed to load requests';
        print('❌ API Failed: $errorMessage');
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
      print('❌ API Error: $errorMessage');
      // Don't use Get.snackbar here - just print the error
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> acceptRequest(int index) async {
    try {
      final request = refereeRequests[index];
      
      isLoading.value = true;

      final response = await _apiService.patch<Map<String, dynamic>>(
        path: "/league-officials/respond-request/${request.id}",
        data: {"status": "APPROVED"},
      );

      if (response != null && response['success'] == true) {
        Get.snackbar(
          'Success',
          'Request accepted for ${request.name}',
          snackPosition: SnackPosition.BOTTOM,
        );
        // Refresh list after accepting
        await loadRefereeRequests();
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
        'Failed to accept request: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void viewProfile(int index) {
    // TODO: Navigate to profile details with selected referee data
    final request = refereeRequests[index];
    Get.toNamed('/referee-profile', arguments: request);
  }

  void sendMessage(int index) {
    // TODO: Implement message functionality
    final request = refereeRequests[index];
    Get.snackbar('Message', 'Send message to ${request.name}');
  }
}
