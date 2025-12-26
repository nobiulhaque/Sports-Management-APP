class RequestItem {
  final String id;
  final String title;
  final String code;
  final String founded;
  final String location;
  final String leagueTag;
  final String statusText;
  final String? initials;

  const RequestItem({
    required this.id,
    required this.title,
    required this.code,
    required this.founded,
    required this.location,
    required this.leagueTag,
    required this.statusText,
    this.initials,
  });

  RequestItem copyWith({
    String? id,
    String? title,
    String? code,
    String? founded,
    String? location,
    String? leagueTag,
    String? statusText,
    String? initials,
  }) {
    return RequestItem(
      id: id ?? this.id,
      title: title ?? this.title,
      code: code ?? this.code,
      founded: founded ?? this.founded,
      location: location ?? this.location,
      leagueTag: leagueTag ?? this.leagueTag,
      statusText: statusText ?? this.statusText,
      initials: initials ?? this.initials,
    );
  }
}