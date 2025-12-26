import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RefereeProfileCard extends StatelessWidget {
  final String name;
  final double rating;
  final String experience;
  final String imagePath;
  final int? totalMatches;
  final String? level;
  final String? role;

  final VoidCallback onTap; // <-- external onTap

  const RefereeProfileCard({
    super.key,
    required this.name,
    required this.rating,
    required this.experience,
    required this.imagePath,
<<<<<<< HEAD
    required this.onTap,
    required String buttonText,       // <-- required from outside

=======
    this.totalMatches,
    this.level,
    this.role,
    required this.onTap, // <-- required from outside
>>>>>>> 074dca573ec78ee82d59ce69b908b08a972ec865
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: imagePath.isNotEmpty && imagePath.startsWith('http')
                        ? CachedNetworkImage(
                            imageUrl: imagePath,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              width: 60,
                              height: 60,
                              color: const Color(0xFFE8EAFF),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 60,
                              height: 60,
                              color: const Color(0xFFE8EAFF),
                              child: const Icon(
                                Icons.person,
                                size: 30,
                                color: Color(0xFF4A5FD8),
                              ),
                            ),
                          )
                        : imagePath.isNotEmpty
                        ? Image.asset(
                            imagePath,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  width: 60,
                                  height: 60,
                                  color: const Color(0xFFE8EAFF),
                                  child: const Icon(
                                    Icons.person,
                                    size: 30,
                                    color: Color(0xFF4A5FD8),
                                  ),
                                ),
                          )
                        : Container(
                            width: 60,
                            height: 60,
                            color: const Color(0xFFE8EAFF),
                            child: const Icon(
                              Icons.person,
                              size: 30,
                              color: Color(0xFF4A5FD8),
                            ),
                          ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$rating/5',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 72),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      Icons.sports_soccer,
                      totalMatches != null
                          ? '$totalMatches Matches'
                          : 'Matches',
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow(Icons.people, experience),
                    const SizedBox(height: 8),
                    _buildInfoRow(Icons.gavel, role ?? 'Referee'),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8EAFF),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    _formatLevel(level),
                    style: const TextStyle(
                      color: Color(0xFF4A5FD8),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 🔥 VIEW PROFILE BUTTON — TAP COMES FROM OUTSIDE
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF22C55E),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: onTap, // <-- use external callback
                  child: const Text(
                    'View Profile',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
        ),
      ],
    );
  }

  String _formatLevel(String? level) {
    if (level == null) return 'National Certified';

    switch (level) {
      case 'REGIONAL_LEVEL':
        return 'Regional Level';
      case 'NATIONAL_LEVEL':
        return 'National Level';
      case 'INTERNATIONAL_LEVEL':
        return 'International Level';
      default:
        return level
            .replaceAll('_', ' ')
            .toLowerCase()
            .split(' ')
            .map(
              (word) =>
                  word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1),
            )
            .join(' ');
    }
  }
}
