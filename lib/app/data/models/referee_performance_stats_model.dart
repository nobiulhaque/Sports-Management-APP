import 'package:flutter/material.dart';

class RefereePerformanceStats {
  final double averageRating;
  final String level;
  final int totalMatches;

  RefereePerformanceStats({
    required this.averageRating,
    required this.level,
    required this.totalMatches,
  });

  factory RefereePerformanceStats.fromJson(Map<String, dynamic> json) {
    return RefereePerformanceStats(
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      level: json['level'] ?? 'REGIONAL_LEVEL',
      totalMatches: json['totalMatches'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'averageRating': averageRating,
      'level': level,
      'totalMatches': totalMatches,
    };
  }

  String get levelDisplayName {
    switch (level.toUpperCase()) {
      case 'REGIONAL_LEVEL':
        return 'Regional Level';
      case 'NATIONAL_LEVEL':
        return 'National Level';
      case 'INTERNATIONAL_LEVEL':
        return 'International Level';
      case 'STATE_LEVEL':
        return 'State Level';
      case 'DISTRICT_LEVEL':
        return 'District Level';
      default:
        return level;
    }
  }

  String get performanceDescription {
    if (averageRating >= 4.5) {
      return 'Outstanding performance';
    } else if (averageRating >= 4.0) {
      return 'Excellent performance';
    } else if (averageRating >= 3.5) {
      return 'Good performance';
    } else if (averageRating >= 3.0) {
      return 'Average performance';
    } else {
      return 'Needs improvement';
    }
  }

  Color get performanceColor {
    if (averageRating >= 4.5) {
      return const Color(0xFF00A63E); // Green
    } else if (averageRating >= 4.0) {
      return const Color(0xFF2563EB); // Blue
    } else if (averageRating >= 3.5) {
      return const Color(0xFFD08700); // Orange
    } else {
      return const Color(0xFFF74C3C); // Red
    }
  }
}
