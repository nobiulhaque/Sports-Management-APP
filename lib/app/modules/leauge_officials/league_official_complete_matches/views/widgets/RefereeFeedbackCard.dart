import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaldmv/core/constants/app_colors.dart';

class RefereeFeedbackCard extends StatelessWidget {
  const RefereeFeedbackCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(12.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Row(
            children: [
              // Profile Image
              Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1579952363873-27f3bade9f55?w=200&h=200&fit=crop',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              // Name and Role
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Anonymous',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF101828),
                      ),
                    ),
                    Text(
                      'Referee',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6A7282),
                      ),
                    ),
                  ],
                ),
              ),
              // Rating
              Row(
                children: [
                  Icon(Icons.star, color: Color(0xFFFFB216), size: 16.r),
                  SizedBox(width: 4),
                  Text(
                    '4/5',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.hintTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          // Team Section
          Container(
            padding: EdgeInsets.all(10.r),
            margin: EdgeInsets.symmetric(horizontal: 2.5.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F5FF),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                // Team Logo
                Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/FC_Bayern_M%C3%BCnchen_logo_%282017%29.svg/200px-FC_Bayern_M%C3%BCnchen_logo_%282017%29.svg.png',
                  fit: BoxFit.contain,
                  width: 40.w,
                  height: 40.h,
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FC Bayarn',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.hintTextColor,
                      ),
                    ),
                    Text(
                      'Winner',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSubtle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Review Text
          Text(
            '"Team showed strong sportsmanship, clear communication, good sideline control, and parents stayed respectful throughout the match."',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
              color: Color(0xFF364153),
            ),
          ),
          SizedBox(height: 16.h),
          // Rating Categories
          _buildRatingRow(context, 'Sportsmanship', 4),
          const SizedBox(height: 16),
          _buildRatingRow(context, 'Respect Towards\nOfficials', 4),
          const SizedBox(height: 16),
          _buildRatingRow(context, 'Coaching Conduct', 4),
          const SizedBox(height: 16),
          _buildRatingRow(context, 'Parents/Spectator\nBehavior', 4),
        ],
      ),
    );
  }

  Widget _buildRatingRow(BuildContext context, String label, int rating) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.hintTextColor,
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Icon(
                  Icons.star,
                  color: index < rating
                      ? const Color(0xFFFFB216)
                      : Color(0xFFE2E8F0),
                  size: 18.r,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
