import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/referee_details_controller.dart';

class RefereeDetailsView extends GetView<RefereeDetailsController> {
  const RefereeDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RefereeDetailsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RefereeDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
