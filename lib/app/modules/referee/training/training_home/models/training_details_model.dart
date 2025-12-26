class TrainingDetails {
  final String id;
  final String refereeId;
  final String matchId;
  final int topImprovementAreasCount;
  final List<ImprovementArea> topImprovementAreas;
  final List<String> specificActionableItems;
  final String createdAt;
  final String updatedAt;

  TrainingDetails({
    required this.id,
    required this.refereeId,
    required this.matchId,
    required this.topImprovementAreasCount,
    required this.topImprovementAreas,
    required this.specificActionableItems,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TrainingDetails.fromJson(Map<String, dynamic> json) {
    return TrainingDetails(
      id: json['id'] ?? '',
      refereeId: json['refereeId'] ?? '',
      matchId: json['matchId'] ?? '',
      topImprovementAreasCount: json['topImprovementAreasCount'] ?? 0,
      topImprovementAreas:
          (json['topImprovementAreas'] as List<dynamic>?)
              ?.map(
                (area) =>
                    ImprovementArea.fromJson(area as Map<String, dynamic>),
              )
              .toList() ??
          [],
      specificActionableItems: List<String>.from(
        json['specificActionableItems'] as List<dynamic>? ?? [],
      ),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class ImprovementArea {
  final String category;
  final String title;
  final String description;
  final String priority;
  final String aiInsight;
  final int occurrenceCount;

  ImprovementArea({
    required this.category,
    required this.title,
    required this.description,
    required this.priority,
    required this.aiInsight,
    required this.occurrenceCount,
  });

  factory ImprovementArea.fromJson(Map<String, dynamic> json) {
    return ImprovementArea(
      category: json['category'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      priority: json['priority'] ?? 'medium',
      aiInsight: json['ai_insight'] ?? '',
      occurrenceCount: json['occurrence_count'] ?? 0,
    );
  }
}
