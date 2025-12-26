import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../core/services/api_service.dart';
import '../data/my_league_referee_model.dart';


class RefereesSideController extends GetxController {
  final ApiService _apiService = ApiService();

  final isLoading = false.obs;
  final referees = <MyLeagueReferee>[].obs;
  final allReferees = <MyLeagueReferee>[];
  final searchController = TextEditingController();
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyLeagueReferees();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void searchReferees(String query) {
    searchQuery.value = query;
    
    if (query.isEmpty) {
      referees.assignAll(allReferees);
    } else {
      final filtered = allReferees.where((referee) {
        final name = referee.referee.user.name.toLowerCase();
        final searchLower = query.toLowerCase();
        return name.contains(searchLower);
      }).toList();
      
      referees.assignAll(filtered);
    }
  }

  Future<void> fetchMyLeagueReferees() async {
    try {
      isLoading.value = true;

      final response = await _apiService.get(
        '/league-officials/my-league-referee',
      );

      if (response != null) {
        final parsed =
        MyLeagueRefereeResponse.fromJson(response);
        allReferees.clear();
        allReferees.addAll(parsed.data);
        referees.assignAll(parsed.data);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
