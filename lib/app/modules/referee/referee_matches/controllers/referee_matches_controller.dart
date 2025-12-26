import 'dart:developer' as developer;
import 'package:get/get.dart';
import 'package:kaldmv/core/services/api_service.dart';
import 'package:kaldmv/core/services/api_exception.dart';
import '../models/referee_match_model.dart';

class RefereeMatchesController extends GetxController {
  final ApiService _apiService = ApiService();

  final matches = <RefereeMatch>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRefereeMatches();
  }

  Future<void> fetchRefereeMatches() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      developer.log(
        'Fetching referee matches',
        name: 'RefereeMatchesController',
      );

      final response = await _apiService.get('/referee/referee-all-matches');

      developer.log(
        'Raw API Response: $response',
        name: 'RefereeMatchesController',
      );

      if (response != null) {
        // Handle data wrapper
        final matchesData =
            response is Map<String, dynamic> && response.containsKey('data')
            ? response['data'] as List<dynamic>
            : response is List<dynamic>
            ? response
            : [];

        developer.log(
          'Matches data to parse: $matchesData',
          name: 'RefereeMatchesController',
        );

        final parsedMatches = (matchesData).map((match) {
          return RefereeMatch.fromJson(match as Map<String, dynamic>);
        }).toList();

        matches.value = parsedMatches;

        developer.log(
          'Referee matches loaded successfully. Count: ${parsedMatches.length}',
          name: 'RefereeMatchesController',
        );
      } else {
        errorMessage.value = 'No matches received';
        developer.log(
          'No response from server',
          name: 'RefereeMatchesController',
          level: 900,
        );
      }
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      developer.log(
        'ApiException: ${e.message}',
        name: 'RefereeMatchesController',
        level: 900,
      );
    } catch (e) {
      errorMessage.value = e.toString();
      developer.log('Error: $e', name: 'RefereeMatchesController', level: 900);
    } finally {
      isLoading.value = false;
    }
  }
}
