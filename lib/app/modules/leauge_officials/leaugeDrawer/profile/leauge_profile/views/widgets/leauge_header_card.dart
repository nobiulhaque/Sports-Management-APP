import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:kaldmv/app/widgets/custom_profile_card.dart';
import 'package:kaldmv/core/constants/app_colors.dart';

class LeagueHeaderCard extends StatelessWidget {
  final String leagueName;
  final String email;
  final String leagueType;
  final String foundedYear;
  final String? logoPath;
  final String profileImage;

  const LeagueHeaderCard({
    super.key,
    required this.leagueName,
    required this.email,
    required this.leagueType,
    required this.foundedYear,
    this.logoPath,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return CustomProfileCard(
      elevation: 2,
      color: AppColors.primary,
      borderRadius: 20,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            _buildLeagueAvatar(),
            SizedBox(height: 20.h),
            _buildLeagueInfo(),
            SizedBox(height: 38.h),
          ],
        ),
      ),
    );
  }

  Widget _buildLeagueAvatar() {
    final bool isNetworkImage =
        profileImage.startsWith('http://') ||
        profileImage.startsWith('https://');

    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 45.r,
            backgroundColor: Colors.white,
            backgroundImage: isNetworkImage
                ? NetworkImage(profileImage)
                : AssetImage(profileImage) as ImageProvider,
          ),
        ],
      ),
    );
  }

  Widget _buildLeagueInfo() {
    return Column(
      children: [
        Center(
          child: Text(
            leagueName,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        _buildInfoText(email),
        if (leagueType != 'N/A' && leagueType.isNotEmpty) ...[
          SizedBox(height: 5.h),
          _buildInfoText(leagueType),
        ],
        if (foundedYear != 'Founded in N/A' && foundedYear.isNotEmpty) ...[
          SizedBox(height: 5.h),
          _buildInfoText(foundedYear),
        ],
      ],
    );
  }

  Widget _buildInfoText(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 14.sp, color: const Color(0xFFBEDBFF)),
      ),
    );
  }
}
