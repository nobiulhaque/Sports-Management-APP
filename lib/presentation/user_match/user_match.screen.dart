import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/user_match.controller.dart';

class UserMatchScreen extends GetView<UserMatchController> {
  const UserMatchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserMatchScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'UserMatchScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
