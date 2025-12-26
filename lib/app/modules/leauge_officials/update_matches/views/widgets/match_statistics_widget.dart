import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/leauge_officials/update_matches/controllers/update_matches_controller.dart';
import 'package:kaldmv/app/modules/leauge_officials/update_matches/views/widgets/stat_counter_field.dart';

class MatchStatisticsWidget extends StatelessWidget {
  const MatchStatisticsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UpdateMatchesController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.r,
      children: [
        Obx(
          () => StatCounterField(
            label: 'Yellow Cards',
            value: controller.yellowCards.value,
            onIncrement: controller.incrementYellowCards,
            onDecrement: controller.decrementYellowCards,
          ),
        ),
        Obx(
          () => StatCounterField(
            label: 'Red Cards',
            value: controller.redCards.value,
            onIncrement: controller.incrementRedCards,
            onDecrement: controller.decrementRedCards,
          ),
        ),
        Obx(
          () => StatCounterField(
            label: 'Fouls Called',
            value: controller.foulsCalled.value,
            onIncrement: controller.incrementFoulsCalled,
            onDecrement: controller.decrementFoulsCalled,
          ),
        ),
        Obx(
          () => StatCounterField(
            label: 'Offsides',
            value: controller.offsides.value,
            onIncrement: controller.incrementOffsides,
            onDecrement: controller.decrementOffsides,
          ),
        ),
      ],
    );
  }
}
