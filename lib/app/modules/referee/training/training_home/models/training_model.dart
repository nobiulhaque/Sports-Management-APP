class TrainingJob {
  final String id;
  final String matchId;
  final TrainingMatch match;
  final String matchStartDate;

  TrainingJob({
    required this.id,
    required this.matchId,
    required this.match,
    required this.matchStartDate,
  });

  factory TrainingJob.fromJson(Map<String, dynamic> json) {
    return TrainingJob(
      id: json['id'] ?? '',
      matchId: json['matchId'] ?? '',
      match: TrainingMatch.fromJson(json['matched'] ?? {}),
      matchStartDate: json['matchStartDate'] ?? '',
    );
  }
}

class TrainingMatch {
  final String id;
  final String team1Name;
  final String team2Name;
  final String team1Logo;
  final String team2Logo;
  final String location;
  final String matchDate;
  final String matchTime;

  TrainingMatch({
    required this.id,
    required this.team1Name,
    required this.team2Name,
    required this.team1Logo,
    required this.team2Logo,
    required this.location,
    required this.matchDate,
    required this.matchTime,
  });

  factory TrainingMatch.fromJson(Map<String, dynamic> json) {
    return TrainingMatch(
      id: json['id'] ?? '',
      team1Name: json['team1Name'] ?? '',
      team2Name: json['team2Name'] ?? '',
      team1Logo: json['team1Logo'] ?? '',
      team2Logo: json['team2Logo'] ?? '',
      location: json['location'] ?? '',
      matchDate: json['matchDate'] ?? '',
      matchTime: json['matchTime'] ?? '',
    );
  }
}
