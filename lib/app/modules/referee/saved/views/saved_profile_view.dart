import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/widgets/custom_profile_card.dart';
import '../../../../widgets/custom_back_button.dart';
import '../controllers/saved_profile_controller.dart';

class SavedProfileView extends GetView<SavedProfileController> {
   SavedProfileView({super.key});
  @override
  final controller = Get.put(SavedProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 70.w,
        leading: CustomBackButton(),
        title: Center(
          child: Text(
            'Profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [SizedBox(width: 70.w)], // To center the title
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 16),
              _buildHeaderCard(),
              const SizedBox(height: 12),
              _buildEditProfileButton(),
              const SizedBox(height: 8),
              _buildMessageButton(),
              const SizedBox(height: 16),
              _buildLeagueInformation(),
              const SizedBox(height: 16),
              _buildOfficialRepresentative(),
              const SizedBox(height: 16),
              _buildAccountInformation(),
              const SizedBox(height: 16),
              _buildStatsGrid(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Obx(
      () => SizedBox(
        width: double.infinity,
        child: CustomProfileCard(
          elevation: 2,
          color: const Color.fromARGB(255, 24, 58, 131),
          borderRadius: 20,
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.h),
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      controller.logoAsset.value,
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  controller.name.value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.email.value,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 16),
                Text(
                  controller.leagueType.value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.foundedYear.value,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditProfileButton() {
    return ElevatedButton.icon(
      onPressed: () {
        Get.snackbar(
          'Edit Profile',
          'Opening edit profile...',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      icon: const Icon(Icons.edit_outlined, size: 18),
      label: const Text(
        'Edit Profile',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildMessageButton() {
    return ElevatedButton(
      onPressed: () {
        Get.snackbar(
          'Message',
          'Opening message chat...',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00C853),
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        'Message',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildLeagueInformation() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.info_outline, color: Color(0xFF00C853), size: 20),
                SizedBox(width: 8),
                Text(
                  'League Information',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Organization ID', controller.organizationId.value),
            const SizedBox(height: 12),
            _buildInfoRow('Country', controller.country.value),
            const SizedBox(height: 12),
            _buildInfoRow(
              'Certifying Authority',
              controller.certifyingAuthority.value,
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              'License Valid Till',
              controller.licenseValidTill.value,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Level',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0066CC),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    controller.leagueType.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfficialRepresentative() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.person_outline, color: Color(0xFF0066CC), size: 20),
                SizedBox(width: 8),
                Text(
                  'Official Representative',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(controller.repAvatarUrl.value),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Full Name',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        controller.repFullName.value,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildContactRow('Designation', controller.repDesignation.value),
            const SizedBox(height: 12),
            _buildContactRow(
              'Contact Number',
              controller.repContactNumber.value,
              icon: Icons.phone_outlined,
            ),
            const SizedBox(height: 12),
            _buildContactRow(
              'Email',
              controller.repEmail.value,
              icon: Icons.email_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountInformation() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.assignment_outlined,
                  color: Color(0xFFFFA000),
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Account Information',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildAccountRow(
              Icons.calendar_today_outlined,
              'Joined on',
              controller.joinedDate.value,
            ),
            const Divider(height: 24),
            _buildAccountRow(
              Icons.person_outline,
              'Account Type',
              controller.accountType.value,
              badge: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    Icons.people_outline,
                    controller.refereesHired.value,
                    'Referees Hired',
                    const Color(0xFF0066CC),
                    Colors.blue[50]!,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    Icons.sports_soccer_outlined,
                    controller.ongoingMatches.value,
                    'Ongoing Matches',
                    const Color(0xFF00C853),
                    Colors.green[50]!,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    Icons.pending_outlined,
                    controller.pendingMatches.value,
                    'Pending Matches',
                    const Color(0xFF00C853),
                    Colors.green[50]!,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    Icons.check_circle_outline,
                    controller.completedMatches.value,
                    'Completed Matches',
                    const Color(0xFFFFA000),
                    Colors.orange[50]!,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    IconData icon,
    String value,
    String title,
    Color iconColor,
    Color bgColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildContactRow(String label, String value, {IconData? icon}) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccountRow(
    IconData icon,
    String label,
    String value, {
    bool badge = false,
    Color? statusColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ),
        if (badge)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFFA000),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        else
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: statusColor ?? Colors.black,
            ),
          ),
      ],
    );
  }
}
