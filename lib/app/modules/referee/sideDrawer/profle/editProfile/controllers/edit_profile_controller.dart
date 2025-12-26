// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:kaldmv/app/modules/referee/sideDrawer/profle/profile_view/controllers/profile_controller.dart';
import 'package:kaldmv/core/services/api_service.dart';

class EditProfileController extends GetxController {
  late ProfileController profileController;
  final ApiService _apiService = ApiService();

  // Profile image properties
  final profileImagePath = ''.obs;
  final profileImageLoadError = false.obs;
  File? profileImage;
  final ImagePicker _picker = ImagePicker();

  // Certificate file properties
  final certificateFilePath = ''.obs;
  File? certificateFile;

  // Separate states for each section
  final basicInfoSaving = false.obs;
  final credentialsSaving = false.obs;
  final aboutMeSaving = false.obs;
  final contactInfoSaving = false.obs;

  // Text Controllers for Basic Info Section
  late TextEditingController fullNameController;
  late TextEditingController bioController;
  late TextEditingController locationController;
  late TextEditingController experienceController;

  // Text Controllers for Credentials Section
  late TextEditingController licenseIdController;
  late TextEditingController certifyingAuthorityController;
  late TextEditingController licenseValidTillController;
  late TextEditingController levelController;

  // Selected date for License Valid Till
  Rx<DateTime?> selectedLicenseValidDate = Rx<DateTime?>(null);
  final licenseValidTillDate = ''.obs;

  // Text Controllers for About Me Section
  late TextEditingController aboutMeController;

  // Text Controllers for Contact Info Section
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController availabilityController;

  @override
  void onInit() {
    super.onInit();
    // Initialize Basic Info Controllers
    fullNameController = TextEditingController();
    bioController = TextEditingController();
    locationController = TextEditingController();
    experienceController = TextEditingController();

    // Initialize Credentials Controllers
    licenseIdController = TextEditingController();
    certifyingAuthorityController = TextEditingController();
    licenseValidTillController = TextEditingController();
    levelController = TextEditingController();

    // Initialize About Me Controller
    aboutMeController = TextEditingController();

    // Initialize Contact Info Controllers
    emailController = TextEditingController();
    phoneController = TextEditingController();
    availabilityController = TextEditingController();

    // Get ProfileController and load data
    try {
      profileController = Get.find<ProfileController>();
      _loadProfileData();
    } catch (e) {
      print("❌ Error getting ProfileController: $e");
    }
  }

  // Load profile data and populate controllers
  void _loadProfileData() {
    try {
      final profile = profileController.profile.value;
      if (profile != null) {
        // Basic Info
        fullNameController.text = profile.name;
        bioController.text = profile.title;
        locationController.text = profile.location;
        experienceController.text = profile.experienceYears > 0
            ? '${profile.experienceYears}'
            : '';

        // Credentials
        licenseIdController.text = profile.licenseId;
        certifyingAuthorityController.text = profile.certifyingAuthority;
        licenseValidTillController.text = profile.validTill != null
            ? profile.validTill.toString().split(' ')[0]
            : '';
        levelController.text = profile.level;

        // About Me
        aboutMeController.text = profile.about;

        // Contact Info
        emailController.text = profile.email;
        phoneController.text = profile.phone;
        availabilityController.text = profile.available;

        // Profile Image - Store URL (from server) with cache-busting parameter
        if (profile.avatarUrl != null && profile.avatarUrl.isNotEmpty) {
          // Add timestamp to URL to bypass cache and force fresh fetch
          final timestamp = DateTime.now().millisecondsSinceEpoch;
          final urlWithTimestamp = '${profile.avatarUrl}?t=$timestamp';
          profileImagePath.value = urlWithTimestamp;
          profileImageLoadError.value = false;
          print('✅ Profile image URL loaded: ${profile.avatarUrl}');
        } else {
          profileImageLoadError.value = true;
          print('⚠️  No profile image URL available');
        }

        // Don't fetch certificate - keep it empty for upload only
      }
    } catch (e) {
      print('⚠️  Error loading profile data: $e');
    }
  }

  // Refresh profile data (for pull-to-refresh)
  Future<void> refreshProfileData() async {
    try {
      // Reload the profile data from the ProfileController
      await profileController.loadProfileData();
      _loadProfileData();
      // Get.snackbar(
      //   'Success',
      //   'Profile refreshed',
      //   snackPosition: SnackPosition.BOTTOM,
      //   duration: const Duration(seconds: 2),
      // );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to refresh profile: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    // Dispose Basic Info Controllers
    fullNameController.dispose();
    bioController.dispose();
    locationController.dispose();
    experienceController.dispose();

    // Dispose Credentials Controllers
    licenseIdController.dispose();
    certifyingAuthorityController.dispose();
    licenseValidTillController.dispose();
    levelController.dispose();

    // Dispose About Me Controller
    aboutMeController.dispose();

    // Dispose Contact Info Controllers
    emailController.dispose();
    phoneController.dispose();
    availabilityController.dispose();

    super.onClose();
  }

  // Pick profile image from camera or gallery
  Future<void> pickProfileImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        profileImage = File(pickedFile.path);
        profileImagePath.value = pickedFile.path;
        Get.snackbar(
          'Success',
          'Profile image updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Pick certificate file
  Future<void> pickCertificateFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
      );

      if (result != null && result.files.isNotEmpty) {
        certificateFile = File(result.files.first.path!);
        certificateFilePath.value = result.files.first.path!;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick certificate: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Pick license valid till date
  Future<void> pickLicenseValidDate() async {
    try {
      final initialDate = selectedLicenseValidDate.value ?? DateTime.now();

      final DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: initialDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 20),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xFF1E3A8A),
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF1E3A8A),
                ),
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedDate != null) {
        selectedLicenseValidDate.value = pickedDate;
        // Format date as YYYY-MM-DD
        final formattedDate =
            '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
        licenseValidTillController.text = formattedDate;
        licenseValidTillDate.value = formattedDate;
        print('✅ License Valid Till Date selected: $formattedDate');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick date: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('❌ Error picking date: $e');
    }
  }

  // Save Basic Info Section
  Future<void> saveBasicInfo() async {
    basicInfoSaving.value = true;
    print('=== Saving Basic Info ===');

    try {
      final profile = profileController.profile.value;

      // Detect what has changed
      final changedData = <String, dynamic>{};

      // Check if Name changed
      if (profile != null && fullNameController.text != profile.name) {
        changedData['name'] = fullNameController.text.trim();
        print('✅ Name changed: ${fullNameController.text}');
      }

      // Check if Bio changed
      if (profile != null && bioController.text != profile.title) {
        changedData['bio'] = bioController.text.trim();
        print('✅ Bio changed: ${bioController.text}');
      }

      // Check if Location changed
      if (profile != null && locationController.text != profile.location) {
        changedData['location'] = locationController.text.trim();
        print('✅ Location changed: ${locationController.text}');
      }

      // Check if Experience changed
      if (profile != null && experienceController.text.isNotEmpty) {
        final experienceInt = int.tryParse(experienceController.text) ?? 0;
        if (experienceInt != profile.experienceYears) {
          changedData['experience'] = experienceInt;
          print('✅ Experience changed: $experienceInt');
        }
      }

      // Check if Profile image was selected
      bool imageChanged = profileImage != null;

      if (imageChanged) {
        print(
          '✅ Profile image selected: ${profileImage!.path.split('/').last}',
        );
      }

      // If nothing changed, show warning
      if (changedData.isEmpty && !imageChanged) {
        Get.snackbar(
          'No Changes',
          'No fields were modified',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        basicInfoSaving.value = false;
        return;
      }

      // Build FormData
      late FormData formData;

      // Add profile image only if selected
      if (imageChanged && profileImage != null) {
        try {
          final multipartFile = await MultipartFile.fromFile(
            profileImage!.path,
            filename: profileImage!.path.split('/').last,
          );
          formData = FormData.fromMap({
            'files': [multipartFile],
          });
          print('✅ Added profile image: ${profileImage!.path.split('/').last}');
        } catch (e) {
          print('⚠️  Error adding image: $e');
          Get.snackbar(
            'Error',
            'Failed to prepare image: $e',
            snackPosition: SnackPosition.BOTTOM,
          );
          basicInfoSaving.value = false;
          return;
        }
      }

      // Add only changed fields as JSON
      if (changedData.isNotEmpty) {
        final jsonData = jsonEncode(changedData);
        if (formData.fields.isEmpty && formData.files.isEmpty) {
          // Only text changes, no image
          formData = FormData.fromMap({'bodyData': jsonData});
        } else {
          // Image was added, also add text data
          formData.fields.add(MapEntry('bodyData', jsonData));
        }
        print('✅ Added bodyData: $jsonData');
      }

      print('📤 Sending request to /referee...');

      // Call API
      final response = await _apiService.post(path: '/referee', data: formData);

      if (response != null) {
        Get.snackbar(
          'Success',
          'Basic Info updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        // Refresh profile data
        await profileController.loadProfileData();
        _loadProfileData();

        // Clear image selection
        profileImage = null;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save Basic Info: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      print('❌ Error saving Basic Info: $e');
    } finally {
      basicInfoSaving.value = false;
      print('========================');
    }
  }

  // Save Credentials Section
  Future<void> saveCredentials() async {
    credentialsSaving.value = true;
    print('=== Saving Credentials ===');

    try {
      final profile = profileController.profile.value;

      // Detect what has changed
      final changedData = <String, dynamic>{};

      // Check if License ID changed
      if (profile != null && licenseIdController.text != profile.licenseId) {
        changedData['licenseId'] = licenseIdController.text.trim();
        print('✅ License ID changed: ${licenseIdController.text}');
      }

      // Check if Certifying Authority changed
      if (profile != null &&
          certifyingAuthorityController.text != profile.certifyingAuthority) {
        changedData['certifyingAuthority'] = certifyingAuthorityController.text
            .trim();
        print(
          '✅ Certifying Authority changed: ${certifyingAuthorityController.text}',
        );
      }

      // Check if License Valid Till changed
      if (profile != null && licenseValidTillController.text.isNotEmpty) {
        final originalDate = profile.validTill != null
            ? profile.validTill.toString().split(' ')[0]
            : '';
        if (licenseValidTillController.text != originalDate) {
          // Convert date to ISO-8601 DateTime format (YYYY-MM-DDTHH:mm:ssZ)
          final dateString = licenseValidTillController.text.trim();
          final isoDateTime = '${dateString}T00:00:00Z';
          changedData['licenseValid'] = isoDateTime;
          print('✅ License Valid Till changed: $isoDateTime');
        }
      }

      // Check if Level changed
      if (profile != null && levelController.text != profile.level) {
        changedData['level'] = levelController.text.trim();
        print('✅ Level changed: ${levelController.text}');
      }

      // Check if Certificate file was selected
      bool certificateChanged =
          certificateFilePath.value.isNotEmpty && certificateFile != null;

      if (certificateChanged) {
        print(
          '✅ Certificate file selected: ${certificateFilePath.value.split('/').last}',
        );
      }

      // If nothing changed, show warning
      if (changedData.isEmpty && !certificateChanged) {
        Get.snackbar(
          'No Changes',
          'No fields were modified',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        credentialsSaving.value = false;
        return;
      }

      // Build FormData
      final formData = FormData();

      // Add certificate file only if selected
      if (certificateChanged && certificateFile != null) {
        try {
          formData.files.add(
            MapEntry(
              'files',
              await MultipartFile.fromFile(
                certificateFile!.path,
                filename: certificateFile!.path.split('/').last,
              ),
            ),
          );
          print(
            '✅ Added certificate file: ${certificateFile!.path.split('/').last}',
          );
        } catch (e) {
          print('⚠️  Error adding certificate: $e');
        }
      }

      // Add only changed fields as JSON
      if (changedData.isNotEmpty) {
        final jsonData = jsonEncode(changedData);
        formData.fields.add(MapEntry('bodyData', jsonData));
        print('✅ Added bodyData: $jsonData');
      }

      print('📤 Sending request to /referee...');

      // Call API
      final response = await _apiService.post(path: '/referee', data: formData);

      if (response != null) {
        Get.snackbar(
          'Success',
          'Credentials updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        // Refresh profile data
        await profileController.loadProfileData();
        _loadProfileData();

        // Clear certificate selection
        certificateFile = null;
        certificateFilePath.value = '';
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save Credentials: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      print('❌ Error saving Credentials: $e');
    } finally {
      credentialsSaving.value = false;
      print('========================');
    }
  }

  // Save About Me Section
  Future<void> saveAboutMe() async {
    aboutMeSaving.value = true;
    print('=== Saving About Me ===');

    try {
      final profile = profileController.profile.value;

      // Detect what has changed
      final changedData = <String, dynamic>{};

      // Check if About Me changed
      if (profile != null && aboutMeController.text != profile.about) {
        changedData['aboutMe'] = aboutMeController.text.trim();
        print('✅ About Me changed: ${aboutMeController.text}');
      }

      // If nothing changed, show warning
      if (changedData.isEmpty) {
        Get.snackbar(
          'No Changes',
          'No fields were modified',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        aboutMeSaving.value = false;
        return;
      }

      // Build FormData
      final formData = FormData();

      // Build bodyData - only send fields with actual values
      final bodyData = <String, dynamic>{};

      if (bioController.text.trim().isNotEmpty) {
        bodyData['bio'] = bioController.text.trim();
      }
      if (locationController.text.trim().isNotEmpty) {
        bodyData['location'] = locationController.text.trim();
      }
      if (experienceController.text.trim().isNotEmpty) {
        bodyData['experience'] = int.tryParse(experienceController.text) ?? 0;
      }
      if (licenseIdController.text.trim().isNotEmpty) {
        bodyData['licenseId'] = licenseIdController.text.trim();
      }
      if (certifyingAuthorityController.text.trim().isNotEmpty) {
        bodyData['certifyingAuthority'] = certifyingAuthorityController.text
            .trim();
      }
      if (licenseValidTillController.text.trim().isNotEmpty) {
        final dateString = licenseValidTillController.text.trim();
        final isoDateTime = '${dateString}T00:00:00Z';
        bodyData['licenseValid'] = isoDateTime;
      }
      if (levelController.text.trim().isNotEmpty) {
        bodyData['level'] = levelController.text.trim();
      }
      if (aboutMeController.text.trim().isNotEmpty) {
        bodyData['aboutMe'] = aboutMeController.text.trim();
      }
      if (phoneController.text.trim().isNotEmpty) {
        bodyData['phone'] = phoneController.text.trim();
      }
      if (availabilityController.text.trim().isNotEmpty) {
        bodyData['availability'] = availabilityController.text.trim();
      }

      final jsonData = jsonEncode(bodyData);
      formData.fields.add(MapEntry('bodyData', jsonData));
      print('✅ Added bodyData: $jsonData');

      print('📤 Sending request to /referee...');

      // Call API
      final response = await _apiService.post(path: '/referee', data: formData);

      if (response != null) {
        Get.snackbar(
          'Success',
          'About Me updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        // Refresh profile data
        await profileController.loadProfileData();
        _loadProfileData();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save About Me: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      print('❌ Error saving About Me: $e');
    } finally {
      aboutMeSaving.value = false;
      print('========================');
    }
  }

  // Save Contact Info Section
  Future<void> saveContactInfo() async {
    contactInfoSaving.value = true;
    print('=== Saving Contact Info ===');

    try {
      final profile = profileController.profile.value;

      // Detect what has changed
      final changedData = <String, dynamic>{};

      // Check if Phone changed (email is read-only)
      if (profile != null && phoneController.text != profile.phone) {
        changedData['phone'] = phoneController.text.trim();
        print('✅ Phone changed: ${phoneController.text}');
      }

      // Check if Availability changed
      if (profile != null && availabilityController.text != profile.available) {
        changedData['availability'] = availabilityController.text.trim();
        print('✅ Availability changed: ${availabilityController.text}');
      }

      // If nothing changed, show warning
      if (changedData.isEmpty) {
        Get.snackbar(
          'No Changes',
          'No fields were modified',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        contactInfoSaving.value = false;
        return;
      }

      // Build FormData
      final formData = FormData();

      // Build bodyData - only send fields with actual values
      final bodyData = <String, dynamic>{};

      if (bioController.text.trim().isNotEmpty) {
        bodyData['bio'] = bioController.text.trim();
      }
      if (locationController.text.trim().isNotEmpty) {
        bodyData['location'] = locationController.text.trim();
      }
      if (experienceController.text.trim().isNotEmpty) {
        bodyData['experience'] = int.tryParse(experienceController.text) ?? 0;
      }
      if (licenseIdController.text.trim().isNotEmpty) {
        bodyData['licenseId'] = licenseIdController.text.trim();
      }
      if (certifyingAuthorityController.text.trim().isNotEmpty) {
        bodyData['certifyingAuthority'] = certifyingAuthorityController.text
            .trim();
      }
      if (licenseValidTillController.text.trim().isNotEmpty) {
        final dateString = licenseValidTillController.text.trim();
        final isoDateTime = '${dateString}T00:00:00Z';
        bodyData['licenseValid'] = isoDateTime;
      }
      if (levelController.text.trim().isNotEmpty) {
        bodyData['level'] = levelController.text.trim();
      }
      if (aboutMeController.text.trim().isNotEmpty) {
        bodyData['aboutMe'] = aboutMeController.text.trim();
      }
      if (phoneController.text.trim().isNotEmpty) {
        bodyData['phone'] = phoneController.text.trim();
      }
      if (availabilityController.text.trim().isNotEmpty) {
        bodyData['availability'] = availabilityController.text.trim();
      }

      final jsonData = jsonEncode(bodyData);
      formData.fields.add(MapEntry('bodyData', jsonData));
      print('✅ Added bodyData: $jsonData');

      print('📤 Sending request to /referee...');

      // Call API
      final response = await _apiService.post(path: '/referee', data: formData);

      if (response != null) {
        Get.snackbar(
          'Success',
          'Contact Info updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        // Refresh profile data
        await profileController.loadProfileData();
        _loadProfileData();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save Contact Info: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      print('❌ Error saving Contact Info: $e');
    } finally {
      contactInfoSaving.value = false;
      print('========================');
    }
  }

  // Handle profile image load error - reset to show fallback
  void handleProfileImageLoadError() {
    profileImageLoadError.value = true;
    print('⚠️  Failed to load profile image from URL');
  }
}
