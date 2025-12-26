class MatchPerformance {
  final String team1Name;
  final String team2Name;
  final String team1Logo;
  final String team2Logo;
  final int? team1Goal;
  final int? team2Goal;
  final String matchDate;
  final String matchTime;
  final String status;
  final String? refereeImage;
  final double? refereeOverallRating;
  final int? yellowCards;
  final int? redCards;
  final int? foulsCall;
  final int? offsides;
  final String? location;

  MatchPerformance({
    required this.team1Name,
    required this.team2Name,
    required this.team1Logo,
    required this.team2Logo,
    this.team1Goal,
    this.team2Goal,
    required this.matchDate,
    required this.matchTime,
    required this.status,
    this.refereeImage,
    this.refereeOverallRating,
    this.yellowCards,
    this.redCards,
    this.foulsCall,
    this.offsides,
    this.location,
  });

  // Helper getter to format score
  String get formattedScore {
    final goal1 = team1Goal ?? 0;
    final goal2 = team2Goal ?? 0;
    return '$goal1 - $goal2';
  }

  // Helper getter to get date in readable format
  String get formattedDate {
    try {
      final date = DateTime.parse(matchDate);
      return '${date.day} ${_getMonth(date.month)} ${date.year}';
    } catch (e) {
      return matchDate;
    }
  }

  String _getMonth(int month) {
    const months = [
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
    return months[month - 1];
  }
}
