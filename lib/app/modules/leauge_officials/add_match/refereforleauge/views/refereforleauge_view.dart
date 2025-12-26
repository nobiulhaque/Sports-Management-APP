import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/custom_app_bar.dart';
import '../../modules/views/widgets/referee_screen_widgets.dart';
import '../../refereforleaugeDetails/views/refereforleauge_details_view.dart';
import '../controllers/refereforleauge_controller.dart';

class RefereforleaugeView extends GetView<RefereforleaugeController> {
   RefereforleaugeView({super.key});
final controller = Get.put(RefereforleaugeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarLeauge(title: "Referee"),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.refereeList.isEmpty) {
          return const Center(child: Text("No referees found in your league"));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.refereeList.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final refereeData = controller.refereeList[index];
            final user = refereeData.referee?.user;
            final referee = refereeData.referee;

            final args = Get.arguments;
            final isSelection = args != null && args is Map && args['isSelection'] == true;

            return RefereeProfileCard(
              name: user?.name ?? 'Unknown Referee',
              rating: (referee?.averageRating ?? 0).toDouble(),
              experience: referee?.experience != null 
                  ? '${referee!.experience} Years Experience' 
                  : 'N/A Experience',
              imagePath: user?.image ?? '',
              buttonText: isSelection ? 'Select Referee' : 'View Profile',
              onTap: () {
                if (args != null && args is Map && args['isSelection'] == true) {
                  Get.back(result: refereeData);
                } else {
                  if (user?.id != null) {
                     Get.to(() => RefereforleaugeDetailsView(),
                        arguments: user!.id); 
                  }
                }
              },
            );
          },
        );
      }),
    );
  }
}
