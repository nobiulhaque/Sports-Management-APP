// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Performance Data Model for Chart
class PerformanceData {
  final String month;
  final double rating;
  PerformanceData({required this.month, required this.rating});
}

class PerformanceProgressWidget extends StatelessWidget {
  final List<PerformanceData> performanceData;

  const PerformanceProgressWidget({super.key, required this.performanceData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: Colors.grey.shade200, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Performance Progress",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            "Track your growth and consistency over time\nbased on feedback and ratings.",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13.sp,
              height: 1.25,
            ),
          ),
          SizedBox(height: 18.h),
          // Chart Section Only
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 3.w),
            height: 200.h,
            child: LineChartWidget(data: performanceData),
          ),
        ],
      ),
    );
  }
}

// Chart Widget remains unchanged
class LineChartWidget extends StatelessWidget {
  final List<PerformanceData> data;
  const LineChartWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, double.infinity),
      painter: LineChartPainter(data),
    );
  }
}

class LineChartPainter extends CustomPainter {
  final List<PerformanceData> data;
  LineChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    double chartLeft = 33.w;
    double chartTop = 10.h;
    double chartRight = size.width - 6.w;
    double chartBottom = size.height - 22.h;
    double chartHeight = chartBottom - chartTop;
    double chartWidth = chartRight - chartLeft;

    // Y-axis scaling - handle 0 values
    final double minY = 0.0;
    final double maxY = 5.0;

    Paint gridPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.grey.shade300
      ..strokeWidth = 1;

    TextPainter tp = TextPainter(
      textAlign: TextAlign.right,
      textDirection: TextDirection.ltr,
    );

    for (double y = minY; y <= maxY; y += 1.0) {
      double yPos = chartBottom - ((y - minY) / (maxY - minY)) * chartHeight;
      canvas.drawLine(
        Offset(chartLeft, yPos),
        Offset(chartRight, yPos),
        gridPaint,
      );

      tp.text = TextSpan(
        text: y.toStringAsFixed(1),
        style: TextStyle(color: Colors.grey.shade500, fontSize: 10.sp),
      );
      tp.layout(minWidth: 0, maxWidth: chartLeft - 6.w);
      tp.paint(canvas, Offset(0, yPos - 8.h));
    }

    // Draw x-axis labels
    int count = data.length;
    for (int i = 0; i < count; i++) {
      double x = chartLeft + (i / (count - 1)) * chartWidth;
      tp.text = TextSpan(
        text: data[i].month.substring(0, 3),
        style: TextStyle(color: Colors.grey.shade700, fontSize: 10.sp),
      );
      tp.layout(minWidth: 0, maxWidth: 40.w);
      tp.paint(canvas, Offset(x - 12.w, chartBottom + 6.h));
    }

    // Draw line and points
    Paint linePaint = Paint()
      ..color = Colors.amber.shade800
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    Path path = Path();

    for (int i = 0; i < count; i++) {
      double x = chartLeft + (i / (count - 1)) * chartWidth;
      double y =
          chartBottom - ((data[i].rating - minY) / (maxY - minY)) * chartHeight;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, linePaint);

    Paint pointPaint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.fill;
    for (int i = 0; i < count; i++) {
      double x = chartLeft + (i / (count - 1)) * chartWidth;
      double y =
          chartBottom - ((data[i].rating - minY) / (maxY - minY)) * chartHeight;
      canvas.drawCircle(Offset(x, y), 4.r, pointPaint);
      canvas.drawCircle(
        Offset(x, y),
        4.r,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
