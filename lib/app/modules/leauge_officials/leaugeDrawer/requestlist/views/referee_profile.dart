import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../core/constants/app_colors.dart';
import '../../../../../widgets/custom_profile_card.dart';
import '../../../home_leauge/views/widgets/custom_infoCard.dart';
import '../../../widgets/custom_app_bar.dart';
import '../controllers/referee_profile_controller.dart';

class RefereeProfileDetailsRequestList extends GetView<RefereeProfileController> {
  RefereeProfileDetailsRequestList({super.key});

  @override
  final controller = Get.put(RefereeProfileController());

  @override
  Widget build(BuildContext context) {
    // Get arguments
    final args = Get.arguments;
    final refereeUserId = args is Map ? args['refereeUserId'] ?? '' : args ?? '';
    final requestId = args is Map ? args['requestId'] ?? '' : '';
    
    // Set request ID for accept/decline
    controller.requestId = requestId;
    
    // Fetch API once screen opens
    controller.fetchRefereeDetails(refereeUserId);

    return Scaffold(
      appBar: CustomAppBarLeauge(title: "Referee"),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              /// =========================
              /// 1. PROFILE CARD
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
                      Obx(() => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: controller.userImage.value.isEmpty
                              ? const AssetImage("assets/images/refereeee.png")
                              : NetworkImage(controller.userImage.value)
                          as ImageProvider,
                        ),
                      )),

                      const SizedBox(height: 16),

                      /// Name
                      Obx(() => Text(
                        controller.userName.value,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )),

                      const SizedBox(height: 8),

                      /// Role
                      Obx(() => Text(
                        controller.userRole.value,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.greyText,
                        ),
                      )),
                      const SizedBox(height: 8),

                      /// Location
                      Obx(() => Text(
                        controller.location.value,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.greyText,
                        ),
                      )),

                      const SizedBox(height: 8),

                      /// Experience
                      Obx(() => Text(
                        "${controller.experience.value} Years Experience",
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.greyText,
                        ),
                      )),

                      const SizedBox(height: 20),

                      /// Rating
                      Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.star,
                              color: Colors.amber, size: 28),
                          const SizedBox(width: 8),
                          Text(
                            '${controller.userRating.value}/5',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// =========================
              /// 2. TOTAL MATCHES CARD
              /// =========================
              Obx(() => Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.lightGreenBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: AppColors.accentGreen.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.emoji_events_outlined,
                        color: AppColors.accentGreen),
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
                      "${controller.totalMatches.value}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accentGreen,
                      ),
                    ),
                  ],
                ),
              )),

              const SizedBox(height: 30),

              /// =========================
              /// 3. Accept / Decline Buttons
              /// =========================
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () => controller.acceptRequest(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Accept",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: OutlinedButton(
                        onPressed: () => controller.declineRequest(),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                          backgroundColor: Colors.red.shade50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Decline",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// =========================
              /// 4. Credentials Info
              /// =========================

              Obx(() => CustomInfoCard(
                icon: const Icon(Icons.sports_soccer,
                    color: AppColors.primary),
                title: "Referee Credentials",
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoItem(
                        title: "License ID",
                        value: controller.licenseId.value),
                    const SizedBox(height: 12),

                    _buildInfoItem(
                        title: "Certifying Authority",
                        value: controller.certifyingAuthority.value),
                    const SizedBox(height: 12),

                    _buildInfoItem(
                        title: "License Valid Till",
                        value: controller.licenseValid.value),
                    const SizedBox(height: 12),

                    _buildInfoItem(
                        title: "Level", value: controller.level.value),
                  ],
                ),
              )),

              const SizedBox(height: 10),

              Obx(() => CustomInfoCard(
                icon: const Icon(Icons.document_scanner,
                    color: AppColors.primary),
                title: "About",
                content: Text(
                  controller.bio.value.isEmpty ? "No information provided" : controller.bio.value,
                  style: const TextStyle(fontSize: 15),
                ),
              )),

              const SizedBox(height: 10),

              /// =========================
              /// 5. Contact Information
              /// =========================
              Obx(() => CustomInfoCard(
                icon: const Icon(Icons.call, color: AppColors.primary),
                title: "Contact Information",
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContactRow(
                        icon: Icons.email_outlined,
                        title: "Email",
                        value: controller.userEmail.value),
                    const SizedBox(height: 12),

                    _buildContactRow(
                        icon: Icons.phone_outlined,
                        title: "Phone",
                        value: controller.phone.value),
                    const SizedBox(height: 12),

                    _buildAvailabilityRow(
                        icon: Icons.access_time,
                        title: "Availability",
                        value: controller.availability.value),
                  ],
                ),
              )),

              const SizedBox(height: 30),
            ],
          ),
        );
      }),
    );
  }

  /// Helper Widgets -----------------------------

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
          Text(title,
              style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _buildContactRow(
      {required IconData icon,
        required String title,
        required String value}) {
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
                Text(title,
                    style: TextStyle(
                        color: Colors.grey.shade600, fontSize: 13)),
                const SizedBox(height: 4),
                Text(value,
                    style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailabilityRow(
      {required IconData icon,
        required String title,
        required String value}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFA7F3D0)),
      ),
      child: Row(
        children: [
          const Icon(Icons.access_time,
              color: Color(0xFF059669), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Color(0xFF059669), fontSize: 13)),
                const SizedBox(height: 4),
                Text(value,
                    style: const TextStyle(
                        color: Color(0xFF065F46),
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
