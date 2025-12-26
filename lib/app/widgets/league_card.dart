import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/data/models/leauge_card_model.dart';
import 'package:kaldmv/app/widgets/shared/shared_league_profile_controller.dart';
import 'package:kaldmv/app/widgets/shared/shared_league_profile_view.dart';
import 'package:kaldmv/core/constants/app_colors.dart';
import 'package:kaldmv/core/services/api_service.dart';
import 'package:kaldmv/core/services/api_exception.dart';

class LeagueCard extends StatefulWidget {
  final Data league;
  final VoidCallback onRequest;
  final Function(String leagueId) onToggleSave;
  final bool showSaveButton;

  const LeagueCard({
    super.key,
    required this.league,
    required this.onRequest,
    required this.onToggleSave,
    this.showSaveButton = true,
    this.isRegularUser = false,
  });

  final bool isRegularUser;

  @override
  State<LeagueCard> createState() => _LeagueCardState();
}

class _LeagueCardState extends State<LeagueCard> {
  late bool _requestSent;
  bool _isLoading = false;
  final ApiService _apiService = ApiService();

  // Constants
  static const Duration _snackbarDuration = Duration(seconds: 3);
  static const Color _errorColor = Color(0xFFCCCCCC);
  static const Color _borderColor = Color(0xFFE5E7EB);
  static const Color _backgroundColor = Color(0xFFF3F4F6);
  static const Color _textGray = Color(0xFF6B7280);
  static const Color _badgeBgColor = Color(0xFFDCEEF5);
  static const Color _badgeTextColor = Color(0xFF1E40AF);
  static const Color _successSnackbar = Color(0xFF4CAF50);
  static const Color _errorSnackbar = Color(0xFFEF5350);

  @override
  void initState() {
    super.initState();
    _requestSent = widget.league.requestStatus?.toUpperCase() == 'PENDING';
  }

  void _showSnackbar(String title, String message, Color bgColor) {
    Get.snackbar(
      title,
      message,
      duration: _snackbarDuration,
      backgroundColor: bgColor,
      colorText: Colors.white,
    );
  }

  Future<void> _sendRequest() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      // Check if request is pending by checking the status
      final isPending = widget.league.requestStatus?.toUpperCase() == 'PENDING';

      print(
        '🔍 Debug: isPending=$isPending, requestId=${widget.league.requestId}, requestStatus=${widget.league.requestStatus}',
      );

      // If request is already sent (pending), cancel it
      if (isPending &&
          widget.league.requestId != null &&
          widget.league.requestId!.isNotEmpty) {
        print('🗑️ Cancelling request with ID: ${widget.league.requestId}');

        final response = await _apiService.delete<Map<String, dynamic>>(
          path: '/referee/cancel-league-request',
          data: {'requestId': widget.league.requestId},
        );

        if (response != null) {
          final message =
              response['message'] ?? 'Request cancelled successfully';
          final isSuccess = response['success'] == true;

          if (isSuccess) {
            setState(() => _requestSent = false);
            widget.onRequest();
          } else {
            _showSnackbar('Error', message, _errorSnackbar);
          }
        } else {
          _showSnackbar('Error', 'No response from server', _errorSnackbar);
        }
      } else {
        // Send new request
        print('📤 Sending new request for league: ${widget.league.id}');

        final response = await _apiService.post<Map<String, dynamic>>(
          path: '/referee/send-request-league',
          data: {'leagueId': widget.league.id},
        );

        if (response != null) {
          final message = response['message'] ?? 'Request sent successfully';
          final isSuccess = response['success'] == true;

          if (isSuccess) {
            setState(() => _requestSent = true);
            _showSnackbar('Success', message, _successSnackbar);
            widget.onRequest();
          } else {
            _showSnackbar('Error', message, _errorSnackbar);
          }
        } else {
          _showSnackbar('Error', 'No response from server', _errorSnackbar);
        }
      }
    } on ApiException catch (e) {
      _showSnackbar('Error', e.message, _errorSnackbar);
    } catch (e) {
      _showSnackbar('Error', 'Failed to process request', _errorSnackbar);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildLeagueAvatar() {
    return Container(
      width: 48.w,
      height: 48.w,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: _backgroundColor,
      ),
      child: widget.league.user?.image != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(50.r),
              child: Image.network(
                widget.league.user!.image!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildDefaultIcon(),
              ),
            )
          : _buildDefaultIcon(),
    );
  }

  Widget _buildDefaultIcon() {
    return Icon(Icons.sports_soccer, size: 24.sp, color: _textGray);
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          Icon(icon, size: 14.sp, color: _textGray),
          SizedBox(width: 4.w),
          Text(
            text,
            style: TextStyle(fontSize: 12.sp, color: _textGray),
          ),
        ],
      ),
    );
  }

  Widget _buildLeagueInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.league.user?.name ?? 'Unknown',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.h),
          _buildInfoRow(
            Icons.emoji_events_outlined,
            widget.league.organizationId?.isNotEmpty == true
                ? '#${widget.league.organizationId!}'
                : 'N/A',
          ),
          _buildInfoRow(
            Icons.account_balance_outlined,
            widget.league.founded != null && widget.league.founded! > 0
                ? 'Founded in ${widget.league.founded}'
                : 'N/A',
          ),
          _buildInfoRow(
            Icons.location_on_outlined,
            widget.league.country?.isNotEmpty == true
                ? widget.league.country!
                : 'N/A',
          ),
          if (widget.league.level != null && widget.league.level!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _badgeBgColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  widget.league.level!,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: _badgeTextColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return GestureDetector(
      onTap: () => widget.onToggleSave(widget.league.id ?? ''),
      child: Icon(
        (widget.league.isSaved ?? false)
            ? Icons.favorite
            : Icons.favorite_border,
        color: (widget.league.isSaved ?? false) ? _badgeTextColor : _textGray,
        size: 25.sp,
      ),
    );
  }

  Widget _buildRequestButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _sendRequest,
      style: ElevatedButton.styleFrom(
        backgroundColor: _requestSent
            ? AppColors.primary
            : AppColors.accentGreen,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        elevation: 0,
        disabledBackgroundColor: _errorColor,
      ),
      child: _isLoading
          ? SizedBox(
              height: 20.h,
              width: 20.h,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
              _requestSent ? 'Cancel' : 'Request',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
    );
  }

  Widget _buildViewProfileButton() {
    return OutlinedButton(
      onPressed: _goToProfile,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        side: const BorderSide(color: _borderColor, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      child: Text(
        'View Profile',
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildRegularViewProfileButton() {
    return ElevatedButton(
      onPressed: _goToProfile,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accentGreen,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        elevation: 0,
      ),
      child: Text(
        'View Profile',
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
      ),
    );
  }

  void _goToProfile() {
    Get.put(
      SharedLeagueProfileController(leagueId: widget.league.id ?? ''),
      tag: widget.league.id,
    );
    Get.to(
      () => SharedLeagueProfileView(leagueId: widget.league.id ?? ''),
      arguments: widget.league.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _borderColor, width: 1),
      ),
      child: Column(
        children: [
          // Header Row: Avatar, Info, Save Button
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLeagueAvatar(),
              SizedBox(width: 12.w),
              _buildLeagueInfo(),
              if (widget.showSaveButton) _buildSaveButton(),
            ],
          ),
          SizedBox(height: 12.h),
          // Buttons Row: Request, View Profile
          Row(
            children: [
              if (!widget.isRegularUser) ...[
                Expanded(child: _buildRequestButton()),
                SizedBox(width: 12.w),
              ],
              Expanded(
                child: widget.isRegularUser
                    ? _buildRegularViewProfileButton()
                    : _buildViewProfileButton(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
