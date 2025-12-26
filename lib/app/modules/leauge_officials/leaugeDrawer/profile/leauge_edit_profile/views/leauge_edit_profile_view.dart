// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/widgets/app_bar_widgets.dart';
import 'package:kaldmv/app/widgets/file_picker_widget.dart';
import 'package:kaldmv/core/constants/app_colors.dart';
import 'package:kaldmv/core/utils/utils.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../controllers/leauge_edit_profile_controller.dart';

class LeaugeEditProfileView extends GetView<LeaugeEditProfileController> {
  const LeaugeEditProfileView({super.key});

  static const _horizontalPadding = 18.0;
  static const _sectionSpacing = 24.0;
  static const _fieldSpacing = 12.0;
  static const _avatarSize = 144.0;
  static const _avatarPadding = 20.0;
  static const _editButtonSize = 28.0;
  static const _editButtonPosition = 10.0;
  static const _iconSize = 16.0;
  static const _borderColor = Color(0xFF61758A);
  static const _shadowBlur = 8.0;
  static const _shadowSpread = 2.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Edit Profile'),
      body: Obx(() => Skeletonizer(
        enabled: controller.isDataLoading.value,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _horizontalPadding.w),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: _sectionSpacing.h),
                  _buildProfileAvatar(),
                  SizedBox(height: _sectionSpacing.h),
                  _buildBasicInfoSection(),
                  SizedBox(height: _sectionSpacing.h),
                  _buildLeagueCredentialsSection(),
                  SizedBox(height: _sectionSpacing.h),
                  _buildOfficialRepresentativeSection(),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  // ------------------------------
  // PROFILE AVATAR
  // ------------------------------
  Widget _buildProfileAvatar() {
    return Center(
      child: Stack(
        children: [
          Obx(() => Container(
            height: _avatarSize.h,
            width: _avatarSize.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFF4F4F4),
            ),
            child: controller.profileImage.value != null
                ? ClipOval(
              child: Image.file(
                controller.profileImage.value!,
                fit: BoxFit.cover,
                width: _avatarSize.w,
                height: _avatarSize.h,
              ),
            )
                : Padding(
              padding: EdgeInsets.all(_avatarPadding.w),
              child: Image.asset(
                'assets/images/laliga.png',
                fit: BoxFit.contain,
              ),
            ),
          )),
          _buildEditAvatarButton(),
        ],
      ),
    );
  }

  Widget _buildEditAvatarButton() {
    return Positioned(
      bottom: _editButtonPosition.h,
      right: _editButtonPosition.w,
      child: Container(
        height: _editButtonSize.h,
        width: _editButtonSize.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: _shadowBlur,
              spreadRadius: _shadowSpread,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => controller.pickProfileImage(),
            customBorder: const CircleBorder(),
            child: Icon(
              Icons.camera_alt_outlined,
              color: AppColors.primary,
              size: _iconSize.sp,
            ),
          ),
        ),
      ),
    );
  }

  // ------------------------------
  // BASIC INFO SECTION
  // ------------------------------
  Widget _buildBasicInfoSection() {
    return _buildSection(
      title: 'Basic Info',
      children: [
        _buildTextFieldWithController(
          controller: controller.leagueNameController,
          title: 'League Name',
          hintText: 'Enter League Name',
        ),
        _buildTextFieldWithController(
          controller: controller.statusController,
          title: 'Status',
          hintText: 'Professional League',
        ),
        _buildTextFieldWithController(
          controller: controller.foundedController,
          title: 'Founded',
          hintText: '1978',
        ),
        _buildActionButtons(onSave: () => controller.updateBasicInfo()),
      ],
    );
  }

  // ------------------------------
  // LEAGUE CREDENTIALS SECTION
  // ------------------------------
  Widget _buildLeagueCredentialsSection() {
    return _buildSection(
      title: 'League Credentials',
      children: [
        _buildTextFieldWithController(
          controller: controller.organizationIdController,
          title: 'Organization ID',
          hintText: '#LLA-2025',
        ),
        _buildTextFieldWithController(
          controller: controller.countryController,
          title: 'Country',
          hintText: 'Bangla',
        ),
        _buildTextFieldWithController(
          controller: controller.certifyingAuthorityController,
          title: 'Certifying Authority',
          hintText: 'Spain',
        ),
        _buildTextFieldWithController(
          controller: controller.licenseValidController,
          title: 'License Valid Till',
          hintText: '2029-10-17',
        ),
        _buildTextFieldWithController(
          controller: controller.levelController,
          title: 'Level',
          hintText: 'NATIONAL_LEVEL',
        ),
        _buildActionButtons(onSave: () => controller.updateLeagueCredentials()),
      ],
    );
  }

  // ------------------------------
  // OFFICIAL REPRESENTATIVE SECTION
  // ------------------------------
  Widget _buildOfficialRepresentativeSection() {
    return _buildSection(
      title: 'Official Representative',
      children: [
        _buildTextFieldWithController(
          controller: controller.fullNameController,
          title: 'Full Name',
          hintText: 'Javier Tebas',
        ),
        _buildTextFieldWithController(
          controller: controller.designationController,
          title: 'Designation',
          hintText: 'President of La-Liga',
        ),
        _buildTextFieldWithController(
          controller: controller.contactNumberController,
          title: 'Contact Number',
          hintText: '+88015247',
        ),
        _buildTextFieldWithController(
          controller: controller.emailController,
          title: 'Email',
          hintText: 'tebas@gmail.com',
        ),
        SizedBox(height: _fieldSpacing.h),

        FilePickerWidget(
          subTitle: 'Upload Official Photo',
          onTap: () => controller.pickOfficialRepImage(),
        ),

        Obx(() => controller.officialRepImage.value != null
            ? Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Text(
            '✓ Image Added',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
            : SizedBox.shrink()),

        _buildActionButtons(onSave: () => controller.updateOfficialRepresentative()),
      ],
    );
  }

  // ------------------------------
  // REUSABLE SECTION WRAPPER
  // ------------------------------
  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        SizedBox(height: _fieldSpacing.h),
        ...children
            .expand((child) => [child, SizedBox(height: _fieldSpacing.h)])
            .toList()
          ..removeLast(),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20.sp,
        color: AppColors.primary,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // ------------------------------
  // TEXT FIELD
  // ------------------------------
  // Widget _buildTextField(String title, String hintText) {
  //   return Utils.customTextField(
  //     context: Get.context!,
  //     tfontsize: 14.sp,
  //     shight: 8.h,
  //     title: title,
  //     textColor: AppColors.black,
  //     hintText: hintText,
  //     hintFontSize: 16.sp,
  //   );
  // }

  Widget _buildTextFieldWithController({
    required TextEditingController controller,
    required String title,
    required String hintText,
  }) {
    return Utils.customTextField(
      context: Get.context!,
      controller: controller,
      tfontsize: 14.sp,
      shight: 8.h,
      title: title,
      textColor: AppColors.black,
      hintText: hintText,
      hintFontSize: 16.sp,
    );
  }

  // ------------------------------
  // ACTION BUTTONS
  // ------------------------------
  Widget _buildActionButtons({VoidCallback? onSave}) {
    return Obx(() => Row(
      children: [
        Expanded(
          child: Utils.primaryButton(
            context: Get.context!,
            onTap: controller.isLoading.value ? null : () => controller.cancelEdit(),
            borderColor: _borderColor,
            backgroundColor: AppColors.white,
            title: 'Cancel',
            textColor: _borderColor,
          ),
        ),
        SizedBox(width: _fieldSpacing.w),
        Expanded(
          child: Utils.primaryButton(
            context: Get.context!,
            borderColor: null,
            backgroundColor: AppColors.secondary,
            onTap: controller.isLoading.value ? null : onSave,
            title: controller.isLoading.value ? 'Saving...' : 'Save Changes',
          ),
        ),
      ],
    ));
  }
}
