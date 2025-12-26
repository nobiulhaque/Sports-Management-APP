import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaldmv/core/constants/app_colors.dart';
import '../../../../../widgets/custom_profile_card.dart';
import '../../../home_leauge/views/widgets/custom_infoCard.dart';
import '../../../widgets/custom_app_bar.dart';
import '../controllers/refereforleauge_details_controller.dart';

class RefereforleaugeDetailsView
    extends GetView<RefereforleaugeDetailsController> {
   RefereforleaugeDetailsView({super.key});
  
  final controller = Get.put(RefereforleaugeDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarLeauge(title: "Referee"),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        
        final referee = controller.refereeDetails.value;
        final user = referee?.user;

        if (referee == null ) {
           // Fallback or empty state if needed. 
           // For now just show empty structure or a message, but let's try to show structure with empty data.
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

                    /// Profile Image with White Border
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: (user?.image != null && user!.image!.startsWith('http'))
                              ? CachedNetworkImage(
                                  imageUrl: user.image!,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Image.asset(
                                    '',
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Image.asset(
                                  '',
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// Name
                    Text(
                      user?.name ?? 'Unknown Name',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// Title
                    Text(
                      user?.role?.replaceAll('_', ' ') ?? 'Referee',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.greyText,
                      ),
                    ),
                    const SizedBox(height: 8),

                    /// Location
                    Text(
                      referee?.location ?? 'Location N/A',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.greyText,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// Experience
                    Text(
                      referee?.experience != null ? '${referee!.experience} Years Experience' : 'Experience N/A',
                      style: TextStyle(
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
                          '${referee?.averageRating ?? 0}/5',
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
                border: Border.all(color: AppColors.accentGreen.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.emoji_events_outlined, color: AppColors.accentGreen),
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
                    "${referee?.totalMatches ?? 0}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentGreen,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// =========================
            /// 3. Bottom Buttons
            /// =========================
            Row(
              children: [
                /// Assign
                Expanded(
                  child: SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Assign",
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

                /// Message
                Expanded(
                  child: SizedBox(
                    height: 55,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Message",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
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
            /// 4. Credentials Info Cards
            /// =========================

            CustomInfoCard(
              icon: const Icon(Icons.sports_soccer, color: AppColors.primary),
              title: "Referee Credentials",
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoItem(
                    title: "License ID",
                    value: "RF-2032-0456", // Static for now as API doesn't seem to have it
                  ),
                  const SizedBox(height: 12),

                  _buildInfoItem(
                    title: "Certifying Authority",
                    value: referee?.certifyingAuthority ?? "N/A",
                  ),
                  const SizedBox(height: 12),

                  _buildInfoItem(
                    title: "License Valid Till",
                    value: "December 2026", // Static
                  ),
                  const SizedBox(height: 12),

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
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF003366),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            referee?.badge ?? "National",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            CustomInfoCard(
              icon: const Icon(Icons.document_scanner, color: AppColors.primary),
              title: "About",
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(referee?.bio ?? "Passionate and disciplined football referee with experience across multiple leagues and tournaments. Dedicated to ensuring fair play, clear communication, and maintaining the integrity of the game."),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// =========================
            /// UPDATED: Contact Information
            /// =========================
            CustomInfoCard(
              icon: const Icon(Icons.call, color: AppColors.primary),
              title: "Contact Information",
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Email
                  _buildContactRow(
                    icon: Icons.email_outlined,
                    title: "Email",
                    value: user?.email ?? "N/A",
                  ),
                  const SizedBox(height: 12),

                  // Phone
                  _buildContactRow(
                    icon: Icons.phone_outlined,
                    title: "Phone",
                    value: "+880 1745 888 992", // Static as user object lacks phone
                  ),
                  const SizedBox(height: 12),

                  // Availability (Green Box)
                  _buildAvailabilityRow(
                    icon: Icons.access_time,
                    title: "Availability",
                    value: "Open for League Assignments", // Static
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
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
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

  /// Helper: Contact Info Row (Icon + Text)
  Widget _buildContactRow({required IconData icon, required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA), // Very light grey bg
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
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
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

  /// Helper: Availability Row (Green Style)
  Widget _buildAvailabilityRow({required IconData icon, required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF5), // Light green background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFA7F3D0)), // Green border
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF059669), size: 24), // Green Icon
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
                    color: Color(0xFF065F46), // Darker green text
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