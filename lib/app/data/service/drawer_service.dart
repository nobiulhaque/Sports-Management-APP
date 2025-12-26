import 'package:kaldmv/core/services/api_service.dart';

class DrawerService {
  final ApiService _apiService;

  DrawerService(this._apiService);

  Future<Map<String, dynamic>> fetchDrawerProfileDetails() async {
    try {
      final response = await _apiService.get(
        '/referee/referee-profile-details',
      );

      if (response['success'] == true) {
        final data = response['data'];
        print("✅ Drawer profile loaded: ${data['name']}");
        return data;
      } else {
        throw Exception(
          response['message'] ?? 'Failed to fetch drawer profile',
        );
      }
    } catch (e) {
      print("❌ Error fetching drawer profile: $e");
      rethrow;
    }
  }
}
