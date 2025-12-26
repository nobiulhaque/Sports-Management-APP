import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../../core/services/api_service.dart';


class ChangepasswordController extends GetxController {
  final ApiService _apiService = ApiService();

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;
  final currentPasswordError = ''.obs;
  final newPasswordError = ''.obs;
  final confirmPasswordError = ''.obs;

  Future<void> resetPassword() async {
    // Clear previous errors
    currentPasswordError.value = '';
    newPasswordError.value = '';
    confirmPasswordError.value = '';

    final current = currentPasswordController.text.trim();
    final newPass = newPasswordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    bool hasError = false;

    /// Validation
    if (current.isEmpty) {
      currentPasswordError.value = 'Current password is required';
      hasError = true;
    }

    if (newPass.isEmpty) {
      newPasswordError.value = 'New password is required';
      hasError = true;
    } else if (newPass.length < 8) {
      newPasswordError.value = 'Password must be at least 8 characters';
      hasError = true;
    }

    if (confirm.isEmpty) {
      confirmPasswordError.value = 'Confirm password is required';
      hasError = true;
    } else if (newPass != confirm) {
      confirmPasswordError.value = 'Passwords do not match';
      hasError = true;
    }

    if (hasError) return;

    try {
      isLoading.value = true;

      final response = await _apiService.post(
        path: '/auth/change-password',
        data: {
          "oldPassword": current,
          "newPassword": newPass,
          "confirmPassword": confirm,
        },
      );

      if (response != null) {
        Fluttertoast.showToast(
          msg: "Password changed successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        /// Clear fields after success
        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();

        /// Optional: go back
        Get.back();
      }
    } catch (e) {
      String errorMessage = e.toString();
      
      // Check if error is about old password mismatch
      if (errorMessage.toLowerCase().contains('old password') || 
          errorMessage.toLowerCase().contains('current password') ||
          errorMessage.toLowerCase().contains('incorrect password')) {
        currentPasswordError.value = 'Old password does not match';
      } else {
        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
