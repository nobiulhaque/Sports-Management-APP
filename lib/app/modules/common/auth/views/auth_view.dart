import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/common/auth/views/set_role_view.dart';
import 'package:kaldmv/core/constants/app_images.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Logo Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  Center(
                    child: SizedBox(
                      width: 180.w,
                      height: 180.h,
                      child: Image.asset(
                        AppImage.signUp,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Tab Section
            Expanded(
              child: Obx(
                    () => Column(
                  children: [
                    // Tab Bar
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
                        ),
                      ),
                      child: Row(
                        children: [
                          // Login Tab
                          Expanded(
                            child: GestureDetector(
                              onTap: () => controller.changeTab(0),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: controller.currentTab.value == 0
                                          ? const Color(0xFF1E3A8A)
                                          : Colors.transparent,
                                      width: 3,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Login",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: controller.currentTab.value == 0
                                        ? const Color(0xFF1E3A8A)
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Register Tab
                          Expanded(
                            child: GestureDetector(
                              onTap: () => controller.changeTab(1),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: controller.currentTab.value == 1
                                          ? const Color(0xFF1E3A8A)
                                          : Colors.transparent,
                                      width: 3,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Register",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: controller.currentTab.value == 1
                                        ? const Color(0xFF1E3A8A)
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Form Swap
                    Expanded(
                      child: controller.currentTab.value == 0
                          ? const LoginForm()
                          : const RegisterForm(),
                    ),
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

// --------------------------------------------------------------------------
// LOGIN FORM
// --------------------------------------------------------------------------

class LoginForm extends GetView<AuthController> {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: Form(
        key: controller.loginFormKey,
        child: Column(
          children: [
            // Email
            TextFormField(
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: controller.validateEmail,
              decoration: const InputDecoration(
                labelText: "Email",
                suffixIcon: Icon(Icons.email_outlined),
              ),
            ),
            SizedBox(height: 24.h),

            // Password
            Obx(
                  () => TextFormField(
                controller: controller.passwordController,
                obscureText: controller.isPasswordHidden.value,
                validator: controller.validatePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordHidden.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                ),
              ),
            ),

          SizedBox(height: 24.h),

          // Remember-Me + Forget Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(
                        () => GestureDetector(
                      onTap: controller.toggleRememberMe,
                      child: Container(
                        width: 24.w,
                        height: 24.h,
                        decoration: BoxDecoration(
                          color: controller.rememberMe.value
                              ? const Color(0xFF10B981)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(
                            color: controller.rememberMe.value
                                ? const Color(0xFF10B981)
                                : const Color(0xFFD1D5DB),
                          ),
                        ),
                        child: controller.rememberMe.value
                            ? Icon(Icons.check, color: Colors.white, size: 16.sp)
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text("Remember me"),
                ],
              ),
              TextButton(
                onPressed: () => Get.toNamed('/forgot-password'),
                child: const Text(
                  "Forget password?",
                  style: TextStyle(color: Color(0xFF10B981)),
                ),
              ),
            ],
          ),

          SizedBox(height: 32.h),

          // LOGIN BUTTON
          Obx(
                () => SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: controller.loading.value ? null : controller.login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E4F9E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.r),
                  ),
                ),
                child: controller.loading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                  "Login",
                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                ),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          // OR LOGIN WITH
          const Text("Or Login with"),
          SizedBox(height: 20.h),

          // Google
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SetRoleView()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/google.png", width: 24, height: 24),
                  SizedBox(width: 12.w),
                  const Text("Sign Up with Google"),
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


// --------------------------------------------------------------------------
// REGISTER FORM
// --------------------------------------------------------------------------

class RegisterForm extends GetView<AuthController> {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: Form(
        key: controller.registerFormKey,
        child: Column(
          children: [
            // Name
            TextFormField(
              controller: controller.nameController,
              validator: controller.validateName,
              decoration: const InputDecoration(
                labelText: "Name",
                suffixIcon: Icon(Icons.person_outline),
              ),
            ),
            SizedBox(height: 24.h),

            // Email
            TextFormField(
              controller: controller.registerEmailController,
              keyboardType: TextInputType.emailAddress,
              validator: controller.validateEmail,
              decoration: const InputDecoration(
                labelText: "Email",
                suffixIcon: Icon(Icons.email_outlined),
              ),
            ),
            SizedBox(height: 24.h),

            // Password
            Obx(
                  () => TextFormField(
                controller: controller.registerPasswordController,
                obscureText: controller.isRegisterPasswordHidden.value,
                validator: controller.validatePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isRegisterPasswordHidden.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: controller.toggleRegisterPasswordVisibility,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Confirm Password
            Obx(
                  () => TextFormField(
                controller: controller.confirmPasswordController,
                obscureText: controller.isConfirmPasswordHidden.value,
                validator: controller.validateConfirmPassword,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isConfirmPasswordHidden.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: controller.toggleConfirmPasswordVisibility,
                  ),
                ),
              ),
            ),
          SizedBox(height: 32.h),

          // REGISTER BUTTON
          Obx(
                () => SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: controller.loading.value ? null : controller.register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E4F9E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.r),
                  ),
                ),
                child: controller.loading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                  "Register",
                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                ),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          // OR REGISTER WITH
          const Text("Or Register with"),
          SizedBox(height: 20.h),

          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: OutlinedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/google.png", width: 24, height: 24),
                  SizedBox(width: 12.w),
                  const Text("Sign Up with Google"),
                ],
              ),
            ),
          ),

          SizedBox(height: 20.h),

          // Terms
          Obx(
                () => Row(
              children: [
                GestureDetector(
                  onTap: controller.toggleTerms,
                  child: Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: controller.acceptTerms.value
                          ? const Color(0xFF10B981)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(
                        color: controller.acceptTerms.value
                            ? const Color(0xFF10B981)
                            : const Color(0xFFD1D5DB),
                      ),
                    ),
                    child: controller.acceptTerms.value
                        ? Icon(Icons.check, color: Colors.white, size: 16.sp)
                        : null,
                  ),
                ),
                SizedBox(width: 8.w),
                const Expanded(
                  child: Text('By using "Ref Insights" you agree to our terms.'),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}