import 'dart:developer' as developer;
import 'package:get/get.dart';
import 'package:kaldmv/core/services/api_service.dart';
import 'package:kaldmv/core/services/api_exception.dart';
import '../models/training_details_model.dart';

class TrainingController extends GetxController {
  final ApiService _apiService = ApiService();

  final trainingDetails = Rx<TrainingDetails?>(null);
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  late String trainingId;

  @override
  void onInit() {
    super.onInit();
    trainingId = Get.arguments as String? ?? '';
    if (trainingId.isNotEmpty) {
      fetchTrainingDetails();
    }
  }

  Future<void> fetchTrainingDetails() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      developer.log(
        'Fetching training details for ID: $trainingId',
        name: 'DetailsController',
      );

      final response = await _apiService.get(
        '/referee/referee-training-all-matches/$trainingId',
      );

      developer.log('Raw API Response: $response', name: 'DetailsController');

      if (response != null) {
        // Handle data wrapper
        final detailsData =
            response is Map<String, dynamic> && response.containsKey('data')
            ? response['data']
            : response;

        developer.log(
          'Details data to parse: $detailsData',
          name: 'DetailsController',
        );

        trainingDetails.value = TrainingDetails.fromJson(detailsData);

        developer.log(
          'Training details loaded successfully',
          name: 'DetailsController',
        );
      } else {
        errorMessage.value = 'No training details received';
        developer.log(
          'No response from server',
          name: 'DetailsController',
          level: 900,
        );
      }
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      developer.log(
        'ApiException: ${e.message}',
        name: 'DetailsController',
        level: 900,
      );
    } catch (e) {
      errorMessage.value = e.toString();
      developer.log('Error: $e', name: 'DetailsController', level: 900);
    } finally {
      isLoading.value = false;
    }
  }
}
