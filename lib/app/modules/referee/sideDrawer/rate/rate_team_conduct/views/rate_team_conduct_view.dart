import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kaldmv/app/widgets/app_bar_widgets.dart';

import '../controllers/rate_team_conduct_controller.dart';
import '../widgets/rate_conduct_card.dart';

class RateTeamConductView extends GetView<RateTeamConductController> {
  const RateTeamConductView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Rate Team Conduct'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              'Rate Team Conduct',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8.h),
            Text(
              'Your feedback stays anonymous and helps improve league behavior.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.errorMessage.value.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(controller.errorMessage.value),
                        SizedBox(height: 16.h),
                        ElevatedButton(
                          onPressed: () =>
                              controller.fetchRateTeamConductData(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (controller.rateCardList.isEmpty) {
                  return Center(
                    child: Text(
                      'No matches available to rate',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.rateCardList.length,
                  itemBuilder: (context, index) {
                    final rateData = controller.rateCardList[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: RateTeamConductCard(
                        rateData: rateData,
                        onStartRating: () => controller.onStartRating(rateData),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
