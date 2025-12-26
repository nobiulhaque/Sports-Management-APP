// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaldmv/core/constants/app_colors.dart';
import 'package:kaldmv/core/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CompletedMatchCard extends StatelessWidget {
  final MatchModel match;
  final Widget? child;
  final String? updateButton;
  final VoidCallback? onTapUpdate;
  final VoidCallback? onTapViewDetails;

  const CompletedMatchCard({
    super.key,
    required this.match,
    this.child,
    this.updateButton,
    this.onTapUpdate,
    this.onTapViewDetails,
  });

  Widget _buildRefereeImage(String image) {
    if (image.isEmpty) {
      return const SizedBox.shrink();
    }

    Widget imageWidget;

    // Check if it's a URL
    if (image.startsWith('http://') || image.startsWith('https://')) {
      imageWidget = Image.network(
        image,
        width: 70.w,
        height: 90.h,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: 70.w,
            height: 90.h,
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
        width: 70.w,
        height: 90.h,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
      );
    }

    return Container(
      width: 70.w,
      height: 90.h,
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

  Widget _buildImage(String path, {BoxFit fit = BoxFit.cover}) {
    if (path.startsWith('http') || path.startsWith('https')) {
      return CachedNetworkImage(
        imageUrl: path,
        fit: fit,
        placeholder: (context, url) => Center(
          child: SizedBox(
            width: 20.w,
            height: 20.h,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        errorWidget: (context, url, error) => Icon(Icons.sports_soccer),
      );
    } else {
      return Image.asset(
        path,
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            Container(color: Colors.grey[200]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.transparent, width: 1.w),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/bg/upcoming-matches-bg.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),

            Positioned.fill(
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
            ),

            Padding(
              padding: EdgeInsets.only(
                left: 10.r,
                right: 100.r,
                top: 16.r,
                bottom: 13.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Team 1
                      Expanded(
                        flex: 1,
                        child: Column(
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
                              padding: EdgeInsets.all(5.r),
                              child: ClipOval(
                                child: _buildImage(
                                  match.team1Logo,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              match.team1Name,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      // Score
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10.w,
                          right: 10.w,
                          bottom: 20.h,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5.r),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            '${match.t1score} - ${match.t2score}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      // Team 2
                      Expanded(
                        flex: 1,
                        child: Column(
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
                              padding: EdgeInsets.all(5.r),
                              child: ClipOval(
                                child: _buildImage(
                                  match.team2Logo,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              match.team2Name,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 4.h),

                  Padding(
                    padding: EdgeInsets.only(left: 10.r),
                    child: Text(
                      match.date,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(height: 8.h),
                  Row(
                    spacing: 8.w,
                    children: [
                      if (updateButton != null)
                        Utils.primaryButton(
                          context: context,
                          title: updateButton,
                          height: 35.h,
                          width: 80.w,
                          fontSize: 14.sp,
                          borderColor: Color(0xFFE2E8F0),
                          backgroundColor: AppColors.white.withAlpha(40),
                          onTap: onTapUpdate,
                        ),
                      Utils.primaryButton(
                        context: context,
                        title: updateButton != null
                            ? "Details"
                            : 'View Details',
                        height: 35.h,
                        width: updateButton != null ? 80.w : 120.w,
                        fontSize: 14.sp,
                        backgroundColor: AppColors.accentGreen,
                        onTap: onTapViewDetails ?? match.onTap,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            if (match.refereeImage.isNotEmpty)
              Positioned(
                right: 10.w,
                top: 50.h,
                child: _buildRefereeImage(match.refereeImage),
              ),

            child != null
                ? Positioned(right: 0, bottom: 0, child: child!)
                : Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2.r),
                          bottomRight: Radius.circular(10.r),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '⭐${match.rate}/',
                            style: TextStyle(
                              fontFamily: 'Anton',
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w800,
                              color: AppColors.white,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '5',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: 'Anton',
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w800,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class MatchModel {
  final String team1Logo;
  final String team1Name;
  final int t1score;
  final String team2Logo;
  final String team2Name;
  final int t2score;
  final String date;
  final String refereeImage;
  final double rate;
  final VoidCallback onTap;

  MatchModel({
    required this.team1Logo,
    required this.team1Name,
    required this.t1score,
    required this.team2Logo,
    required this.team2Name,
    required this.t2score,
    required this.date,
    required this.refereeImage,
    required this.rate,
    required this.onTap,
  });
}
