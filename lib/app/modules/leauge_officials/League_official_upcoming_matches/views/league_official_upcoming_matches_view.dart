import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/league_official_upcoming_matches_controller.dart';

class LeagueOfficialUpcomingMatchesView
    extends GetView<LeagueOfficialUpcomingMatchesController> {
  const LeagueOfficialUpcomingMatchesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LeagueOfficialUpcomingMatchesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LeagueOfficialUpcomingMatchesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
