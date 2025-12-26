import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RefereeProfileCardReq extends StatelessWidget {
  final String name;
  final String? rating; // Changed to String to handle optional
  final String experience;
  final String location;
  final String? imagePath;
  final String? status;
  final String? certifyingAuthority;

  final VoidCallback onAccept;
  final VoidCallback onViewProfile;
  final VoidCallback onMessage;

  const RefereeProfileCardReq({
    super.key,
    required this.name,
    this.rating,
    required this.experience,
    required this.location,
    this.imagePath,
    this.status,
    this.certifyingAuthority,
    required this.onAccept,
    required this.onViewProfile,
    required this.onMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 10,
            offset: Offset(0, 0),
            spreadRadius: 0.50,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Profile section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              Container(
                width: 48,
                height: 48,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: const Color(0xFFE8EAFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(48),
                  ),
                ),
                child: imagePath != null && imagePath!.startsWith('http')
                    ? CachedNetworkImage(
                        imageUrl: imagePath!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.sports_soccer,
                          color: Color(0xFF1E3A8A),
                          size: 24,
                        ),
                      )
                    : imagePath != null
                        ? Image.asset(
                            imagePath!,
                            fit: BoxFit.cover,
                          )
                        : const Icon(
                            Icons.sports_soccer,
                            color: Color(0xFF1E3A8A),
                            size: 24,
                          ),
              ),
              const SizedBox(width: 16),
              // Profile Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      name,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Color(0xFF111111),
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 1.50,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Info items
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Rating
                        if (rating != null)
                          _buildInfoRow(Icons.star, rating!, isRating: true),
                        if (rating != null) const SizedBox(height: 8),
                        // Matches
                        _buildInfoRow(Icons.sports_soccer, 'Matches'),
                        const SizedBox(height: 8),
                        // Experience
                        _buildInfoRow(Icons.people, experience),
                        const SizedBox(height: 8),
                        // Location
                        _buildInfoRow(Icons.location_on, location),
                        const SizedBox(height: 8),
                        // Badge and Message Row
                        Row(
                          children: [
                            // Certifying Authority Badge (only show if available)
                            if (certifyingAuthority != null && certifyingAuthority!.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFD9E1F7),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                child: Text(
                                  certifyingAuthority!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF1E3A8A),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    height: 1.50,
                                  ),
                                ),
                              ),
                            if (certifyingAuthority != null && certifyingAuthority!.isNotEmpty)
                              const SizedBox(width: 12),
                            // Message Icon
                            Container(
                              width: 30,
                              height: 30,
                              decoration: ShapeDecoration(
                                color: const Color(0x1922C55E),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.chat_bubble_outline,
                                  color: Color(0xFF22C55E),
                                  size: 16,
                                ),
                                onPressed: onMessage,
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Action Buttons
          Row(
            children: [
              // Accept Button
              Expanded(
                child: Container(
                  height: 44,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF22C55E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: TextButton(
                    onPressed: onAccept,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text(
                      'Accept',
                      style: TextStyle(
                        color: Color(0xFFF9F9F9),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 1.50,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              // View Profile Button
              Expanded(
                child: Container(
                  height: 44,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFF111111),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: TextButton(
                    onPressed: onViewProfile,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text(
                      'View Profile',
                      style: TextStyle(
                        color: Color(0xFF111111),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 1.50,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, {bool isRating = false}) {
    return Row(
      children: [
        Icon(
          icon,
          color: isRating ? const Color(0xFFFFB800) : const Color(0xFF61758A),
          size: 16,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isRating ? const Color(0xFF111111) : const Color(0xFF61758A),
            fontSize: isRating ? 16 : 14,
            fontFamily: 'Poppins',
            fontWeight: isRating ? FontWeight.w500 : FontWeight.w400,
            height: 1.50,
          ),
        ),
      ],
    );
  }
}