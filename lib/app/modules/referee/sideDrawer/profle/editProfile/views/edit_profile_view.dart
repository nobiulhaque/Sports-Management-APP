import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kaldmv/app/widgets/app_bar_widgets.dart'; // Assuming this is where CustomAppBar is
import '../controllers/edit_profile_controller.dart';

// Custom painter for dotted border
class DottedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double gapLength;
  final double borderRadius;

  DottedBorderPainter({
    required this.color,
    this.strokeWidth = 3.0,
    this.dashLength = 10.0,
    this.gapLength = 4.0,
    this.borderRadius = 10.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final radius = Radius.circular(borderRadius);
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      radius,
    );

    _drawDottedRRect(canvas, rrect, paint);
  }

  void _drawDottedRRect(Canvas canvas, RRect rrect, Paint paint) {
    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      for (
        double distance = 0;
        distance < metric.length;
        distance += dashLength + gapLength
      ) {
        final tangent = metric.getTangentForOffset(distance);
        if (tangent != null) {
          final segmentEnd = (distance + dashLength).clamp(0.0, metric.length);
          final nextTangent = metric.getTangentForOffset(segmentEnd);
          if (nextTangent != null) {
            canvas.drawLine(tangent.position, nextTangent.position, paint);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(DottedBorderPainter oldDelegate) => false;
}

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  // Custom Widget for the Text Field with Label
  Widget _buildLabeledTextField({
    required String label,
    String? initialValue,
    int maxLines = 1,
    String? hintText,
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E3A8A), // Deep Blue color for labels
              ),
            ),
          ),
        TextFormField(
          controller: controller,
          initialValue: controller == null ? initialValue : null,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFF10B981),
                width: 2.0,
              ), // Green for focus
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Custom Widget for the Action Buttons
  Widget _buildActionButtons({VoidCallback? onSave}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              // Handle Cancel
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: const BorderSide(color: Colors.grey),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              onSave?.call();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, // Green color
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Save Changes',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  // Custom Widget for the Profile Image
  Widget _buildProfileImage() {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Obx(
            () => CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade200,
              child: _buildProfileImageContent(),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => _showImagePickerOptions(),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add_a_photo,
                  size: 20,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper to build profile image content (local file or network image)
  Widget _buildProfileImageContent() {
    final imagePath = controller.profileImagePath.value;

    if (imagePath.isEmpty) {
      return const Icon(Icons.person, size: 60, color: Color(0xFF1E3A8A));
    }

    // Check if it's a local file (picked from camera/gallery)
    if (controller.profileImage != null) {
      return ClipOval(
        child: SizedBox(
          width: 100,
          height: 100,
          child: Image.file(
            controller.profileImage!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                controller.handleProfileImageLoadError();
              });
              return _buildPlaceholderAvatar();
            },
          ),
        ),
      );
    }

    // Check if it's a URL (from server)
    if (imagePath.startsWith('http')) {
      if (!controller.profileImageLoadError.value) {
        return ClipOval(
          child: SizedBox(
            width: 100,
            height: 100,
            child: CachedNetworkImage(
              imageUrl: imagePath,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.grey.shade400,
                  ),
                ),
              ),
              errorWidget: (context, url, error) {
                print('⚠️  Image load error: $error');
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  controller.handleProfileImageLoadError();
                });
                return _buildPlaceholderAvatar();
              },
            ),
          ),
        );
      }
      return _buildPlaceholderAvatar();
    }

    // Fallback to person icon
    return const Icon(Icons.person, size: 60, color: Color(0xFF1E3A8A));
  }

  // Fallback avatar widget
  Widget _buildPlaceholderAvatar() {
    return const Icon(Icons.person, size: 60, color: Color(0xFF1E3A8A));
  }

  // Show bottom sheet to pick image from camera or gallery
  void _showImagePickerOptions() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Profile Image',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () {
                  Get.back();
                  controller.pickProfileImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Get.back();
                  controller.pickProfileImage(ImageSource.gallery);
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // Custom Widget for the dashed upload area
  Widget _buildUploadCertificateArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload Certificate',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E3A8A),
          ),
        ),
        const SizedBox(height: 12),
        Obx(
          () => GestureDetector(
            onTap: () => controller.pickCertificateFile(),
            child: CustomPaint(
              painter: DottedBorderPainter(
                color: Colors.grey,
                strokeWidth: 3,
                dashLength: 17.0,
                gapLength: 4.0,
                borderRadius: 7.0,
              ),
              child: Container(
                height: 150.h,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFF2F5FF),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      controller.certificateFilePath.value.isEmpty
                          ? Icons.cloud_upload
                          : Icons.check_circle,
                      size: 60.r,
                      color: controller.certificateFilePath.value.isEmpty
                          ? Colors.grey
                          : Colors.green.shade300,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      controller.certificateFilePath.value.isEmpty
                          ? 'Tap to upload certificate'
                          : controller.certificateFilePath.value
                                .split('/')
                                .last,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: controller.certificateFilePath.value.isEmpty
                            ? Colors.grey
                            : Colors.green.shade300,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Custom Widget for Level Dropdown
  Widget _buildLevelDropdown() {
    const levels = ['NATIONAL_LEVEL', 'INTERNATIONAL_LEVEL', 'REGIONAL_LEVEL'];
    const levelLabels = {
      'NATIONAL_LEVEL': 'National Level',
      'INTERNATIONAL_LEVEL': 'International Level',
      'REGIONAL_LEVEL': 'Regional Level',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text(
            'Level',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E3A8A),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<String>(
            value: controller.levelController.text.isEmpty
                ? null
                : controller.levelController.text,
            hint: const Text('Select Level'),
            isExpanded: true,
            underline: const SizedBox(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            items: levels.map((level) {
              return DropdownMenuItem(
                value: level,
                child: Text(levelLabels[level] ?? level),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                controller.levelController.text = value;
              }
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Custom Widget for License Valid Till Date Picker
  Widget _buildLicenseValidDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text(
            'License Valid Till',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E3A8A),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => controller.pickLicenseValidDate(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    controller.licenseValidTillDate.value.isEmpty
                        ? 'Select date'
                        : controller.licenseValidTillDate.value,
                    style: TextStyle(
                      fontSize: 16,
                      color: controller.licenseValidTillDate.value.isEmpty
                          ? Colors.grey
                          : Colors.black,
                    ),
                  ),
                ),
                const Icon(
                  Icons.calendar_today,
                  color: Color(0xFF1E3A8A),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Custom Widget for the Bio/About Me area
  Widget _buildAboutMeArea({
    required String label,
    required String content,
    bool showActionButtons = true,
    required String hintText,
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E3A8A), // Deep Blue color for section titles
          ),
        ),
        const SizedBox(height: 15),
        TextFormField(
          controller: controller,
          initialValue: controller == null ? content : null,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFF10B981),
                width: 2.0,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        //btn 3 Action Buttons for About Me
        if (showActionButtons)
          _buildActionButtons(onSave: () => this.controller.saveAboutMe()),
        if (showActionButtons) const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Edit Profile'),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => controller.refreshProfileData(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Profile Image ---
                _buildProfileImage(),
                const SizedBox(height: 30),
                // --- Basic Info Section ---
                const Text(
                  'Basic Info',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                const SizedBox(height: 15),
                _buildLabeledTextField(
                  label: 'Edit Full Name',
                  hintText: '*Howard Webb*',
                  controller: controller.fullNameController,
                ),

                _buildLabeledTextField(
                  label: 'Referee Bio(6 Words)',
                  hintText: 'Certified Match Referee',
                  controller: controller.bioController,
                ),

                _buildLabeledTextField(
                  label: 'Location',
                  hintText: 'Dhaka, Bangladesh',
                  controller: controller.locationController,
                ),

                _buildLabeledTextField(
                  label: 'Experience',
                  hintText: '## years of experience',
                  controller: controller.experienceController,
                ),

                //btn 1 Action Buttons for Basic Info
                _buildActionButtons(onSave: () => controller.saveBasicInfo()),

                // Action Buttons for Credentials
                const SizedBox(height: 20),

                // --- Referee Credentials Section ---
                const Text(
                  'Referee Credentials',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                const SizedBox(height: 15),

                _buildLabeledTextField(
                  label: 'License ID',
                  hintText: 'RF-2032-0456',
                  controller: controller.licenseIdController,
                ),

                _buildLabeledTextField(
                  label: 'Certifying Authority',
                  hintText: 'Bangladesh Football Federation',
                  controller: controller.certifyingAuthorityController,
                ),

                // License Valid Till Date Picker
                _buildLicenseValidDatePicker(),

                // Level Dropdown
                _buildLevelDropdown(),

                // Upload Certificate Area
                _buildUploadCertificateArea(),

                // btn 2 Action Buttons for Credentials
                _buildActionButtons(onSave: () => controller.saveCredentials()),
                const SizedBox(height: 20),

                // --- About Me Section (with the text area) ---
                _buildAboutMeArea(
                  label: 'About Me',
                  hintText: 'Write something about yourself...',
                  content: '',
                  controller: controller.aboutMeController,
                  showActionButtons: true,
                ),

                // --- Contact Information Section ---
                const Text(
                  'Contact Information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                const SizedBox(height: 15),

                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: 'howardwebb0003@gmail.com',
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.5,
                            ),
                          ),
                        ),
                        controller: controller.emailController,
                      ),
                    ],
                  ),
                ),

                _buildLabeledTextField(
                  label: 'Phone',
                  hintText: '+880 1745 888 992',
                  controller: controller.phoneController,
                ),

                _buildLabeledTextField(
                  label: 'Availability',
                  hintText: 'Open for League Assignments',
                  controller: controller.availabilityController,
                ),
                // btn 4 Action Buttons for Contact Info
                _buildActionButtons(onSave: () => controller.saveContactInfo()),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
