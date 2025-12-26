// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:kaldmv/core/services/api_service.dart';
import 'package:kaldmv/core/services/api_exception.dart';

class ResetPassController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // OTP
  final List<TextEditingController> otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> otpFocusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );

  // User ID and Token from API response
  final RxString userId = ''.obs;
  final RxString resetToken = ''.obs;

  // Password Visibility
  final RxBool isPasswordHidden = true.obs;
  final RxBool isConfirmPasswordHidden = true.obs;
  final RxBool isLoading = false.obs;
  final RxInt remainingSeconds = 90.obs;

  // Error Messages (displayed as red text under fields)
  final RxString emailError = ''.obs;
  final RxString otpError = ''.obs;
  final RxString passwordError = ''.obs;
  final RxString confirmPasswordError = ''.obs;

  Timer? _timer;

  Null get errorMessage => null;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in otpFocusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.onClose();
  }

  // Password Visibility Toggles
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  // Timer Methods
  void startOtpTimer() {
    remainingSeconds.value = 90;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  void resetOtpTimer() {
    _timer?.cancel();
    for (var controller in otpControllers) {
      controller.clear();
    }
    startOtpTimer();
    sendResetLink();
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  // OTP Code Methods
  void onOtpCodeChanged(int index, String value) {
    if (value.length == 1 && index < 3) {
      otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      otpFocusNodes[index - 1].requestFocus();
    }
  }

  String getOtpCode() {
    return otpControllers.map((controller) => controller.text).join();
  }

  // Validation Methods
  bool validateEmail(String email) {
    if (email.isEmpty) {
      emailError.value = 'Email field is required';
      return false;
    }
    if (!GetUtils.isEmail(email)) {
      emailError.value = 'Please enter a valid email address';
      return false;
    }
    emailError.value = '';
    return true;
  }

  bool validateOtp(String otp) {
    if (otp.isEmpty) {
      otpError.value = 'OTP field is required';
      return false;
    }
    if (otp.length != 4) {
      otpError.value = 'Please enter the complete 4-digit code';
      return false;
    }
    otpError.value = '';
    return true;
  }

  bool validateNewPassword(String password) {
    if (password.isEmpty) {
      passwordError.value = 'Password field is required';
      return false;
    }
    if (password.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      return false;
    }
    passwordError.value = '';
    return true;
  }

  bool validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      confirmPasswordError.value = 'Confirm password field is required';
      return false;
    }
    if (password != confirmPassword) {
      confirmPasswordError.value = 'Passwords do not match';
      return false;
    }
    confirmPasswordError.value = '';
    return true;
  }

  // API Methods
  void sendResetLink() async {
    final email = emailController.text.trim();

    print('Send OTP button pressed');
    print('Email: $email');

    // Validate email
    if (!validateEmail(email)) {
      return;
    }

    try {
      isLoading.value = true;
      final apiService = ApiService();

      final response = await apiService.post<Map<String, dynamic>>(
        path: '/auth/forgot-password',
        data: {"email": email},
      );

      if (response != null) {
        final message = response['message'] ?? 'OTP sent successfully';
        // Store userId from response
        final data = response['data'];
        if (data != null && data['id'] != null) {
          userId.value = data['id'];
          print('User ID stored: ${userId.value}');
        }

        print('Response: $response');

        Get.snackbar(
          'Success',
          message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade900,
        );

        // Navigate to OTP view after successful API call
        Get.toNamed('/otp', arguments: {'email': email});
      }
    } on ApiException catch (e) {
      print('API Error: ${e.message}');
      Get.snackbar(
        'Error',
        e.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Error',
        'Failed to send OTP. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void verifyOtp() async {
    final otpCode = getOtpCode();
    final userIdValue = userId.value;

    print('Verify OTP button pressed');
    print('OTP Code: $otpCode');
    print('User ID: $userIdValue');

    // Validate OTP
    if (!validateOtp(otpCode)) {
      return;
    }

    if (userIdValue.isEmpty) {
      otpError.value = 'User ID not found. Please request OTP again.';
      return;
    }

    try {
      isLoading.value = true;
      final apiService = ApiService();

      final response = await apiService.post<Map<String, dynamic>>(
        path: '/auth/verify-reset-password-otp',
        data: {"userId": userIdValue, "otpCode": otpCode},
      );

      if (response != null) {
        final message = response['message'] ?? 'OTP verified successfully';

        // Store token from response - look for accessToken in data
        if (response['data'] != null &&
            response['data']['accessToken'] != null) {
          resetToken.value = response['data']['accessToken'];
          print('Reset token stored: ${resetToken.value}');
        }

        print('Response: $response');

        Get.snackbar(
          'Success',
          message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade900,
        );

        // Navigate to reset password view after successful OTP verification
        Get.toNamed('/reset-password', arguments: {'userId': userIdValue});
      }
    } on ApiException catch (e) {
      print('API Error: ${e.message}');
      Get.snackbar(
        'Error',
        e.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Error',
        'Failed to verify OTP. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void resetPassword() async {
    final newPassword = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final token = resetToken.value;

    print('Reset Password button pressed');
    print('New Password: $newPassword');
    print('Token: $token');

    // Validate passwords
    if (!validateNewPassword(newPassword)) {
      return;
    }

    if (!validateConfirmPassword(newPassword, confirmPassword)) {
      return;
    }

    if (token.isEmpty) {
      passwordError.value = 'Reset token not found. Please verify OTP again.';
      return;
    }

    try {
      isLoading.value = true;
      final apiService = ApiService();

      final response = await apiService.post<Map<String, dynamic>>(
        path: '/auth/reset-password',
        data: {"newPassword": newPassword, "confirmPassword": confirmPassword},
        token: token,
        rawToken: false,
      );

      if (response != null) {
        final message = response['message'] ?? 'Password reset successfully';

        print('Response: $response');

        Get.snackbar(
          'Success',
          message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade900,
        );

        // Clear controllers and navigate to success page
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        for (var controller in otpControllers) {
          controller.clear();
        }
        userId.value = '';
        resetToken.value = '';

        // Navigate to reset success page
        Get.offAllNamed('/reset-success');
      }
    } on ApiException catch (e) {
      print('API Error: ${e.message}');
      Get.snackbar(
        'Error',
        e.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Error',
        'Failed to reset password. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
