import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/widgets/app_bar_widgets.dart';
import 'package:kaldmv/app/widgets/custom_button_2.dart';
import 'package:kaldmv/app/widgets/custom_password_field.dart';
import '../controllers/changepassword_controller.dart';

class ChangepasswordView extends GetView<ChangepasswordController> {
  const ChangepasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Change Password'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomPasswordField(
                label: 'Enter Current Password',
                controller: controller.currentPasswordController,
              ),
              Obx(
                () => controller.currentPasswordError.value.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8, left: 4),
                        child: Text(
                          controller.currentPasswordError.value,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(height: 20),
              CustomPasswordField(
                label: 'Enter New Password',
                controller: controller.newPasswordController,
              ),
              Obx(
                () => controller.newPasswordError.value.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8, left: 4),
                        child: Text(
                          controller.newPasswordError.value,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(height: 20),
              CustomPasswordField(
                label: 'Confirm Password',
                controller: controller.confirmPasswordController,
              ),
              Obx(
                () => controller.confirmPasswordError.value.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8, left: 4),
                        child: Text(
                          controller.confirmPasswordError.value,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              const Spacer(),
              Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomButton2(
                        text: 'Reset Password',
                        onPressed: controller.resetPassword,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
