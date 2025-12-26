import 'package:kaldmv/core/services/api_service.dart';

class AuthRepository {
  final ApiService _api = ApiService();

  /// LOGIN API
  Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
  }) async {
    return await _api.post<Map<String, dynamic>>(
      path: "/auth/login",
      data: {
        "email": email,
        "password": password,
      },
    );
  }

  /// REGISTER API
  Future<Map<String, dynamic>?> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    return await _api.post<Map<String, dynamic>>(
      path: "/auth/register",
      data: {
        "name": name,
        "email": email,
        "password": password,
        "role": role, // USER or ADMIN etc.
      },
    );
  }
}
