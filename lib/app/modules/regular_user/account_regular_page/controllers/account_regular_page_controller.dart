import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaldmv/core/services/api_service.dart';
import 'package:kaldmv/app/data/models/regular_user_profile_model.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class AccountRegularPageController extends GetxController {
  final ApiService _apiService = ApiService();
  final ImagePicker _picker = ImagePicker();

  final isLoading = false.obs;
  final isUpdating = false.obs;
  final userProfile = Rxn<RegularUserProfile>();

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;
      final response = await _apiService.get<Map<String, dynamic>>(
        '/users/user-profile',
      );

      if (response != null && response['success'] == true) {
        userProfile.value = RegularUserProfile.fromJson(response['data'] ?? {});
        print('✅ User profile loaded: ${userProfile.value?.name}');
      }
    } catch (e) {
      print('❌ Error fetching user profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile({
    String? name,
    String? userAddress,
    String? userType,
    File? imageFile,
  }) async {
    try {
      isUpdating.value = true;

      Map<String, dynamic> body = {};
      if (name != null) body['name'] = name;
      if (userAddress != null) body['userAddress'] = userAddress;
      if (userType != null) body['userType'] = userType;

      Map<String, dynamic> formDataMap = {};
      if (body.isNotEmpty) {
        formDataMap['bodyData'] = jsonEncode(body);
      }

      if (imageFile != null) {
        formDataMap['files'] = [
          await dio.MultipartFile.fromFile(
            imageFile.path,
            filename: '', // As per user snippet
          ),
        ];
      }

      final formData = dio.FormData.fromMap(formDataMap);

      final response = await _apiService.patch<Map<String, dynamic>>(
        path: '/users/user-profile',
        data: formData,
      );

      if (response != null && response['success'] == true) {
        userProfile.value = RegularUserProfile.fromJson(response['data'] ?? {});
        Get.back();
        Get.snackbar(
          'Success',
          'Profile updated successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('❌ Error updating profile: $e');
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isUpdating.value = false;
    }
  }

  Future<File?> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  String get joinedDate {
    if (userProfile.value?.createdAt == null) return 'N/A';
    try {
      final date = DateTime.parse(userProfile.value!.createdAt!);
      return DateFormat('dd MMMM yyyy').format(date);
    } catch (e) {
      return 'N/A';
    }
  }

  // Navigation Methods
  void navigateToProfile() {
    Get.toNamed('/profile-regular');
  }

  void logout() {
    Get.offAllNamed('/login');
  }
}
