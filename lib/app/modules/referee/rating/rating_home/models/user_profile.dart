class UserProfile {
  final String avatarUrl;
  final String name;
  final String title;
  final String location;
  final int experienceYears;
  final double averageRating;
  final double progressionValue;
  final int thisSeasonMatches;
  final int yellowCards;
  final int redCards;

  UserProfile({
    required this.avatarUrl,
    required this.name,
    required this.title,
    required this.location,
    required this.experienceYears,
    required this.averageRating,
    required this.progressionValue,
    required this.thisSeasonMatches,
    required this.yellowCards,
    required this.redCards,
  });
}
