import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

enum Plan { yearly, monthly }

class SubscribetionController extends GetxController {
  final pageController = PageController(initialPage: 5000, viewportFraction: 0.76);
  final currentPage = 0.0.obs;
  final selectedPlan = Plan.yearly.obs;

  final images = <String>[
    'assets/images/onb1.jpg',
    'assets/images/onb2.jpg',
    'assets/images/onb3.jpg',
  ];

  final yearlyPrice = 600.00;
  final monthlyPrice = 90.00;

  Timer? _autoScrollTimer;

  @override
  void onInit() {
    super.onInit();

    // update current page listener
    pageController.addListener(() {
      currentPage.value = pageController.page ?? 0;
    });

    // start auto scroll
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!pageController.hasClients) return;

      final nextPage = (pageController.page?.toInt() ?? 0) + 1;
      pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

  int getRealIndex(int index) => index % images.length;

  void selectPlan(Plan plan) => selectedPlan.value = plan;

  void onPurchase() {
    Get.toNamed('/referee-home');
    final planName =
        selectedPlan.value == Plan.yearly ? 'Yearly Access' : 'Monthly Access';
    Get.snackbar('Purchase', 'Proceeding with $planName',
        snackPosition: SnackPosition.TOP);
  }

  @override
  void onClose() {
    _autoScrollTimer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}
