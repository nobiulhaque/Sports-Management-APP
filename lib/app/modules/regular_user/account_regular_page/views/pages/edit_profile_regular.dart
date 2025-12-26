// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/leauge_officials/widgets/custom_app_bar.dart';
import 'package:kaldmv/app/modules/regular_user/account_regular_page/controllers/account_regular_page_controller.dart';
import 'package:kaldmv/core/constants/app_colors.dart';
import 'package:kaldmv/core/utils/utils.dart';

class EditProfileRegular extends StatefulWidget {
  const EditProfileRegular({super.key});

  @override
  State<EditProfileRegular> createState() => _EditProfileRegularState();
}

class _EditProfileRegularState extends State<EditProfileRegular> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.find<AccountRegularPageController>();

  late TextEditingController _nameController;
  late TextEditingController _userTypeController;
  late TextEditingController _addressController;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    final profile = controller.userProfile.value;
    _nameController = TextEditingController(text: profile?.name ?? '');
    _userTypeController = TextEditingController(text: profile?.userType ?? '');
    _addressController = TextEditingController(
      text: profile?.userAddress ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _userTypeController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _handleImagePick() async {
    final image = await controller.pickImage();
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  void _handleSave() {
    if (_formKey.currentState?.validate() ?? false) {
      final profile = controller.userProfile.value;

      String? name;
      if (_nameController.text != (profile?.name ?? '')) {
        name = _nameController.text;
      }

      String? userAddress;
      if (_addressController.text != (profile?.userAddress ?? '')) {
        userAddress = _addressController.text;
      }

      String? userType;
      if (_userTypeController.text != (profile?.userType ?? '')) {
        userType = _userTypeController.text;
      }

      // Only call update if something actually changed
      if (name != null ||
          userAddress != null ||
          userType != null ||
          _selectedImage != null) {
        controller.updateProfile(
          name: name,
          userType: userType,
          userAddress: userAddress,
          imageFile: _selectedImage,
        );
      } else {
        Get.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarLeauge(title: 'Edit Profile'),
      body: Obx(() {
        return Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Avatar Section
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          GestureDetector(
                            onTap: _handleImagePick,
                            child: CircleAvatar(
                              radius: 60.r,
                              backgroundColor: const Color(0xFFE8EEFE),
                              backgroundImage: _selectedImage != null
                                  ? FileImage(_selectedImage!) as ImageProvider
                                  : (controller.userProfile.value?.image !=
                                                null &&
                                            controller.userProfile.value!.image!
                                                .startsWith('http')
                                        ? NetworkImage(
                                            controller
                                                .userProfile
                                                .value!
                                                .image!,
                                          )
                                        : const AssetImage(
                                                'assets/images/u3.png',
                                              )
                                              as ImageProvider),
                            ),
                          ),
                          GestureDetector(
                            onTap: _handleImagePick,
                            child: Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(8.w),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 20.r,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.h),

                    // Basic Info Header
                    Text(
                      'Basic Info',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1F4FA8),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Name Field
                    _buildFieldLabel('Name'),
                    SizedBox(height: 8.h),
                    Utils.customTextField(
                      context: context,
                      controller: _nameController,
                      hintText: 'Enter name',
                      hintFontSize: 16.sp,
                      tfontsize: 16.sp,
                      radius: 16.r,
                    ),
                    SizedBox(height: 20.h),

                    // User Type Field
                    _buildFieldLabel('User Type'),
                    SizedBox(height: 8.h),
                    Utils.customTextField(
                      context: context,
                      controller: _userTypeController,
                      hintText: 'Enter user type',
                      hintFontSize: 16.sp,
                      tfontsize: 16.sp,
                      radius: 16.r,
                    ),
                    SizedBox(height: 20.h),

                    // Address Field
                    _buildFieldLabel('Address'),
                    SizedBox(height: 8.h),
                    Utils.customTextField(
                      context: context,
                      controller: _addressController,
                      hintText: 'Enter address',
                      hintFontSize: 16.sp,
                      tfontsize: 16.sp,
                      radius: 16.r,
                    ),
                    SizedBox(height: 30.h),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: Utils.primaryButton(
                            context: context,
                            title: 'Cancel',
                            backgroundColor: Colors.transparent,
                            textColor: const Color(0xFF61758A),
                            borderColor: const Color(0xFF61758A),
                            radius: 4.r,
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Utils.primaryButton(
                            context: context,
                            backgroundColor: AppColors.accentGreen,
                            textColor: AppColors.white,
                            radius: 4.r,
                            title: 'Save',
                            onTap: _handleSave,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
            if (controller.isUpdating.value)
              Container(
                color: Colors.black26,
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        );
      }),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }
}
