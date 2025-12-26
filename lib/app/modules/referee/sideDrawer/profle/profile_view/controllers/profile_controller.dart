import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kaldmv/app/data/models/profile_model.dart';
import 'package:kaldmv/app/data/service/profile_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileController extends GetxController {
  ProfileController(this._service);

  final ProfileService _service;

  // State
  final isLoading = true.obs;
  final profile = Rxn<Profile>();
  final count = 0.obs; // example counter if needed

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  // Technical: data loading
  Future<void> loadProfileData() async {
    try {
      isLoading.value = true;
      final result = await _service.fetchProfile();
      profile.value = result;
      print("✅ Profile loaded: ${result.name}");
    } catch (e) {
      print("❌ Error loading profile: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Logical updates
  void updateProfileData(Profile newData) {
    profile.value = newData;
  }

  void setAvailability(String available) {
    final p = profile.value;
    if (p != null) {
      profile.value = p.copyWith(available: available);
    }
  }

  void increment() => count.value++;

  // Navigation/Actions
  Future<void> navigateToEditProfile() async {
    final p = profile.value;
    final updated = await Get.toNamed('/edit-profile', arguments: p?.toJson());
    if (updated is Profile) {
      profile.value = updated;
    }
  }

  void viewCertificate() {
    final certUrl = profile.value?.certificateUrl;
    print("🔍 Certificate URL: $certUrl");

    if (certUrl == null || certUrl.isEmpty || certUrl == 'N/A') {
      Get.snackbar(
        'No Certificate',
        'Certificate is not available',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Detect file type
    final fileExtension = _getFileExtension(certUrl).toLowerCase();
    final isImage = [
      'png',
      'jpg',
      'jpeg',
      'gif',
      'webp',
    ].contains(fileExtension);
    final isPdf = fileExtension == 'pdf';

    if (isPdf) {
      // For PDFs, open in system viewer
      _openPdfInViewer(certUrl);
    } else if (isImage) {
      // For images, show in popup
      _showImagePopup(certUrl);
    } else {
      // For other files, open with default app
      _openFileWithDefaultApp(certUrl);
    }
  }

  String _getFileExtension(String url) {
    final uri = Uri.parse(url);
    final path = uri.path;
    final lastDot = path.lastIndexOf('.');
    if (lastDot == -1) return '';
    return path.substring(lastDot + 1);
  }

  Future<void> _openPdfInViewer(String pdfUrl) async {
    try {
      if (await canLaunchUrl(Uri.parse(pdfUrl))) {
        await launchUrl(
          Uri.parse(pdfUrl),
          mode: LaunchMode.externalApplication,
        );
      } else {
        Get.snackbar(
          'Error',
          'Cannot open PDF file',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print("❌ Error opening PDF: $e");
      Get.snackbar(
        'Error',
        'Failed to open PDF: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _openFileWithDefaultApp(String fileUrl) async {
    try {
      if (await canLaunchUrl(Uri.parse(fileUrl))) {
        await launchUrl(
          Uri.parse(fileUrl),
          mode: LaunchMode.externalApplication,
        );
      } else {
        Get.snackbar(
          'Error',
          'Cannot open file',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print("❌ Error opening file: $e");
      Get.snackbar(
        'Error',
        'Failed to open file: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _showImagePopup(String imageUrl) {
    // Show popup dialog with certificate image
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Dismiss on background tap
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(color: Colors.transparent),
              ),
            ),
            // Certificate image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  width: MediaQuery.of(Get.context!).size.width * 0.9,
                  height: MediaQuery.of(Get.context!).size.height * 0.7,
                  errorBuilder: (context, error, stackTrace) {
                    print("❌ Error loading image: $error");
                    print("📍 StackTrace: $stackTrace");
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.error, color: Colors.red, size: 48),
                          const SizedBox(height: 16),
                          const Text(
                            'Failed to load image',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'URL: $imageUrl',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
            // Close button
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.close, color: Colors.black, size: 24),
                ),
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: true,
    );
  }

  // Computed / formatted getters (presentation logic centralized here)
  String get ratingText {
    final r = profile.value?.rating;
    return r == null ? '' : '${r.toStringAsFixed(1)}/5';
  }

  String get experienceText {
    final y = profile.value?.experienceYears ?? 0;
    return '$y Years Experience';
  }

  String get progressionPercent {
    final p = profile.value?.progression ?? 0.0;
    return '${(p * 100).toStringAsFixed(0)}%';
  }

  double get progressionValue => profile.value?.progression ?? 0.0;

  String formatDate(DateTime date) => DateFormat('MMM dd, yyyy').format(date);
}
