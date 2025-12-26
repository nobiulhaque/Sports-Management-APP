// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:kaldmv/core/services/api_service.dart';
import '../../data/league_officials_model.dart';

class LeaugeEditProfileController extends GetxController {
  // Image files
  Rx<File?> profileImage = Rx<File?>(null);
  Rx<File?> officialRepImage = Rx<File?>(null);

  // Form controllers - Basic Info
  final leagueNameController = TextEditingController();
  final statusController = TextEditingController();
  final foundedController = TextEditingController();

  // Form controllers - League Credentials
  final organizationIdController = TextEditingController();
  final countryController = TextEditingController();
  final certifyingAuthorityController = TextEditingController();
  final licenseValidController = TextEditingController();
  final levelController = TextEditingController();

  // Form controllers - Official Representative
  final fullNameController = TextEditingController();
  final designationController = TextEditingController();
  final contactNumberController = TextEditingController();
  final emailController = TextEditingController();

  // Loading state
  var isLoading = false.obs;
  var isDataLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  // Load existing profile data
  Future<void> loadProfileData() async {
    try {
      isDataLoading.value = true;

      final response = await ApiService().get<Map<String, dynamic>>(
        "/league-officials",
      );

      if (response != null) {
        final data = LeagueOfficialsResponse.fromJson(response);
        final profileData = data.data;

        // Populate form fields with existing data
        leagueNameController.text = profileData.user.name;
        statusController.text = profileData.leagueOfficialsId.status;
        foundedController.text = profileData.leagueOfficialsId.founded.toString();
        
        organizationIdController.text = profileData.leagueOfficialsId.organizationId ?? '';
        countryController.text = profileData.leagueOfficialsId.country ?? '';
        certifyingAuthorityController.text = profileData.leagueOfficialsId.certifyingAuthority ?? '';
        licenseValidController.text = profileData.leagueOfficialsId.licenseValid ?? '';
        levelController.text = profileData.leagueOfficialsId.level;
        
        fullNameController.text = profileData.leagueOfficialsId.officialName ?? '';
        designationController.text = profileData.leagueOfficialsId.officialDesignation ?? '';
        contactNumberController.text = profileData.leagueOfficialsId.officialPhone ?? '';
        emailController.text = profileData.leagueOfficialsId.officialEmail ?? '';

        print('Profile data loaded successfully');
      }
    } catch (e) {
      print("ERROR LOADING PROFILE DATA: $e");
      Get.snackbar(
        "Error",
        "Failed to load profile data",
        backgroundColor: Get.theme.colorScheme.errorContainer,
        colorText: Get.theme.colorScheme.onErrorContainer,
      );
    } finally {
      isDataLoading.value = false;
    }
  }

  @override
  void onClose() {
    // Dispose all controllers
    leagueNameController.dispose();
    statusController.dispose();
    foundedController.dispose();
    organizationIdController.dispose();
    countryController.dispose();
    certifyingAuthorityController.dispose();
    licenseValidController.dispose();
    levelController.dispose();
    fullNameController.dispose();
    designationController.dispose();
    contactNumberController.dispose();
    emailController.dispose();
    super.onClose();
  }

  // ---------------------------
  // IMAGE PICKERS
  // ---------------------------
  Future<void> pickProfileImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        profileImage.value = File(result.files.single.path!);
        print('Profile Image Added: ${result.files.single.path}');
        print('Image Name: ${result.files.single.name}');
        print('Image Size: ${result.files.single.size} bytes');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  Future<void> pickOfficialRepImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        officialRepImage.value = File(result.files.single.path!);
        print('Official Representative Image Added: ${result.files.single.path}');
        print('Image Name: ${result.files.single.name}');
        print('Image Size: ${result.files.single.size} bytes');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  // ---------------------------
  // API IMPLEMENTATION
  // ---------------------------
  
  // Update Basic Info
  Future<void> updateBasicInfo() async {
    try {
      isLoading.value = true;

      final bodyData = {
        "status": statusController.text,
        "founded": int.tryParse(foundedController.text) ?? 0,
      };

      print('Updating Basic Info: $bodyData');

      final Map<String, dynamic> formMap = {
        "bodyData": jsonEncode(bodyData),
      };

      // Add profile image if selected
      if (profileImage.value != null) {
        formMap["image"] = await MultipartFile.fromFile(
          profileImage.value!.path,
          filename: profileImage.value!.path.split(Platform.pathSeparator).last,
        );
      }

      final response = await ApiService().post(
        path: "/league-officials",
        data: FormData.fromMap(formMap),
      );

      print("API RESPONSE: $response");
      Get.snackbar(
        "Success",
        "Basic Info Updated Successfully",
        backgroundColor: Get.theme.colorScheme.primaryContainer,
        colorText: Get.theme.colorScheme.onPrimaryContainer,
      );
    } catch (e) {
      print("API ERROR: $e");
      Get.snackbar(
        "Error",
        "Failed to update basic info: ${e.toString()}",
        backgroundColor: Get.theme.colorScheme.errorContainer,
        colorText: Get.theme.colorScheme.onErrorContainer,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Update League Credentials
  Future<void> updateLeagueCredentials() async {
    try {
      isLoading.value = true;

      final bodyData = {
        "organizationId": organizationIdController.text,
        "country": countryController.text,
        "certifyingAuthority": certifyingAuthorityController.text,
        "licenseValid": licenseValidController.text,
        "level": levelController.text,
      };

      print('Updating League Credentials: $bodyData');

      final Map<String, dynamic> formMap = {
        "bodyData": jsonEncode(bodyData),
      };

      final response = await ApiService().post(
        path: "/league-officials",
        data: FormData.fromMap(formMap),
      );

      print("API RESPONSE: $response");
      Get.snackbar(
        "Success",
        "League Credentials Updated Successfully",
        backgroundColor: Get.theme.colorScheme.primaryContainer,
        colorText: Get.theme.colorScheme.onPrimaryContainer,
      );
    } catch (e) {
      print("API ERROR: $e");
      Get.snackbar(
        "Error",
        "Failed to update credentials: ${e.toString()}",
        backgroundColor: Get.theme.colorScheme.errorContainer,
        colorText: Get.theme.colorScheme.onErrorContainer,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Update Official Representative
  Future<void> updateOfficialRepresentative() async {
    try {
      isLoading.value = true;

      final bodyData = {
        "officialName": fullNameController.text,
        "officialDesignation": designationController.text,
        "officialPhone": contactNumberController.text,
        "officialEmail": emailController.text,
      };

      print('Updating Official Representative: $bodyData');

      final Map<String, dynamic> formMap = {
        "bodyData": jsonEncode(bodyData),
      };

      // Add official representative image if selected
      if (officialRepImage.value != null) {
        formMap["officialImage"] = await MultipartFile.fromFile(
          officialRepImage.value!.path,
          filename: officialRepImage.value!.path.split(Platform.pathSeparator).last,
        );
      }

      final response = await ApiService().post(
        path: "/league-officials",
        data: FormData.fromMap(formMap),
      );

      print("API RESPONSE: $response");
      Get.snackbar(
        "Success",
        "Official Representative Updated Successfully",
        backgroundColor: Get.theme.colorScheme.primaryContainer,
        colorText: Get.theme.colorScheme.onPrimaryContainer,
      );
    } catch (e) {
      print("API ERROR: $e");
      Get.snackbar(
        "Error",
        "Failed to update representative: ${e.toString()}",
        backgroundColor: Get.theme.colorScheme.errorContainer,
        colorText: Get.theme.colorScheme.onErrorContainer,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitProfileUpdate() async {
    try {
      isLoading.value = true;

      // Prepare body data
      final bodyData = {
        "name": leagueNameController.text,
        "status": statusController.text,
        "founded": int.tryParse(foundedController.text) ?? 0,
        "organizationId": organizationIdController.text,
        "country": countryController.text,
        "certifyingAuthority": certifyingAuthorityController.text,
        "licenseValid": licenseValidController.text,
        "level": levelController.text,
        "officialName": fullNameController.text,
        "officialDesignation": designationController.text,
        "officialPhone": contactNumberController.text,
        "officialEmail": emailController.text,
      };

      print('Submitting data: $bodyData');

      // Prepare form data
      final Map<String, dynamic> formMap = {
        "bodyData": jsonEncode(bodyData),
      };

      // Add profile image if selected
      if (profileImage.value != null) {
        formMap["image"] = await MultipartFile.fromFile(
          profileImage.value!.path,
          filename: profileImage.value!.path.split(Platform.pathSeparator).last,
        );
      }

      // Add official representative image if selected
      if (officialRepImage.value != null) {
        formMap["officialImage"] = await MultipartFile.fromFile(
          officialRepImage.value!.path,
          filename: officialRepImage.value!.path.split(Platform.pathSeparator).last,
        );
      }

      final response = await ApiService().post(
        path: "/league-officials",
        data: FormData.fromMap(formMap),
      );

      print("API RESPONSE: $response");
      Get.snackbar(
        "Success",
        "Profile Updated Successfully",
        backgroundColor: Get.theme.colorScheme.primaryContainer,
        colorText: Get.theme.colorScheme.onPrimaryContainer,
      );

      // Navigate back after success
      Get.back();
    } catch (e) {
      print("API ERROR: $e");
      Get.snackbar(
        "Error",
        "Failed to update profile: ${e.toString()}",
        backgroundColor: Get.theme.colorScheme.errorContainer,
        colorText: Get.theme.colorScheme.onErrorContainer,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Cancel action
  void cancelEdit() {
    Get.back();
  }
}
