import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaldmv/core/constants/app_colors.dart';

class MatchCard extends StatelessWidget {
  final dynamic match;
  final VoidCallback onViewDetails;

  const MatchCard({
    super.key,
    required this.match,
    required this.onViewDetails,
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
                  _TeamsSection(match: match),
                  SizedBox(height: 4.h),
                  _MatchDate(date: match.date, match: match),
                  SizedBox(height: 8.h),
                  _ViewDetailsButton(onViewDetails: onViewDetails),
                ],
              ),
            ),

            _RefereeImage(image: match.refereeImage),
            _RefereeInfo(match: match),
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
  final dynamic match;

  const _TeamsSection({required this.match});

  bool _isCompleted() {
    // Check if match object has status field and if it's COMPLETED
    try {
      return match.status == 'COMPLETED';
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCompleted = _isCompleted();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _TeamItem(logo: match.team1Logo, name: match.team1Name),
        ),
        // Show score only if match is completed
        if (isCompleted)
          Padding(
            padding: EdgeInsets.only(top: 10.h, left: 8.w, right: 8.w),
            child: Column(
              children: [
                Text(
                  '${match.t1score} - ${match.t2score}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Vs',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          )
        else
          Padding(
            padding: EdgeInsets.only(top: 10.h, left: 8.w, right: 8.w),
            child: Text(
              'Vs',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        Expanded(
          child: _TeamItem(logo: match.team2Logo, name: match.team2Name),
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

    // Otherwise treat as asset - show placeholder if asset doesn't exist
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
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
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
  final dynamic match;

  const _MatchDate({required this.date, required this.match});

  String _getStatusText() {
    try {
      String status = match.status ?? 'SCHEDULED';
      if (status == 'COMPLETED') {
        return 'Completed';
      } else if (status == 'SCHEDULED') {
        return 'Upcoming';
      }
      return status;
    } catch (e) {
      return 'Upcoming';
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusText = _getStatusText();

    // Determine status color
    Color statusColor = Colors.grey;
    try {
      String status = match.status ?? 'SCHEDULED';
      if (status == 'COMPLETED') {
        statusColor = AppColors.primary;
      } else if (status == 'SCHEDULED') {
        statusColor = AppColors.accentGreen;
      }
    } catch (e) {
      statusColor = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.15),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            date,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Text(
              statusText,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: statusColor,
                height: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ====================== View Details Button ======================
class _ViewDetailsButton extends StatelessWidget {
  final VoidCallback onViewDetails;

  const _ViewDetailsButton({required this.onViewDetails});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: ElevatedButton(
        onPressed: onViewDetails,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10B93A),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.r),
          ),
          elevation: 2,
          shadowColor: const Color(0xFF10B93A).withOpacity(0.4),
        ),
        child: Text(
          'View Details',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
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
        height: 120.h,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: 90.w,
            height: 120.h,
            color: Colors.grey.shade200,
            child: Center(
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
    } else {
      // Otherwise treat as asset
      imageWidget = Image.asset(
        image,
        width: 90.w,
        height: 120.h,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
      );
    }

    return Container(
      width: 90.w,
      height: 120.h,
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

    return Positioned(right: 10.w, top: 70.h, child: _buildRefereeImage(image));
  }
}

// ====================== Referee Info ============================
class _RefereeInfo extends StatelessWidget {
  final dynamic match;

  const _RefereeInfo({required this.match});

  String _formatRole(String role) {
    // Format role from API format (e.g., "MAIN_REFEREE") to display format
    if (role.isEmpty) return '';
    return role
        .replaceAll('_', ' ')
        .split(' ')
        .map(
          (word) => word.isEmpty
              ? ''
              : word[0].toUpperCase() + word.substring(1).toLowerCase(),
        )
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    // Don't show the widget if there's no referee name
    if (match.refereeName == null || match.refereeName.isEmpty) {
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${match.refereeName}/',
              style: TextStyle(
                fontFamily: 'Anton',
                fontSize: 12.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1E3A8A),
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              _formatRole(match.refereeRole ?? ''),
              textAlign: TextAlign.end,
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
