import '../../../../../core/services/api_service.dart';
import '../data/match_model.dart';
import 'match_details_model.dart';

class MatchRepository {
  final ApiService _api = ApiService();

  Future<List<MatchModel>> getUpcomingMatches() async {
    final response = await _api.get<Map<String, dynamic>>(
      '/matches/upcoming-all-matches',
    );

    if (response == null || response['success'] != true) {
      return [];
    }

    final List list = response['data'] ?? [];
    return list.map((e) => MatchModel.fromJson(e)).toList();
  }

  Future<MatchDetailsModel?> getMatchDetails(String matchId) async {
    final response = await _api.get<Map<String, dynamic>>(
      '/matches/upcoming-single-match/$matchId',
    );

    if (response == null || response['success'] != true) {
      return null;
    }

    return MatchDetailsModel.fromJson(response['data']);
  }
}
