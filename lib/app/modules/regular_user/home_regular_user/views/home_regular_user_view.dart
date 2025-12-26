import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/regular_user/account_regular_page/views/account_regular_page_view.dart';
import 'package:kaldmv/app/modules/regular_user/home_regular_user/views/widgets/regular_home_body.dart';
import 'package:kaldmv/app/modules/regular_user/home_regular_user/views/widgets/regular_home_app_bar.dart';
import 'package:kaldmv/app/modules/regular_user/home_regular_user/views/widgets/regular_home_bottom_nav.dart';
import 'package:kaldmv/app/modules/regular_user/regular_league/views/regular_league_view.dart';
import 'package:kaldmv/app/modules/regular_user/regular_match/views/regular_match_view.dart';
import '../../../../widgets/app_bar_widgets.dart';
import '../controllers/home_regular_user_controller.dart';

class HomeRegularUserView extends GetView<HomeRegularUserController> {
  const HomeRegularUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: _buildAppBar(),
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: [
            const RegularHomeBody(),
            RegularMatchView(),
            RegularLeagueView(),
            AccountRegularPageView(),
          ],
        ),
        bottomNavigationBar: const RegularHomeBottomNav(),
      ),
    );
  }

  PreferredSizeWidget? _buildAppBar() {
    final index = controller.currentIndex.value;
    if (index == 0) return const RegularHomeAppBar();
    if (index == 1) {
      return const CustomAppBar(title: 'Matches', showBackButton: false);
    }
    if (index == 2) {
      return const CustomAppBar(title: 'Leagues', showBackButton: false);
    }
    return null;
  }
}
