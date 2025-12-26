import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/reset_pass_controller.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  late ResetPassController controller;
  bool _timerStarted = false;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ResetPassController>();

    // Start timer only once
    if (!_timerStarted) {
      controller.startOtpTimer();
      _timerStarted = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Center(
                child: Container(
                  width: 180.w,
                  height: 180.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Image.asset(
                    'assets/brand/signup.png',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.sports_soccer, size: 120);
                    },
                  ),
                ),
              ),
              SizedBox(height: 40.h),

              // Title
              Center(
                child: Text(
                  'Enter 4-digit\nVerification code',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    height: 1.3,
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Subtitle with Timer
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      Text(
                        'Please enter the 4-digit verification code sent to your email. This code will expired in',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF6B7280),
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Obx(() {
                        // If timer is still running, show countdown
                        if (controller.remainingSeconds.value > 0) {
                          return Text(
                            controller.formatTime(
                              controller.remainingSeconds.value,
                            ),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFFBBF24),
                            ),
                          );
                        }
                        // If timer reached 0, show reset button with loading indicator
                        return controller.isLoading.value
                            ? SizedBox(
                                width: 36.w,
                                height: 36.h,
                                child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xFF2E4F9E),
                                  ),
                                  strokeWidth: 2.5,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  controller.resetOtpTimer();
                                },
                                icon: Icon(
                                  Icons.refresh,
                                  size: 24.sp,
                                  color: const Color(0xFF2E4F9E),
                                ),
                              );
                      }),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40.h),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    width: 60.w,
                    height: 60.h,
                    child: TextField(
                      controller: controller.otpControllers[index],
                      focusNode: controller.otpFocusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                            color: Color(0xFFE5E7EB),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                            color: Color(0xFF1E3A8A),
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) {
                        controller.onOtpCodeChanged(index, value);
                      },
                      onTap: () {
                        if (controller.otpControllers[index].text.isNotEmpty) {
                          controller
                              .otpControllers[index]
                              .selection = TextSelection(
                            baseOffset: 0,
                            extentOffset:
                                controller.otpControllers[index].text.length,
                          );
                        }
                      },
                    ),
                  );
                }),
              ),
              SizedBox(height: 8.h),

              // OTP Error Message
              Obx(
                () => controller.otpError.value.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.only(left: 16.w, bottom: 24.h),
                        child: Text(
                          controller.otpError.value,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.red,
                          ),
                        ),
                      )
                    : SizedBox(height: 40.h),
              ),

              // Enter OTP Button
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            controller.verifyOtp();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E4F9E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.r),
                      ),
                      elevation: 0,
                    ),
                    child: controller.isLoading.value
                        ? SizedBox(
                            width: 24.w,
                            height: 24.h,
                            child: const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                              strokeWidth: 2.5,
                            ),
                          )
                        : Text(
                            'Enter OTP',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timerStarted = false;
    super.dispose();
  }
}
