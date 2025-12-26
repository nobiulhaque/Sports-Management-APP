import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/leauge_officials/update_matches/views/widgets/match_score_line.dart';
import 'package:kaldmv/app/modules/leauge_officials/update_matches/views/widgets/match_statistics_widget.dart';
import 'package:kaldmv/app/modules/leauge_officials/widgets/custom_app_bar.dart';
import 'package:kaldmv/core/utils/utils.dart';

import '../../../../../core/constants/app_icons.dart';
import '../controllers/update_matches_controller.dart';

class UpdateMatchesView extends GetView<UpdateMatchesController> {
  const UpdateMatchesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarLeauge(title: 'Update Match'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 12.h),

              /// score line section
              MatchScoreLine(),
              SizedBox(height: 24.h),
              Container(
                padding: EdgeInsets.all(16.r),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE5E7EB)),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  children: [
                    Utils.cardTitleSection(
                      context: context,
                      iconImagePath: AppIcons.football,
                      title: 'Match Statistics',
                      backgroundColor: Color(0xFFD9E1F7),
                      iconColor: Color(0xFF1E3A8A),
                    ),
                    SizedBox(height: 24.h),
                    MatchStatisticsWidget(),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Obx(
                () => Utils.primaryButton(
                  context: context,
                  title: controller.isLoading.value ? '' : 'Submit',
                  child: controller.isLoading.value
                      ? SizedBox(
                          height: 20.h,
                          width: 20.h,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : null,
                  radius: 4.r,
                  onTap: controller.isLoading.value
                      ? null
                      : () {
                          controller.submitMatchUpdate();
                        },
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
