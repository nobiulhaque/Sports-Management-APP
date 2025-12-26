import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/leauge_officials/widgets/custom_app_bar.dart';
import '../controllers/viw_details_controller.dart';

class ViwDetailsView extends GetView<ViwDetailsController> {
  const ViwDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarLeauge(title: 'View Details'),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Obx(() {
          if (controller.matchData.value == null) {
            return const Center(child: Text('No match data available'));
          }

          final match = controller.matchData.value!;

          return Column(
            children: [
              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Match Card
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFEBF4FF), Color(0xFFF3E8FF)],
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            // Teams and Score
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Team 1
                                Column(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFDC143C),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: Center(
                                        child: match.team1Logo.isNotEmpty
                                            ? Image.network(
                                                match.team1Logo,
                                                width: 32,
                                                height: 32,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) {
                                                      return const Icon(
                                                        Icons.shield,
                                                        color: Colors.white,
                                                        size: 28,
                                                      );
                                                    },
                                              )
                                            : const Icon(
                                                Icons.shield,
                                                color: Colors.white,
                                                size: 28,
                                              ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      match.team1Name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF1A1A1A),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(width: 24),

                                // Score
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF9E9E9E),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    match.formattedScore,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 24),

                                // Team 2
                                Column(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFA50044),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: Center(
                                        child: match.team2Logo.isNotEmpty
                                            ? Image.network(
                                                match.team2Logo,
                                                width: 32,
                                                height: 32,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) {
                                                      return const Icon(
                                                        Icons.shield,
                                                        color: Colors.white,
                                                        size: 28,
                                                      );
                                                    },
                                              )
                                            : const Icon(
                                                Icons.shield,
                                                color: Colors.white,
                                                size: 28,
                                              ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      match.team2Name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF1A1A1A),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // Date, Time, Location
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 16,
                                  color: Color(0xFF666666),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  match.formattedDate,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF666666),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                const Icon(
                                  Icons.access_time,
                                  size: 16,
                                  color: Color(0xFF666666),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  match.matchTime,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF666666),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                  color: Color(0xFF666666),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    match.location ?? 'Unknown Location',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF666666),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),

                            // Rating Section
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    'Overall Match Rating',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF666666),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xFFFFA500),
                                        size: 32,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        match.refereeOverallRating != null
                                            ? match.refereeOverallRating!.toStringAsFixed(1)
                                            : 'N/A',
                                        style: const TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1A1A1A),
                                          height: 1,
                                        ),
                                      ),
                                      const Text(
                                        ' / 10',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF999999),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    match.refereeOverallRating != null &&
                                            match.refereeOverallRating! >= 4.5
                                        ? 'Outstanding Performance'
                                        : 'Good Performance',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          match.refereeOverallRating != null &&
                                              match.refereeOverallRating! >= 4.5
                                          ? const Color(0xFF00C853)
                                          : const Color(0xFFFFA726),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Match Statistics
                      const Text(
                        'Match Statistics',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Statistics Grid
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF8E1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Yellow Cards',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF666666),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '${match.yellowCards ?? 0}',
                                          style: const TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFFFA726),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFEBEE),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Red Cards',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF666666),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '${match.redCards ?? 0}',
                                          style: const TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFE53935),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE3F2FD),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Fouls Called',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF666666),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '${match.foulsCall ?? 0}',
                                          style: const TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF2196F3),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF3E5F5),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Offsides',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF666666),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '${match.offsides ?? 0}',
                                          style: const TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF9C27B0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
