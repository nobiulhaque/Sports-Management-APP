import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/splash_controller.dart';

class OnboardingView extends GetView<SplashController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                children: const [
                  OnboardingPage(
                    imagePath: 'assets/images/onb1.jpg',
                    title: 'Empower Every',
                    highlightedText: 'Referee',
                    description:
                        'Track performance, gain insights, and celebrate excellence with transparent ratings and reviews.',
                  ),
                  OnboardingPage(
                    imagePath: 'assets/images/onb2.jpg',
                    title: 'Sync Every',
                    highlightedText: 'Match',
                    description:
                        'Connect leagues, referees and match officials in real time for seamless communication and coordination.',
                  ),
                  OnboardingPage(
                    imagePath: 'assets/images/onb3.jpg',
                    title: 'Welcome to',
                    highlightedText: 'Fairplay FC',
                    description:
                        'Track performance, gain insights, and celebrate excellence with transparent ratings and reviews.',
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: Column(
                  children: [
                    // Page Indicators
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            3,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              width: index == controller.currentPage.value
                                  ? 32.w
                                  : 8.w,
                              height: 8.h,
                              decoration: BoxDecoration(
                                color: index == controller.currentPage.value
                                    ? const Color(0xFF1E3A8A)
                                    : const Color(0xFFD1D5DB),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 24.h),
                    // Buttons
                    Obx(() {
                      final isLastPage = controller.currentPage.value == 2;
                      return Row(
                        children: [
                          if (!isLastPage)
                            SizedBox(
                              width: 79.w,
                              height: 48.h,
                              child: TextButton(
                                onPressed: controller.skipOnboarding,
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                child: Text(
                                  'Skip',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1F2937),
                                  ),
                                ),
                              ),
                            ),
                          if (!isLastPage) SizedBox(width: 16.w),
                          Expanded(
                            child: SizedBox(
                              height: 48.h,
                              child: ElevatedButton(
                                onPressed: controller.nextPage,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1E3A8A),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  isLastPage ? "Let's get started" : 'Next',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String highlightedText;
  final String description;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.highlightedText,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Full width image that goes behind status bar
        Expanded(
          flex: 3,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(21),
              bottomRight: Radius.circular(21),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFF3F4F6),
                    child: Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 80.sp,
                        color: const Color(0xFFD1D5DB),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        // Content section
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 32.h),
                // Title with highlighted text
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 20.sp, // Title size as requested
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111827),
                      height: 1.2,
                      letterSpacing: -0.5,
                    ),
                    children: [
                      TextSpan(text: '$title '),
                      TextSpan(
                        text: highlightedText,
                        style: const TextStyle(
                          color: Color(0xFF10B981),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                // Description
                Text(
                  description,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16.sp, // Subtitle size as requested
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF6B7280),
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
