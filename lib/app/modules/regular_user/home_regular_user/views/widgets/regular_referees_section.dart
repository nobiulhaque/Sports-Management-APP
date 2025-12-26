import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/leauge_officials/RefereesSide/views/referee_profile_details_view.dart';
import 'package:kaldmv/app/modules/leauge_officials/add_match/modules/views/widgets/referee_screen_widgets.dart';
import 'package:kaldmv/app/modules/regular_user/home_regular_user/views/widgets/referee_seeall.dart';
import '../../controllers/regular_referees_controller.dart';

class RegularRefereesSection extends StatelessWidget {
  const RegularRefereesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegularRefereesController());

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: CircularProgressIndicator(),
          ),
        );
      }

      // Get first 2 referees for preview
      final previewReferees = controller.referees.take(2).toList();

      if (previewReferees.isEmpty) {
        return const Center(child: Text('No referees available'));
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with "See All" button
          _buildSectionHeader(
            title: 'Referees',
            onViewAll: () => Get.to(() => const RefereeSeeall()),
          ),
          SizedBox(height: 16.h),

          // Referee Cards List - Show first 2
          ...previewReferees.asMap().entries.map((entry) {
            final referee = entry.value;
            return Column(
              children: [
                _buildRefereeCard(
                  userId: referee.userId,
                  name: referee.name,
                  rating: referee.averageRating,
                  experience: referee.experience != null
                      ? '${referee.experience} Years Experience'
                      : 'Experience not available',
                  imagePath: referee.image ?? '',
                  totalMatches: referee.totalMatches,
                  level: referee.level,
                  role: referee.role,
                ),
                if (entry.key < previewReferees.length - 1)
                  SizedBox(height: 16.h),
              ],
            );
          }),
        ],
      );
    });
  }

  Widget _buildSectionHeader({
    required String title,
    required VoidCallback onViewAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: onViewAll,
          child: Text(
            'See All',
            style: TextStyle(fontSize: 14.sp, color: const Color(0xFF1E40AF)),
          ),
        ),
      ],
    );
  }

  Widget _buildRefereeCard({
    required String userId,
    required String name,
    required double rating,
    required String experience,
    required String imagePath,
    int? totalMatches,
    String? level,
    String? role,
  }) {
    return RefereeProfileCard(
      name: name,
      rating: rating,
      experience: experience,
      imagePath: imagePath,
<<<<<<< HEAD
      onTap: () => Get.to(() => ProfileDetailsRefereeSide()), buttonText: 'View Profile',
=======
      totalMatches: totalMatches,
      level: level,
      role: role,
      onTap: () => Get.to(
        () => ProfileDetailsRefereeSide(isRegularUser: true),
        arguments: userId,
      ),
>>>>>>> 074dca573ec78ee82d59ce69b908b08a972ec865
    );
  }
}
