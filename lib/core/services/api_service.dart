// lib/core/services/api_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide FormData;
import '../urls/urls.dart';
import 'api_exception.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  late final Dio _dio;
  final _storage = const FlutterSecureStorage();
  static const String _tokenKey = 'auth_token';

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _normalizeBaseUrl(Urls.baseUrl),
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Accept': 'application/json'},
      ),
    );

    _setupInterceptors();
  }

  // --------------------------------------------------------------
  // Base URL Cleaner
  // --------------------------------------------------------------
  String _normalizeBaseUrl(String url) {
    if (url.isEmpty) throw ArgumentError('baseUrl cannot be empty.');

    String cleaned = url.trim();

    if (!cleaned.startsWith('http://') && !cleaned.startsWith('https://')) {
      cleaned = 'https://$cleaned';
    }

    if (cleaned.endsWith('/')) {
      cleaned = cleaned.substring(0, cleaned.length - 1);
    }

    debugPrint('API Base URL: $cleaned');
    return cleaned;
  }

  // --------------------------------------------------------------
  // Interceptors
  // --------------------------------------------------------------
  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // LOGIN & REGISTER skip token
          if (options.path.contains("login") ||
              options.path.contains("register")) {
            return handler.next(options);
          }

          // RESET-PASSWORD: Do NOT auto attach token (Flutter will add manually)
          if (options.path.contains("reset-password")) {
            debugPrint("⚠️ Skipping Interceptor Token for reset-password");
            return handler.next(options);
          }

          final token = await getValidToken();

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          handler.next(options);
        },
        onError: (error, handler) {
          if (error.response?.statusCode == 401) {
            _handleUnauthorized();
          }
          handler.next(error);
        },
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (obj) => debugPrint(obj.toString()),
        ),
      );
    }
  }

  // --------------------------------------------------------------
  // TOKEN FUNCTIONS
  // --------------------------------------------------------------
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> getRawToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<String?> getValidToken() async {
    final token = await getRawToken();
    if (token == null || token.isEmpty) return null;

    if (!_isTokenValid(token)) {
      await logout();
      return null;
    }

    return token;
  }

  bool _isTokenValid(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return false;

      final payload = json.decode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
      );

      final exp = payload['exp'] as int?;
      if (exp == null) return false;

      return exp > DateTime.now().millisecondsSinceEpoch ~/ 1000;
    } catch (_) {
      return false;
    }
  }

  // --------------------------------------------------------------
  // LOGOUT
  // --------------------------------------------------------------
  Future<void> logout() async {
    await _storage.delete(key: _tokenKey);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.currentRoute != '/login') {
        if (Get.context != null) {
          Get.offAllNamed('/login');
        }
      }
    });
  }

  void _handleUnauthorized() async {
    await logout();

    if (Get.currentRoute != '/login') {
      Get.snackbar(
        'Session Expired',
        'Please login again.',
        duration: const Duration(seconds: 3),
      );
    }
  }

  // --------------------------------------------------------------
  // GET Method
  // --------------------------------------------------------------
  Future<T?> get<T>(String path,
      {Map<String, dynamic>? query, Object? data}) async {
    try {
      return (await _dio.get<T>(path, queryParameters: query, data: data)).data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // --------------------------------------------------------------
  // POST Method (UPDATED)
  // Supports raw token, bearer token, or no token
  // --------------------------------------------------------------
  Future<T?> post<T>({
    required String path,
    dynamic data,
    String? token,
    bool rawToken = false,
  }) async {
    try {
      Options options = Options(
        headers: {},
        contentType: data is FormData ? null : 'application/json',
      );

      // Manual token override (reset-password case)
      if (token != null) {
        options.headers!["Authorization"] = rawToken ? token : "Bearer $token";

        debugPrint(
          "🔐 Custom Authorization Header Added → ${options.headers!["Authorization"]}",
        );
      }

      return (await _dio.post<T>(path, data: data, options: options)).data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // --------------------------------------------------------------
  // PATCH Method
  // --------------------------------------------------------------
  Future<T?> patch<T>({
    required String path,
    dynamic data,
    String? token,
    bool rawToken = false,
  }) async {
    try {
      Options options = Options(
        headers: {},
        contentType: data is FormData ? null : 'application/json',
      );

      // Manual token override if needed
      if (token != null) {
        options.headers!["Authorization"] = rawToken ? token : "Bearer $token";

        debugPrint(
          "🔐 Custom Authorization Header Added → ${options.headers!["Authorization"]}",
        );
      }

      return (await _dio.patch<T>(path, data: data, options: options)).data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // --------------------------------------------------------------
  // DELETE Method
  // --------------------------------------------------------------
  Future<T?> delete<T>({
    required String path,
    dynamic data,
    String? token,
    bool rawToken = false,
  }) async {
    try {
      Options options = Options(headers: {});

      // Manual token override if needed
      if (token != null) {
        options.headers!["Authorization"] = rawToken ? token : "Bearer $token";

        debugPrint(
          "🔐 Custom Authorization Header Added → ${options.headers!["Authorization"]}",
        );
      }

      return (await _dio.delete<T>(path, data: data, options: options)).data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // --------------------------------------------------------------
  // ERROR HANDLER
  // --------------------------------------------------------------
  ApiException _handleError(DioException e) {
    String message = "Network error";
    final data = e.response?.data;

    if (e.type == DioExceptionType.connectionError ||
        e.error is SocketException) {
      message = "No internet connection";
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      message = "Connection timeout";
    } else if (e.response != null) {
      if (data is Map && data['message'] != null) {
        message = data['message'].toString();
      } else if (data is Map &&
          data['errors'] != null &&
          data['errors'] is Map) {
        final errors = data['errors'] as Map;
        message = errors.values.first is List
            ? errors.values.first[0]
            : errors.values.first.toString();
      } else if (data is String) {
        message = data;
      } else {
        message = "Server error (${e.response?.statusCode})";
      }
    }

    debugPrint("API ERROR: $message");
    return ApiException(
      message,
      statusCode: e.response?.statusCode,
      data: data,
    );
  }
}
