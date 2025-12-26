// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/data/models/subscription_plan_model.dart';
import '../../../../widgets/app_bar_widgets.dart';
import '../controllers/premium_controller.dart';

class PremiumView extends GetView<PremiumController> {
  const PremiumView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<PremiumController>()) {
      Get.lazyPut<PremiumController>(() => PremiumController());
    }
    return Scaffold(
      appBar: const CustomAppBar(title: 'Try Premium'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Unlock Your Full Officiating Experience',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Get unlimited access to match insights, referee performance feedback, and advanced match management tools all designed to elevate your refereeing journey.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),

                // Plans List
                if (controller.isLoading.value) ...[
                   const SizedBox(height: 100),
                   const Center(child: CircularProgressIndicator()),
                ] else ...[
                   ...controller.plans.map((plan) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: GestureDetector(
                        onTap: () => controller.selectPlan(plan),
                        child: _buildPlanCard(plan: plan),
                      ),
                    );
                   }),
                ],

                const SizedBox(height: 24),

                // Subscribe Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: controller.subscribe,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2B4A8D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Subscribe',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard({required PlanData plan}) {
    final selected = controller.selectedPlan.value?.id == plan.id;
    const Color activeColor = Color(0xFF2B4A8D);

    Color backgroundColor = selected ? activeColor : Colors.white;
    Color textColor = selected ? Colors.white : Colors.black;
    Color borderColor = selected ? activeColor : Colors.grey.shade300;

    String period = plan.type == 'ANNUAL' ? '/ Year' : '/ Month';
    // Format price to hide decimals if it's a whole number
    String price = '\$${plan.price?.toStringAsFixed(plan.price!.truncateToDouble() == plan.price ? 0 : 2) ?? '0'}';


    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: selected ? 2 : 1),
        boxShadow: [
          if (selected)
            BoxShadow(
              color: activeColor.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                plan.title ?? '',
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: selected ? Colors.white : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected ? Colors.white : Colors.grey.shade400,
                    width: 2,
                  ),
                ),
                child: selected
                    ? const Icon(Icons.check, color: activeColor, size: 16)
                    : null,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: TextStyle(
                  color: textColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                period,
                style: TextStyle(
                  color: selected ? Colors.white70 : Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (plan.facilities != null)
            ...plan.facilities!.map((feature) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: _buildFeatureItem(feature, textColor),
            )),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String feature, Color textColor) {
    return Row(
      children: [
        Icon(Icons.check_circle, color: textColor, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            feature,
            style: TextStyle(color: textColor, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
