import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaldmv/app/modules/leauge_officials/widgets/custom_search_bar.dart';
import 'package:kaldmv/app/modules/regular_user/home_regular_user/views/widgets/regular_completed_matches_section.dart';

import 'package:kaldmv/app/modules/regular_user/home_regular_user/views/widgets/regular_referees_section.dart';

class RegularHomeBody extends StatelessWidget {
  const RegularHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                const CustomSearchBar(hintText: 'Search Jobs'),
                SizedBox(height: 10.h),

                // Completed Matches Section with Carousel
                const RegularCompletedMatchesSection(),
                SizedBox(height: 24.h),

                // Referees Section
                const RegularRefereesSection(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
