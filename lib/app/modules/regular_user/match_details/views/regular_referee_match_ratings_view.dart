import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../widgets/app_bar_widgets.dart';
import '../controllers/regular_referee_match_ratings_controller.dart';

class RegularRefereeMatchRatingsView extends StatelessWidget {
  const RegularRefereeMatchRatingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegularRefereeMatchRatingsController());
    final Map<String, dynamic> args = Get.arguments ?? {};
    final String matchId = args['matchId'] ?? '';
    final String refereeId = args['refereeId'] ?? '';

    if (matchId.isNotEmpty && refereeId.isNotEmpty) {
      controller.fetchRefereeMatchRatings(matchId, refereeId);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Ratings'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.ratingsData.value;
        if (data == null) {
          return const Center(child: Text('No ratings data available'));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              // Top Section: Match Info + Referee Profile Info
              _buildTopSection(data),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),

                    // Match Statistics Section
                    _buildSectionTitle('Match Statistics'),
                    SizedBox(height: 12.h),
                    _buildMatchStatisticsGrid(data.match),

                    SizedBox(height: 24.h),

                    Row(
                      children: [
                        Icon(
                          Icons.stars,
                          color: const Color(0xFFFBBF24),
                          size: 24.w,
                        ),
                        SizedBox(width: 8.w),
                        _buildSectionTitle('Regular User Feedback'),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Show Category Averages from API
                    _buildCategoryAverages(data),

                    SizedBox(height: 32.h),

                    // Review Input Section (Interactive)
                    _buildSectionTitle('Rate this Match'),
                    SizedBox(height: 16.h),
                    _buildReviewInputSection(controller, matchId, refereeId),

                    SizedBox(height: 32.h),

                    // Feedback List Header
                    if (data.allFeedback.isNotEmpty) ...[
                      _buildSectionTitle('User Reviews'),
                      SizedBox(height: 16.h),
                    ],

                    // List of Feedbacks
                    if (data.allFeedback.isEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Center(
                          child: Text(
                            'No feedback available for this match yet.',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color(0xFF9CA3AF),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      )
                    else
                      ...data.allFeedback
                          .map((fb) => _buildFeedbackCard(fb))
                          ,

                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTopSection(RefereeMatchRatingsData data) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFE8EAFF).withOpacity(0.5),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF1E40AF).withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      child: Column(
        children: [
          // Match Summary (Teams + Score)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSmallTeamLogo(data.match.team1Logo),
              SizedBox(width: 12.w),
              _buildScoreBadge(data.match.team1Goal, data.match.team2Goal),
              SizedBox(width: 12.w),
              _buildSmallTeamLogo(data.match.team2Logo),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            '${data.match.team1Name}   Vs   ${data.match.team2Name}',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1F2937),
            ),
          ),
          SizedBox(height: 12.h),

          // Match Details (Date, Location)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSmallMatchDetail(Icons.calendar_today, data.matchStartDate),
              SizedBox(width: 16.w),
              _buildSmallMatchDetail(Icons.access_time, data.match.matchTime),
            ],
          ),
          SizedBox(height: 6.h),
          _buildSmallMatchDetail(Icons.location_on, data.match.location),

          SizedBox(height: 24.h),

          // Referee Info
          _buildRefereeAvatar(data.referee.user.image),
          SizedBox(height: 12.h),
          Text(
            data.referee.user.name,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1F2937),
            ),
          ),
          Text(
            _formatRole(data.referee.user.role),
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF6B7280),
            ),
          ),

          SizedBox(height: 24.h),

          // Overall Match Rating Card
          _buildOverallRatingCard(data.roundedAverage),
        ],
      ),
    );
  }

  Widget _buildSmallTeamLogo(String logoUrl) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(6.w),
      child: logoUrl.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: logoUrl,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.sports_soccer, color: Colors.grey, size: 20),
              fit: BoxFit.contain,
            )
          : const Icon(Icons.sports_soccer, color: Colors.grey, size: 20),
    );
  }

  Widget _buildScoreBadge(int t1, int t2) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFF6B7280),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        '$t1 - $t2',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSmallMatchDetail(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.w, color: const Color(0xFF6B7280)),
        SizedBox(width: 4.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }

  Widget _buildRefereeAvatar(String? imageUrl) {
    return Container(
      width: 80.w,
      height: 80.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipOval(
        child: imageUrl != null && imageUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Container(
                  color: const Color(0xFFE8EAFF),
                  child: Icon(Icons.person, size: 40.w, color: Colors.grey),
                ),
              )
            : Container(
                color: const Color(0xFFE8EAFF),
                child: Icon(Icons.person, size: 40.w, color: Colors.grey),
              ),
      ),
    );
  }

  Widget _buildOverallRatingCard(double rating) {
    String label = "Average Performance";
    if (rating >= 4.5) {
      label = "Outstanding Performance";
    } else if (rating >= 4.0) {
      label = "Great Performance";
    }

    return Container(
      width: 280.w,
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E40AF).withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Overall Match Rating',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF6B7280),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(Icons.star, color: const Color(0xFFFBBF24), size: 36.w),
              SizedBox(width: 8.w),
              Text(
                rating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 42.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1F2937),
                  height: 1,
                ),
              ),
              Text(
                ' / 5',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF9CA3AF),
                  height: 1.8,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF10B981),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF1F2937),
      ),
    );
  }

  Widget _buildMatchStatisticsGrid(MatchRatingsBasicInfo match) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12.w,
      crossAxisSpacing: 12.w,
      childAspectRatio: 2.2,
      children: [
        _buildStatCard(
          'Yellow Cards',
          match.yellowCards.toString(),
          const Color(0xFFFEF3C7),
          const Color(0xFFD97706),
        ),
        _buildStatCard(
          'Red Cards',
          match.redCards.toString(),
          const Color(0xFFFEE2E2),
          const Color(0xFFDC2626),
        ),
        _buildStatCard(
          'Fouls Called',
          match.foulsCalled.toString(),
          const Color(0xFFEFF6FF),
          const Color(0xFF2563EB),
        ),
        _buildStatCard(
          'Offsides',
          match.offsides.toString(),
          const Color(0xFFF5F3FF),
          const Color(0xFF7C3AED),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    Color bgColor,
    Color textColor,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: textColor.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryAverages(RefereeMatchRatingsData data) {
    return Column(
      children: [
        _buildStaticRatingRow('Fairness', data.avgFairness),
        _buildStaticRatingRow('Control', data.avgControl),
        _buildStaticRatingRow('Positioning', data.avgPositioning),
        _buildStaticRatingRow('Communication', data.avgCommunication),
      ],
    );
  }

  Widget _buildStaticRatingRow(String label, double rating) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF6B7280),
            ),
          ),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < rating.round() ? Icons.star : Icons.star_border,
                color: const Color(0xFFFBBF24),
                size: 20.w,
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewInputSection(
    RegularRefereeMatchRatingsController controller,
    String matchId,
    String refereeId,
  ) {
    return Column(
      children: [
        Text(
          'Share your experience with the referee',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF6B7280),
          ),
        ),
        SizedBox(height: 16.h),
        Obx(
          () => _buildInteractiveRatingRow(
            'Fairness',
            controller.fairness.value,
            (val) => controller.fairness.value = val,
          ),
        ),
        Obx(
          () => _buildInteractiveRatingRow(
            'Control',
            controller.control.value,
            (val) => controller.control.value = val,
          ),
        ),
        Obx(
          () => _buildInteractiveRatingRow(
            'Positioning',
            controller.positioning.value,
            (val) => controller.positioning.value = val,
          ),
        ),
        Obx(
          () => _buildInteractiveRatingRow(
            'Communication',
            controller.communication.value,
            (val) => controller.communication.value = val,
          ),
        ),
        SizedBox(height: 24.h),
        // Comment Input
        Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: const Color(0xFFF3F4F6),
              child: Icon(Icons.person, size: 20.w, color: Colors.grey),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22.r),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.commentController,
                        decoration: InputDecoration(
                          hintText: 'Add a comment...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => controller.isSubmitting.value
                          ? SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : InkWell(
                              onTap: () =>
                                  controller.submitReview(matchId, refereeId),
                              child: Icon(
                                Icons.send,
                                color: const Color(0xFF1E40AF),
                                size: 20.w,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInteractiveRatingRow(
    String label,
    int rating,
    Function(int) onRatingChanged,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF6B7280),
            ),
          ),
          Row(
            children: List.generate(5, (index) {
              return InkWell(
                onTap: () => onRatingChanged(index + 1),
                child: Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: const Color(0xFFFBBF24),
                  size: 24.w,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackCard(FeedbackItem fb) {
    print(
      'Rendering feedback card for: ${fb.reviewer.name}, Comment: ${fb.comment}',
    );
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16.r,
                backgroundColor: const Color(0xFFE8EAFF),
                child:
                    fb.reviewer.image != null && fb.reviewer.image!.isNotEmpty
                    ? ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: fb.reviewer.image!,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Icon(
                            Icons.person,
                            size: 18.w,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : Icon(Icons.person, size: 18.w, color: Colors.grey),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fb.reviewer.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  Text(
                    'Anonymous', // Or actual title if available
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(Icons.star, color: const Color(0xFFFBBF24), size: 14.w),
                  SizedBox(width: 4.w),
                  Text(
                    '${fb.overallRating}/5',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF374151),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Text(
              fb.comment,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF1F2937), // Darker for better visibility
                height: 1.6,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          _buildSmallRatingRow('Fairness', fb.fairness.toDouble()),
          _buildSmallRatingRow('Control', fb.control.toDouble()),
          _buildSmallRatingRow('Positioning', fb.positioning.toDouble()),
          _buildSmallRatingRow('Communication', fb.communication.toDouble()),
        ],
      ),
    );
  }

  Widget _buildSmallRatingRow(String label, double rating) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12.sp, color: const Color(0xFF6B7280)),
          ),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: const Color(0xFFFBBF24),
                size: 14.w,
              );
            }),
          ),
        ],
      ),
    );
  }

  String _formatRole(String role) {
    if (role.isEmpty) return '';
    // Special cases
    if (role == 'MAIN_REFEREE') return 'Referee';
    if (role.startsWith('ASS_REFEREE')) return 'Asst. Referee';
    if (role == 'FOURTH_REFEREE') return '4th Official';

    return role
        .replaceAll('_', ' ')
        .split(' ')
        .map((str) => str.capitalize)
        .join(' ');
  }
}
