import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/user_leagues.controller.dart';

class UserLeaguesScreen extends GetView<UserLeaguesController> {
  const UserLeaguesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserLeaguesScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'UserLeaguesScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
