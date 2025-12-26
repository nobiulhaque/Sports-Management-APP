import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/data/models/league_request_model.dart'
    as league_request;
import 'package:kaldmv/app/data/models/leauge_card_model.dart';
import 'package:kaldmv/core/services/api_service.dart';

class RequestListController extends GetxController {
  // Filters
  final filters = const ['All', 'This Week', 'This Month'];
  final selectedFilter = 0.obs;

  // Data
  final allRequests = <Data>[].obs;
  final visibleRequests = <Data>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchRequests();
  }

  // Fetch requests from API
  Future<void> fetchRequests() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiService.get<Map<String, dynamic>>(
        '/referee/my-requests',
      );

      if (response != null) {
        final leagueResponse = league_request.LeagueRequestList.fromJson(
          response,
        );

        if (leagueResponse.success == true && leagueResponse.data != null) {
          // Map API response to Data model (for LeagueCard reuse)
          final items = leagueResponse.data!.map((request) {
            final league = request.leagueOfficial;
            final apiUser = league?.user;

            return Data(
              id: league?.id ?? '',
              organizationId: league?.organizationId,
              founded: league?.founded,
              country: league?.country,
              level: league?.level,
              userId: league?.userId,
              user: apiUser != null
                  ? User(
                      id: apiUser.id,
                      name: apiUser.name,
                      image: apiUser.image,
                    )
                  : null,
              requestStatus: request.status,
              isSaved: false,
              isRequestSent: request.status?.toUpperCase() == 'PENDING',
              requestedAt: request.requestedAt,
              requestId: request.id,
            );
          }).toList();

          allRequests.assignAll(items);
          _applyFilter();
          print('✅ Loaded ${items.length} league requests');
        } else {
          errorMessage.value =
              leagueResponse.message ?? 'Failed to load requests';
          print('❌ API Error: ${errorMessage.value}');
        }
      } else {
        errorMessage.value = 'No response from server';
        print('❌ No response from server');
      }
    } catch (e) {
      errorMessage.value = 'Error loading requests: $e';
      print('❌ Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void selectFilter(int index) {
    selectedFilter.value = index;
    _applyFilter();
  }

  void _applyFilter() {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));

    switch (selectedFilter.value) {
      case 0: // All
        visibleRequests.assignAll(allRequests);
        break;
      case 1: // This Week (last 7 days)
        final filtered = allRequests.where((request) {
          if (request.requestedAt == null) return false;
          try {
            final requestDate = DateTime.parse(request.requestedAt!);
            return requestDate.isAfter(sevenDaysAgo);
          } catch (e) {
            return false;
          }
        }).toList();
        visibleRequests.assignAll(filtered);
        break;
      case 2: // This Month (last 30 days)
        final filtered = allRequests.where((request) {
          if (request.requestedAt == null) return false;
          try {
            final requestDate = DateTime.parse(request.requestedAt!);
            return requestDate.isAfter(thirtyDaysAgo);
          } catch (e) {
            return false;
          }
        }).toList();
        visibleRequests.assignAll(filtered);
        break;
      default:
        visibleRequests.assignAll(allRequests);
    }
  }

  // Actions
  void onStatusPressed(BuildContext context, Data item) async {
    // Handle status change if needed
  }

  void onProfilePressed(Data item) {
    // Navigate to profile
  }

  void onChatPressed(Data item) {
    // Navigate to chat
  }
}
