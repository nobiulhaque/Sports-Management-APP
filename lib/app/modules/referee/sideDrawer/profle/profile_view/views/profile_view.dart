import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/referee/sideDrawer/profle/profile_view/controllers/profile_controller.dart';
import 'package:kaldmv/app/widgets/custom_back_button.dart';
import 'package:kaldmv/app/widgets/custom_profile_card.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          final p = controller.profile.value;
          if (p == null) {
            return Center(
              child: Text('No profile data', style: TextStyle(fontSize: 16.sp)),
            );
          }

          return Column(
            children: [
              // Header Row
              Row(
                children: [
                  const CustomBackButton(),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 27.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              SizedBox(height: 15.h),

              // Scrollable Content
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => controller.loadProfileData(),
                  color: const Color(0xFF183A83),
                  backgroundColor: Colors.white,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Card
                        CustomProfileCard(
                          elevation: 2,
                          color: const Color.fromARGB(255, 24, 58, 131),
                          borderRadius: 20,
                          child: Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10.h),
                                Center(
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      p.avatarUrl.isNotEmpty
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(45.r),
                                              child: Image.network(
                                                p.avatarUrl,
                                                width: 90.r,
                                                height: 90.r,
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) {
                                                      print(
                                                        '❌ Error loading profile image: $error',
                                                      );
                                                      return Container(
                                                        width: 90.r,
                                                        height: 90.r,
                                                        decoration:
                                                            BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Colors
                                                                  .grey
                                                                  .shade300,
                                                            ),
                                                        child: Icon(
                                                          Icons.person,
                                                          size: 50.r,
                                                          color: Colors
                                                              .grey
                                                              .shade600,
                                                        ),
                                                      );
                                                    },
                                                loadingBuilder: (context, child, loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return Container(
                                                    width: 90.r,
                                                    height: 90.r,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          Colors.grey.shade300,
                                                    ),
                                                    child: Center(
                                                      child: SizedBox(
                                                        width: 30.r,
                                                        height: 30.r,
                                                        child: CircularProgressIndicator(
                                                          value:
                                                              loadingProgress
                                                                      .expectedTotalBytes !=
                                                                  null
                                                              ? loadingProgress
                                                                        .cumulativeBytesLoaded /
                                                                    loadingProgress
                                                                        .expectedTotalBytes!
                                                              : null,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          : Container(
                                              width: 90.r,
                                              height: 90.r,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey.shade300,
                                              ),
                                              child: Icon(
                                                Icons.person,
                                                size: 50.r,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                      if (p.hasCertificate)
                                        Container(
                                          padding: EdgeInsets.all(4.w),
                                          decoration: const BoxDecoration(
                                            color: Colors.amber,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.workspace_premium_outlined,
                                            size: 16.r,
                                            color: Colors.white,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Center(
                                  child: Text(
                                    p.name,
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                if (p.hasCertificate)
                                  Center(
                                    child: Text(
                                      'Certified Match Referee',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                if (p.location.isNotEmpty)
                                  SizedBox(height: 5.h),
                                if (p.location.isNotEmpty)
                                  Center(
                                    child: Text(
                                      p.location,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ),
                                if (p.experienceYears > 0)
                                  SizedBox(height: 5.h),
                                if (p.experienceYears > 0)
                                  Center(
                                    child: Text(
                                      controller.experienceText,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        // Total Matches & Edit Profile
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: Colors.green.shade100.withAlpha(90),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.sports_soccer,
                                      color: Colors.green.shade700,
                                      size: 20.sp,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'Total Matches: ',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '${p.matches}',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              height: 50.h,
                              child: ElevatedButton(
                                onPressed: controller.navigateToEditProfile,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF183A83),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  padding: EdgeInsets.zero,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.file_copy_outlined,
                                      color: Colors.white,
                                      size: 18.sp,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'Edit Profile',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20.h),

                        // Referee Credentials
                        _buildSectionHeader(
                          'Referee Credentials',
                          icon: Icons.person_pin,
                          iconColor: const Color(0xFF183A83),
                        ),
                        SizedBox(height: 10.h),

                        _buildCredentialField('License ID', p.licenseId),
                        _buildCredentialField(
                          'Certifying Authority',
                          p.certifyingAuthority,
                        ),
                        _buildCredentialField(
                          'Date of Issue',
                          controller.formatDate(p.issueDate),
                        ),
                        _buildCredentialField(
                          'License Valid Till',
                          controller.formatDate(p.validTill),
                        ),
                        _buildCredentialField('Level', p.level, hasBadge: true),

                        SizedBox(height: 15.h),

                        // View Certificate
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(15.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Certificate Document',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.description,
                                    color: Color(0xFF183A83),
                                    size: 20,
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Text(
                                      p.certFileName.isEmpty
                                          ? 'N/A'
                                          : p.certFileName,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: p.certFileName.isEmpty
                                            ? Colors.grey
                                            : Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: controller.viewCertificate,
                                  icon: const Icon(
                                    Icons.visibility,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    'View Certificate',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF183A83),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 8.h,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),

                        // About Me
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Column(
                            children: [
                              _buildSectionCard(
                                icon: Icons.description,
                                title: 'About Me',
                                content: Text(
                                  p.about.isEmpty ? 'N/A' : p.about,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: p.about.isEmpty
                                        ? Colors.grey
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),

                        // Contact Information
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                _buildSectionHeader(
                                  'Contact Information',
                                  icon: Icons.phone,
                                  iconColor: Colors.green.shade700,
                                ),
                                SizedBox(height: 10.h),
                                _buildContactDetail(
                                  icon: Icons.email,
                                  label: 'Email',
                                  value: p.email,
                                ),
                                SizedBox(height: 10.h),
                                _buildContactDetail(
                                  icon: Icons.phone,
                                  label: 'Phone',
                                  value: p.phone,
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(15.w),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade50,
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.schedule,
                                              color: Colors.green.shade700,
                                              size: 20.sp,
                                            ),
                                            SizedBox(width: 10.w),
                                            Text(
                                              'Availability',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                color: Colors.green.shade700,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          p.available,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.green.shade700,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 40.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  // --- Helper Widgets from your original view ---
  Widget _buildSectionHeader(
    String title, {
    required IconData icon,
    required Color iconColor,
  }) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 24.sp),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildCredentialField(
    String label,
    String value, {
    bool hasBadge = false,
  }) {
    final displayValue = value.isEmpty || value == 'N/A' ? 'N/A' : value;

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            ),
            SizedBox(height: 5.h),
            hasBadge
                ? Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF183A83),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      displayValue,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Text(
                    displayValue,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: displayValue == 'N/A' ? Colors.grey : Colors.black,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required Widget content,
  }) {
    return CustomProfileCard(
      elevation: 0,
      color: Colors.white,
      borderRadius: 12,
      child: Padding(
        padding: EdgeInsets.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color(0xFF183A83), size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 15, color: Colors.grey),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildContactDetail({
    required IconData icon,
    required String label,
    required String value,
  }) {
    final displayValue = value.isEmpty ? 'N/A' : value;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
          SizedBox(height: 5.h),
          Text(
            displayValue,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: displayValue == 'N/A' ? Colors.grey : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
