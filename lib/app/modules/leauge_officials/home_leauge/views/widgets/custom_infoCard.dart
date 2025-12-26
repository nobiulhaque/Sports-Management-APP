import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInfoCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final Widget content;
  final Color? backgroundColor;
  final Color? iconColor;

  const CustomInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.content, this.backgroundColor, this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              color: Color(0xFFE5E7EB),
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // content onujayi height
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header Row
            Row(
              children: [
                Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: backgroundColor ?? const Color(0xFFD9E1F7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: icon),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF101727),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// Card content
            content,
          ],
        ),
      ),
    );
  }
}

/// Example Usage
class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // ← purai page scrollable
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomInfoCard(
              icon: const Icon(Icons.info, color: Colors.blue),
              title: "Info Card 1",
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  20,
                      (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text("Content line ${index + 1}"),
                  ),
                ),
              ),
            ),

            CustomInfoCard(
              icon: const Icon(Icons.warning, color: Colors.orange),
              title: "Info Card 2",
              content: const Text("Short content example."),
            ),
          ],
        ),
      ),
    );
  }
}
