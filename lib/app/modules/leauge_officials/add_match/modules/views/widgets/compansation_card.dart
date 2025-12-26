import 'package:flutter/material.dart';

import '../../../../../../../core/constants/app_colors.dart';

class AllowanceCard extends StatelessWidget {
  final List<String> allowanceTitles;
  final List<TextEditingController> controllers;

  const AllowanceCard({
    super.key,
    required this.allowanceTitles,
    required this.controllers,
  }) : assert(allowanceTitles.length == controllers.length, "Titles and Controllers count must match");

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: List.generate(allowanceTitles.length, (index) {
          return AllowanceItem(
            title: allowanceTitles[index],
            controller: controllers[index],
          );
        }),
      ),
    );
  }
}

class AllowanceItem extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  const AllowanceItem({
    super.key,
    required this.title,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.secondaryTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            prefixText: '\$ ',
            prefixStyle: const TextStyle(
              fontSize: 16,
              color: AppColors.primarySubtle,
              fontWeight: FontWeight.w500,
            ),
            hintText: '0.00',
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w500,
            ),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.primarySubtle,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          height: 1,
          color: AppColors.primarySubtle,
        ),
      ],
    );
  }
}