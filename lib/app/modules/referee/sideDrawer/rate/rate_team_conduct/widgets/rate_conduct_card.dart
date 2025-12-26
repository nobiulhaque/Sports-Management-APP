// ignore_for_file: prefer_interpolation_to_compose_strings, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/rate_card_model.dart';

class RateTeamConductCard extends StatelessWidget {
  final RateConductData rateData;
  final VoidCallback onStartRating;

  const RateTeamConductCard({
    super.key,
    required this.rateData,
    required this.onStartRating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Stack(
          children: [
            const _Background(),
            const _GradientOverlay(),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 100.w, top: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TeamsSection(rateData: rateData),
                  SizedBox(height: 4.h),
                  _MatchDate(date: rateData.matchDate ?? ''),
                  SizedBox(height: 8.h),
                  _StartRatingButton(onStartRating: onStartRating),
                ],
              ),
            ),
            _RefereeImage(
              image: rateData.mainRefereeDetails?.referee?.user?.image ?? '',
            ),
            _RefereeInfo(rateData: rateData),
          ],
        ),
      ),
    );
  }
}

// ====================== Background ===========================
class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        'assets/bg/upcoming-matches-bg.png',
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    );
  }
}

// ====================== Gradient Overlay ======================
class _GradientOverlay extends StatelessWidget {
  const _GradientOverlay();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.2),
              Colors.black.withOpacity(0.5),
            ],
          ),
        ),
      ),
    );
  }
}

// ====================== Teams Section ==========================
class _TeamsSection extends StatelessWidget {
  final RateConductData rateData;

  const _TeamsSection({required this.rateData});

  String _formatScore() {
    final team1 = rateData.team1Goal ?? 0;
    final team2 = rateData.team2Goal ?? 0;
    return '$team1 - $team2';
  }

  @override
  Widget build(BuildContext context) {
    final score = _formatScore();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _TeamItem(
            logo: rateData.team1Logo ?? '',
            name: rateData.team1Name ?? '',
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h, left: 8.w, right: 8.w),
          child: Column(
            children: [
              Text(
                score,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Final',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: _TeamItem(
            logo: rateData.team2Logo ?? '',
            name: rateData.team2Name ?? '',
          ),
        ),
      ],
    );
  }
}

// ====================== Single Team Item =======================
class _TeamItem extends StatelessWidget {
  final String logo;
  final String name;

  const _TeamItem({required this.logo, required this.name});

  Widget _buildTeamLogo(String logo) {
    if (logo.isEmpty) {
      return Icon(Icons.sports_soccer, size: 20.w, color: Colors.grey);
    }

    // Check if it's a URL
    if (logo.startsWith('http://') || logo.startsWith('https://')) {
      return Image.network(
        logo,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          print('Error loading logo: $logo, Error: $error');
          return Icon(Icons.sports_soccer, size: 20.w, color: Colors.grey);
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: SizedBox(
              width: 20.w,
              height: 20.w,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
      );
    }

    // Otherwise treat as asset
    return Icon(Icons.sports_soccer, size: 20.w, color: Colors.grey);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: EdgeInsets.all(10.w),
          child: _buildTeamLogo(logo),
        ),
        SizedBox(height: 4.h),
        Text(
          name,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

// ====================== Match Date =============================
class _MatchDate extends StatelessWidget {
  final String date;

  const _MatchDate({required this.date});

  String _formatDate(String dateStr) {
    if (dateStr.isEmpty) return '';
    try {
      // Parse ISO format date
      final parsedDate = DateTime.parse(dateStr);
      final monthNames = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      final month = monthNames[parsedDate.month - 1];
      return '$month ${parsedDate.day}, ${parsedDate.year} (Completed)';
    } catch (e) {
      // If parsing fails, return original string
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = _formatDate(date);
    return Text(
      formattedDate,
      style: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}

// ====================== Start Rating Button ======================
class _StartRatingButton extends StatelessWidget {
  final VoidCallback onStartRating;

  const _StartRatingButton({required this.onStartRating});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: ElevatedButton(
        onPressed: onStartRating,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10B93A),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
          ),
          elevation: 0,
        ),
        child: Text(
          'Start Rating',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

// ====================== Referee Image ==========================
class _RefereeImage extends StatelessWidget {
  final String image;

  const _RefereeImage({required this.image});

  Widget _buildRefereeImage(String image) {
    if (image.isEmpty) {
      return const SizedBox.shrink();
    }

    Widget imageWidget;

    // Check if it's a URL
    if (image.startsWith('http://') || image.startsWith('https://')) {
      imageWidget = Image.network(
        image,
        width: 90.w,
        height: 150.h,
        fit: BoxFit.cover,
        errorBuilder: (_, error, __) {
          print('Error loading referee image: $error');
          return Container(
            width: 90.w,
            height: 150.h,
            color: Colors.grey.shade300,
            child: Icon(Icons.person, size: 40.w, color: Colors.grey.shade600),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: 90.w,
            height: 150.h,
            color: Colors.grey.shade200,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[400]!),
              ),
            ),
          );
        },
      );
    } else {
      // Otherwise treat as asset
      imageWidget = Image.asset(
        image,
        width: 90.w,
        height: 150.h,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return Container(
            width: 90.w,
            height: 150.h,
            color: Colors.grey.shade300,
            child: Icon(Icons.person, size: 40.w, color: Colors.grey.shade600),
          );
        },
      );
    }

    return Container(
      width: 90.w,
      height: 150.h,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.white, width: 3.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.r),
        child: imageWidget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (image.isEmpty) {
      return const SizedBox.shrink();
    }

    return Positioned(right: 10.w, top: 50.h, child: _buildRefereeImage(image));
  }
}

// ====================== Referee Info ============================
class _RefereeInfo extends StatelessWidget {
  final RateConductData rateData;

  const _RefereeInfo({required this.rateData});

  @override
  Widget build(BuildContext context) {
    final refereeName = rateData.mainRefereeDetails?.referee?.user?.name ?? '';

    if (refereeName.isEmpty) {
      return const SizedBox.shrink();
    }

    return Positioned(
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(2.r),
            bottomRight: Radius.circular(10.r),
          ),
        ),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.end,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              refereeName + " / ",
              style: TextStyle(
                fontFamily: 'Anton',
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E3A8A),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Match official',
              style: TextStyle(
                fontFamily: 'Anton',
                fontSize: 8.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
