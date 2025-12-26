import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../../core/services/api_service.dart';
import '../../../../routes/app_pages.dart';


class SplashController extends GetxController {
  final box = GetStorage();
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;


  @override
  void onInit() {
    debugPrint("working");
    _startSplashTimer();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _startSplashTimer();
  }

  void _startSplashTimer() {
    print('Starting splash timer...'); // Debug print
    Future.delayed(const Duration(seconds: 3), () {
      print('Timer completed, checking navigation...'); // Debug print
      _checkFirstTime();
    });
  }

  void _checkFirstTime() async {
    try {
      // Check if this is the first time opening the app
      final bool hasSeenOnboarding = box.read('hasSeenOnboarding') ?? false;
      
      print('Has seen onboarding: $hasSeenOnboarding'); // Debug print
      
      if (!hasSeenOnboarding) {
        print('Navigating to onboarding: ${Routes.ONBOARDING}'); // Debug print
        Get.offAllNamed(Routes.ONBOARDING);
        return;
      }
      
      // Check for auto-login
      final bool isLoggedIn = box.read('is_logged_in') ?? false;
      final String? token = box.read('user_token');
      final String? role = box.read('user_role');
      
      print('Auto-login check: isLoggedIn=$isLoggedIn, role=$role'); // Debug print
      
      if (isLoggedIn && token != null && role != null) {
        // User is logged in, navigate to appropriate home screen
        await ApiService().saveToken(token);
        
        print('Navigating based on role: $role'); // Debug print
        
        if (role == "LEAGUE_OFFICIALS") {
          Get.offAllNamed('/home-leauge');
        } else if (role == "MAIN_REFEREE" ||
            role == "ASS_REFEREE1" ||
            role == "ASS_REFEREE2" ||
            role == "FOURTH_REFEREE") {
          Get.offAllNamed('/referee-home');
        } else if (role == "USER") {
          Get.offAllNamed('/home-regular-user');
        } else {
          // Unknown role, go to auth
          Get.offAllNamed(Routes.AUTH);
        }
      } else {
        print('Not logged in, navigating to auth: ${Routes.AUTH}'); // Debug print
        Get.offAllNamed(Routes.AUTH);
      }
    } catch (e) {
      print('Error during navigation: $e'); // Debug print
      // Fallback navigation to auth
      Get.offAllNamed(Routes.AUTH);
    }
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding();
    }
  }

  void skipOnboarding() {
    completeOnboarding();
  }

  void completeOnboarding() {
    box.write('hasSeenOnboarding', true);
    // Navigate to auth page instead of home
    Get.offAllNamed(Routes.AUTH);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
