import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompleteMatchStatCard extends StatelessWidget {
  final String title;
  final String value;

  const CompleteMatchStatCard({
    super.key,
    required this.title,
    required this.value,
  });

  /// Switch-based dynamic colors
  Map<String, Color> _getColors() {
    switch (title) {
      case 'Yellow Cards':
        return {
          'bg': Color(0xFFFFFBEB),
          'border': Color(0xFFFEF3C6),
          'textColor' : Color(0xFFE17100)
        };
      case 'Red Cards':
        return {
          'bg': Color(0xFFFEF2F2),
          'border': Color(0xFFFFE2E2),
          'textColor' : Color(0xFFE7000B)
        };
      case 'Fouls Called':
        return {
          'bg': Color(0xFFEFF6FF),
          'border': Color(0xFFDBEAFE),
          'textColor' : Color(0xFF155DFC)
        };
      case 'Offsides':
        return {
          'bg': Color(0xFFFAF5FF),
          'border': Color(0xFFF3E8FF),
          'textColor' : Color(0xFF9810FA)
        };
      default:
        return {
          'bg': Colors.grey.shade200,
          'border': Colors.grey,
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = _getColors();

    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: colors['bg'],
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: colors['border']!, width: 1.2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF4A5565),
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
              color: colors['textColor'],
            ),
          ),
        ],
      ),
    );
  }
}
