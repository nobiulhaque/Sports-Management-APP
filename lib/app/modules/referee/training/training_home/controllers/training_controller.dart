import 'dart:developer' as developer;
import 'package:get/get.dart';
import 'package:kaldmv/core/services/api_service.dart';
import 'package:kaldmv/core/services/api_exception.dart';
import '../models/training_model.dart';

class TrainingController extends GetxController {
  final ApiService _apiService = ApiService();

  final trainingJobs = <TrainingJob>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTrainingJobs();
  }

  Future<void> fetchTrainingJobs() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      developer.log('Fetching training jobs', name: 'TrainingController');

      final response = await _apiService.get(
        '/referee/referee-training-all-matches',
      );

      developer.log('Raw API Response: $response', name: 'TrainingController');

      if (response != null) {
        // Handle data wrapper
        final dataList =
            response is Map<String, dynamic> && response.containsKey('data')
            ? response['data'] as List<dynamic>
            : response as List<dynamic>;

        developer.log(
          'Data list to parse: $dataList',
          name: 'TrainingController',
        );

        trainingJobs.value = (dataList).map((job) {
          return TrainingJob.fromJson(job as Map<String, dynamic>);
        }).toList();

        developer.log(
          'Loaded ${trainingJobs.length} training jobs',
          name: 'TrainingController',
        );
      } else {
        errorMessage.value = 'No training jobs data received';
        developer.log(
          'No response from server',
          name: 'TrainingController',
          level: 900,
        );
      }
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      developer.log(
        'ApiException: ${e.message}',
        name: 'TrainingController',
        level: 900,
      );
    } catch (e) {
      errorMessage.value = e.toString();
      developer.log('Error: $e', name: 'TrainingController', level: 900);
    } finally {
      isLoading.value = false;
    }
  }
}
