import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/leauge_officials/RefereesSide/views/referee_profile_details_view.dart';
import 'package:kaldmv/app/modules/leauge_officials/add_match/modules/views/widgets/referee_screen_widgets.dart';
import 'package:kaldmv/app/widgets/app_bar_widgets.dart';
import '../../controllers/regular_referees_controller.dart';

class RefereeSeeall extends StatelessWidget {
  const RefereeSeeall({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegularRefereesController>();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Referees'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.referees.isEmpty) {
          return const Center(child: Text('No referees available'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: controller.referees.length,
          itemBuilder: (context, index) {
            final referee = controller.referees[index];
            return Column(
              children: [
                RefereeProfileCard(
                  name: referee.name,
                  rating: referee.averageRating,
                  experience: referee.experience != null
                      ? '${referee.experience} Years Experience'
                      : 'Experience not available',
                  imagePath: referee.image ?? '',
                  totalMatches: referee.totalMatches,
                  level: referee.level,
                  role: referee.role,
                  onTap: () => Get.to(
                    () => ProfileDetailsRefereeSide(isRegularUser: true),
                    arguments: referee.userId,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        );
      }),
    );
  }
}
