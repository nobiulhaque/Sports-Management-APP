// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kaldmv/app/modules/common/auth/views/set_role_view.dart';
import 'package:kaldmv/core/services/api_service.dart';
import '../data/auth_repository.dart';

class AuthController extends GetxController {
  final box = GetStorage();
  final repo = AuthRepository();

  // Form Keys
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  // Loading State
  RxBool loading = false.obs;

  // Tab
  RxInt currentTab = 0.obs;

  // Login controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Register controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // Password visibility
  RxBool isPasswordHidden = true.obs;
  RxBool isRegisterPasswordHidden = true.obs;
  RxBool isConfirmPasswordHidden = true.obs;

  // Checkboxes
  RxBool rememberMe = false.obs;
  RxBool acceptTerms = false.obs;

  void changeTab(int index) => currentTab.value = index;

  // Password toggle
  void togglePasswordVisibility() =>
      isPasswordHidden.value = !isPasswordHidden.value;

  void toggleRegisterPasswordVisibility() =>
      isRegisterPasswordHidden.value = !isRegisterPasswordHidden.value;

  void toggleConfirmPasswordVisibility() =>
      isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;

  void toggleRememberMe() => rememberMe.value = !rememberMe.value;

  void toggleTerms() => acceptTerms.value = !acceptTerms.value;

  @override
  void onInit() {
    super.onInit();
    loadSavedCredentials();
  }

  // --------------------------------------------------------------------
  // REMEMBER ME FUNCTIONS
  // --------------------------------------------------------------------
  void loadSavedCredentials() {
    final savedEmail = box.read('saved_email');
    final savedPassword = box.read('saved_password');
    final isRemembered = box.read('remember_me') ?? false;

    if (isRemembered && savedEmail != null && savedPassword != null) {
      emailController.text = savedEmail;
      passwordController.text = savedPassword;
      rememberMe.value = true;
    }
  }

  Future<void> saveCredentials() async {
    if (rememberMe.value) {
      await box.write('saved_email', emailController.text.trim());
      await box.write('saved_password', passwordController.text.trim());
      await box.write('remember_me', true);
      print('CREDENTIALS SAVED');
    } else {
      await clearSavedCredentials();
    }
  }

  Future<void> clearSavedCredentials() async {
    await box.remove('saved_email');
    await box.remove('saved_password');
    await box.remove('remember_me');
    print('CREDENTIALS CLEARED');
  }

  Future<void> saveUserData(String? role, String? token) async {
    if (role != null) {
      await box.write('user_role', role);
    }
    if (token != null) {
      await box.write('user_token', token);
    }
    await box.write('is_logged_in', true);
    print('USER DATA SAVED: role=$role');
  }

  // Check if user is already logged in
  Future<bool> checkAutoLogin() async {
    final isLoggedIn = box.read('is_logged_in') ?? false;
    final token = box.read('user_token');
    final role = box.read('user_role');

    print('AUTO LOGIN CHECK: isLoggedIn=$isLoggedIn, role=$role');

    if (isLoggedIn && token != null && role != null) {
      // Navigate to appropriate screen based on role
      await ApiService().saveToken(token);

      if (role == "LEAGUE_OFFICIALS") {
        Get.offAllNamed('/home-leauge');
      } else if (role == "MAIN_REFEREE" ||
          role == "ASS_REFEREE1" ||
          role == "ASS_REFEREE2" ||
          role == "FOURTH_REFEREE") {
        Get.offAllNamed('/referee-home');
      } else if (role == "USER") {
        Get.offAllNamed('/home-regular-user');
      }
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    print('========================================');
    print('LOGOUT STARTED');

    // Remove login status
    await box.remove('is_logged_in');
    print('Removed: is_logged_in');

    // Remove user token
    await box.remove('user_token');
    print('Removed: user_token');

    // Remove user role
    await box.remove('user_role');
    print('Removed: user_role');

    // Clear saved credentials (email/password) - always clear on logout
    await clearSavedCredentials();

    // Clear input fields
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    registerEmailController.clear();
    registerPasswordController.clear();
    confirmPasswordController.clear();
    print('Input fields cleared');

    // Reset remember me checkbox
    rememberMe.value = false;
    acceptTerms.value = false;
    print('Checkboxes reset');

    // Clear token from ApiService (secure storage)
    await ApiService().logout();
    print('Token cleared from secure storage');

    // Clear any other app data if needed
    // You can add more box.remove() calls here for other saved data

    print('LOGOUT COMPLETED - All data cleared');
    print('========================================');

    // Navigate to auth screen
    Get.offAllNamed('/auth');
  }

  // --------------------------------------------------------------------
  // VALIDATION METHODS
  // --------------------------------------------------------------------
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // Email format validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != registerPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // --------------------------------------------------------------------
  // LOGIN API CALL
  // --------------------------------------------------------------------
  Future<void> login() async {
    // Validate form
    if (!loginFormKey.currentState!.validate()) {
      return;
    }

    try {
      loading(true);

      final result = await repo.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Debug print full response
      print("========================================");
      print("LOGIN RESPONSE: $result");
      print("========================================");

      if (result != null) {
        // Check if response has data object (nested structure)
        final data = result["data"] as Map<String, dynamic>?;

        // Save token - check both locations
        String? token = result["token"] as String?;
        if (token == null && data != null) {
          token = data["accessToken"] as String?;
        }

        if (token != null) {
          await ApiService().saveToken(token);
          print("TOKEN SAVED: $token");
        }

        // Get user role - check both locations
        String? role = result["role"] as String?;
        if (role == null && data != null) {
          role = data["role"] as String?;
        }

        print("USER ROLE: $role");

        // Save credentials if remember me is checked
        await saveCredentials();

        // Save user data for auto-login
        await saveUserData(role, token);

        Get.snackbar("Success", "Login successful");

        // Navigate based on role
        if (role == "LEAGUE_OFFICIALS") {
          print("NAVIGATING TO: HOME_LEAUGE");

          Get.offAllNamed('/home-leauge');
        } else if (role == "MAIN_REFEREE" ||
            role == "ASS_REFEREE1" ||
            role == "ASS_REFEREE2" ||
            role == "FOURTH_REFEREE") {
          print("NAVIGATING TO: REFEREE_HOME");
          Get.offAllNamed('/referee-home');
        } else if (role == "USER") {
          print("NAVIGATING TO: HOME_REGULAR_USER");
          Get.offAllNamed('/home-regular-user');
        } else {
          print("UNKNOWN ROLE, NAVIGATING TO: SET_ROLE");
          Get.offAll(() => SetRoleView());
        }
      } else {
        print("LOGIN FAILED: No result from API");
        Get.snackbar("Login Failed", "Invalid credentials");
      }
    } catch (e) {
      print("LOGIN ERROR: $e");
      Get.snackbar("Error", e.toString());
    } finally {
      loading(false);
    }
  }

  // --------------------------------------------------------------------
  // COMPLETE REGISTRATION WITH ROLE
  // --------------------------------------------------------------------
  Future<void> completeRegistration({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      loading(true);

      final result = await repo.register(
        name: name,
        email: email,
        password: password,
        role: role,
      );

      if (result != null) {
        // Save token if provided
        if (result["token"] != null) {
          await ApiService().saveToken(result["token"]);
        }

        Get.snackbar("Success", "Account created successfully");

        // Navigate based on role
        if (role == "USER") {
          Get.offAllNamed(
            '/regular-user-set-role',
            arguments: {'role': 'USER'},
          );
        } else if (role == "LEAGUE_OFFICIALS") {
          Get.offAllNamed(
            '/home-leauge',
            arguments: {'role': 'LEAGUE_OFFICIALS'},
          );
        } else {
          // Referee roles
          Get.offAllNamed('/subscribetion', arguments: {'role': role});
        }
      } else {
        Get.snackbar("Error", "Registration failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      loading(false);
    }
  }

  // --------------------------------------------------------------------
  // REGISTER API CALL
  // --------------------------------------------------------------------
  Future<void> register() async {
    // Validate form
    if (!registerFormKey.currentState!.validate()) {
      return;
    }

    if (!acceptTerms.value) {
      Get.snackbar("Error", "Please accept Terms & Conditions");
      return;
    }

    // Store registration data temporarily
    final registrationData = {
      'name': nameController.text.trim(),
      'email': registerEmailController.text.trim(),
      'password': registerPasswordController.text.trim(),
    };

    // Navigate to role selection screen
    Get.to(() => SetRoleView(), arguments: registrationData);
  }
}
