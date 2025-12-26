// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../widgets/custom_profile_card.dart';
import '../../home_leauge/views/widgets/custom_infoCard.dart';
import '../../widgets/custom_app_bar.dart';
import '../controllers/referee_profile_details_controller.dart';

class ProfileDetailsRefereeSide
    extends GetView<RefereeProfileDetailsController> {
  final bool isRegularUser;

  ProfileDetailsRefereeSide({super.key, this.isRegularUser = false});

  final _controller = Get.put(RefereeProfileDetailsController());

  @override
  Widget build(BuildContext context) {
    // Get user ID from arguments and fetch data
    final userId = Get.arguments as String? ?? '';
    if (userId.isNotEmpty) {
      _controller.fetchRefereeDetails(userId, isRegularUser: isRegularUser);
    }

    return Scaffold(
      appBar: CustomAppBarLeauge(title: "Referee"),

      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// =========================
              /// 1. Profile Card
              /// =========================
              CustomProfileCard(
                elevation: 2,
                color: AppColors.primary,
                borderRadius: 20,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      /// Profile Image
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child:
                            _controller.userImage.value != null &&
                                _controller.userImage.value!.isNotEmpty
                            ? ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: _controller.userImage.value!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      const CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Color(0xFFE8EAFF),
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                  errorWidget: (context, url, error) =>
                                      const CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Color(0xFFE8EAFF),
                                        child: Icon(
                                          Icons.person,
                                          size: 40,
                                          color: Color(0xFF4A5FD8),
                                        ),
                                      ),
                                ),
                              )
                            : const CircleAvatar(
                                radius: 50,
                                backgroundColor: Color(0xFFE8EAFF),
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Color(0xFF4A5FD8),
                                ),
                              ),
                      ),
                      const SizedBox(height: 16),

                      /// Name
                      Text(
                        _controller.userName.value,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),

                      /// title
                      Text(
                        _controller.userRole.value,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.greyText,
                        ),
                      ),
                      const SizedBox(height: 8),

                      /// Location
                      Text(
                        _controller.location.value ?? 'Location not available',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.greyText,
                        ),
                      ),
                      const SizedBox(height: 8),

                      /// Experience
                      Text(
                        _controller.experience.value != null
                            ? '${_controller.experience.value} Years Experience'
                            : 'Experience not available',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.greyText,
                        ),
                      ),
                      const SizedBox(height: 20),

                      /// Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 28),
                          const SizedBox(width: 8),
                          Text(
                            '${_controller.userRating.value}/5',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// =========================
              /// 2. Total Matches Stats
              /// =========================
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.lightGreenBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.accentGreen.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.emoji_events_outlined,
                      color: AppColors.accentGreen,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Total Matches: ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      "${_controller.totalMatches.value}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accentGreen,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// =========================
              /// 3. Message Button (Updated)
              /// =========================
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // Message Logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        AppColors.accentGreen, // Green color like image
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Message",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// =========================
              /// 4. Credentials Info Cards (Updated)
              /// =========================
              CustomInfoCard(
                icon: const Icon(
                  Icons.verified_user_outlined,
                  color: AppColors.primary,
                ),
                title: "Referee Credentials",
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // License ID
                    _buildInfoItem(
                      title: "License ID",
                      value: _controller.licenseId.value ?? "N/A",
                    ),
                    const SizedBox(height: 12),

                    // Authority
                    _buildInfoItem(
                      title: "Certifying Authority",
                      value: _controller.certifyingAuthority.value ?? "N/A",
                    ),
                    const SizedBox(height: 12),

                    // Date of Issue (Added)
                    _buildInfoItem(
                      title: "Date of Issue",
                      value: "Aug 15, 2024",
                    ),
                    const SizedBox(height: 12),

                    // Valid Till
                    _buildInfoItem(
                      title: "License Valid Till",
                      value: _controller.licenseValid.value ?? "N/A",
                    ),
                    const SizedBox(height: 12),

                    // Level
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Level",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF003366), // Dark Blue Pill
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              _controller.level.value.isNotEmpty
                                  ? _controller.level.value
                                  : "N/A",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // View Certificate Section (Added)
                    _buildCertificateSection(),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              CustomInfoCard(
                icon: const Icon(
                  Icons.document_scanner,
                  color: AppColors.primary,
                ),
                title: "About",
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_controller.bio.value ?? "No information available"),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// =========================
              /// Contact Information
              /// =========================
              CustomInfoCard(
                icon: const Icon(Icons.call, color: AppColors.primary),
                title: "Contact Information",
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContactRow(
                      icon: Icons.email_outlined,
                      title: "Email",
                      value: _controller.userEmail.value,
                    ),
                    const SizedBox(height: 12),
                    _buildContactRow(
                      icon: Icons.phone_outlined,
                      title: "Phone",
                      value: _controller.phone.value ?? "N/A",
                    ),
                    const SizedBox(height: 12),
                    _buildAvailabilityRow(
                      icon: Icons.access_time,
                      title: "Availability",
                      value: _controller.availability.value ?? "Not Available",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        );
      }),
    );
  }

  /// Widget for the View Certificate Section (Bottom of credentials)
  Widget _buildCertificateSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PDF Icon and Name
          Row(
            children: [
              const Icon(
                Icons.description_outlined,
                color: Colors.lightBlue, // Light blue file icon
                size: 28,
              ),
              const SizedBox(width: 10),
              Text(
                "referee-license-2024.pdf",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Blue View Button
          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                // View Certificate Logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A8A), // Dark Blue color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.remove_red_eye_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "View Certificate",
                    style: TextStyle(
                      fontSize: 14,
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
    );
  }

  /// Helper: Generic Info Item (Boxed)
  Widget _buildInfoItem({required String title, required String value}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  /// Helper: Contact Info Row
  Widget _buildContactRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade700, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Helper: Availability Row
  Widget _buildAvailabilityRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFA7F3D0)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF059669), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF059669),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF065F46),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
