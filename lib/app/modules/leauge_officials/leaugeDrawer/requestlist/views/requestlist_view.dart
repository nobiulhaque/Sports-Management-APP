import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kaldmv/app/modules/leauge_officials/leaugeDrawer/requestlist/views/referee_profile.dart';
import 'package:kaldmv/app/modules/leauge_officials/leaugeDrawer/requestlist/views/widgets/card_request.dart';

import '../../../widgets/custom_app_bar.dart';
import '../controllers/requestlist_controller.dart';

class RequestlistView extends GetView<RequestlistController> {
  const RequestlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarLeauge(title: "Request List"),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.refereeRequests.isEmpty) {
          return const Center(child: Text('No referee requests available'));
        }

        return Column(
          children: [
            // Filter Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Obx(() => Row(
                children: List.generate(
                  controller.filters.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(right: index < controller.filters.length - 1 ? 8 : 0),
                    child: GestureDetector(
                      onTap: () => controller.selectFilter(index),
                      child: _buildFilterChip(
                        controller.filters[index],
                        controller.selectedFilter.value == index,
                      ),
                    ),
                  ),
                ),
              )),
            ),
            // List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: controller.refereeRequests.length,
                itemBuilder: (context, index) {
                  final referee = controller.refereeRequests[index];
                  return RefereeProfileCardReq(
                    name: referee.name,
                    rating: null,
                    experience: referee.experience ?? 'Experience not available',
                    imagePath: referee.image,
                    location: referee.location ?? 'Location not available',
                    status: referee.status,
                    certifyingAuthority: referee.certifyingAuthority,
                    onAccept: () => controller.acceptRequest(index),
                    onViewProfile: () {
                      Get.to(
                        () => RefereeProfileDetailsRequestList(),
                        arguments: {
                          'refereeUserId': referee.refereeUserId,
                          'requestId': referee.id,
                        },
                      );
                    },
                    onMessage: () => controller.sendMessage(index),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: ShapeDecoration(
        color: isSelected ? const Color(0xFF1E3A8A) : const Color(0xFFD9E1F7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF1E3A8A),
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          height: 1.50,
        ),
      ),
    );
  }
}
