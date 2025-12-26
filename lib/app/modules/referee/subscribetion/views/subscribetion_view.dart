import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/subscribetion_controller.dart';

class SubscribetionView extends GetView<SubscribetionController> {
  const SubscribetionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 10.0,
                ),
                child: GestureDetector(
                  onTap: () => Get.toNamed('/referee-home'),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),

            // Carousel
            SizedBox(
              height:
                  280, // makes it taller, you can adjust this (e.g., 350–450)
              width: double.infinity,
              child: PageView.builder(
                controller: controller.pageController,
                itemBuilder: (context, index) {
                  final realIndex = controller.getRealIndex(index);
                  return Obx(() {
                    final scale = (index - controller.currentPage.value).abs();
                    final scaleFactor = 1 - (scale * 0.4).clamp(0.0, 0.1);
                    return Transform.scale(
                      scale: scaleFactor,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          controller.images[realIndex],
                          fit: BoxFit
                              .cover, // keeps good proportion and fills frame
                          alignment: Alignment.center,
                        ),
                      ),
                    );
                  });
                },
              ),
            ),

            const SizedBox(height: 20),

            // Feature list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: const [
                  FeatureItem(text: "AI Match Insights"),
                  FeatureItem(text: "Priority Match Notification"),
                  FeatureItem(text: "Skill & Knowledge Hub"),
                  FeatureItem(text: "Performance Analytics"),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Plans
            Obx(() {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    PlanTile(
                      label: "YEARLY ACCESS",
                      price: "\$600.00",
                      subtitle: "per year",
                      isSelected: controller.selectedPlan.value == Plan.yearly,
                      tag: "BEST OFFER",
                      onTap: () => controller.selectPlan(Plan.yearly),
                    ),
                    const SizedBox(height: 12),
                    PlanTile(
                      label: "MONTHLY ACCESS",
                      price: "\$90.00",
                      subtitle: "per month",
                      isSelected: controller.selectedPlan.value == Plan.monthly,
                      onTap: () => controller.selectPlan(Plan.monthly),
                    ),
                  ],
                ),
              );
            }),

            const Spacer(),

            // Purchase button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: SizedBox(
                width: double.infinity,
                height: 70,
                child: ElevatedButton(
                  onPressed: controller.onPurchase,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Purchase Now",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String text;
  const FeatureItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const Icon(Icons.check_box, color: Color(0xFF10B981)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlanTile extends StatelessWidget {
  final String label;
  final String price;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final String? tag;

  const PlanTile({
    super.key,
    required this.label,
    required this.price,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
    this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFD1FAE5) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF10B981) : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            if (tag != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  tag!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (tag != null) const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
