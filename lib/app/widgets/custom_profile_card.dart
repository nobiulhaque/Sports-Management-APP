import 'package:flutter/material.dart';

class CustomProfileCard extends StatelessWidget {
  final Widget? child; // To allow you to pass any child widget
  final Color? color;
  final double elevation;
  final double borderRadius;

  const CustomProfileCard({
    super.key,
    this.child,
    this.color,
    this.elevation = 0.0, 
    this.borderRadius = 20.0, 
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: elevation,
      // Define the shape with only top corners rounded
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
          bottomLeft: Radius.zero, // No rounding at the bottom
          bottomRight: Radius.zero, // No rounding at the bottom
        ),
      ),
      // The child will be whatever you place inside this custom card
      child: child,
    );
  }
}