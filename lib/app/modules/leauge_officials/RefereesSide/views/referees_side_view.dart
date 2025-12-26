import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kaldmv/app/modules/leauge_officials/RefereesSide/views/referee_profile_details_view.dart';
import 'package:kaldmv/app/modules/leauge_officials/RefereesSide/views/widgets/FilterChipSection.dart';

import '../../add_match/modules/views/widgets/referee_screen_widgets.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_search_bar.dart';
import '../controllers/referees_side_controller.dart';

class RefereesSideView extends GetView<RefereesSideController> {
 RefereesSideView({super.key});
 @override
  final controller = Get.put(RefereesSideController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarLeauge(title: "Referee"),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            /// 🔍 Search Bar
            Padding(
              padding: const EdgeInsets.only(top: 0.0, bottom: 8.0),
              child: CustomSearchBar(
                hintText: "Search referees...",
                controller: controller.searchController,
                onChanged: (value) => controller.searchReferees(value),
              ),
            ),

            /// 🏷 Filter Chips
            const FilterChipSection(),

            const SizedBox(height: 2),

            /// 👨‍⚖️ Referee List
            ...controller.referees.map((item) {
              final referee = item.referee;

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: RefereeProfileCard(
                  name: referee.user.name,
                  rating: referee.averageRating,
                  experience:
                  '${referee.experience ?? 0} Years Experience',
                  imagePath: referee.user.image ?? '',
                  onTap: () {
                    Get.to(
                          () => ProfileDetailsRefereeSide(),
                      arguments: referee.user.id,
                    );
                  }, buttonText: 'View Profile',
                ),
              );
            }),

            const SizedBox(height: 20),
          ],
        );
      }),
    );
  }
}
