import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaldmv/app/modules/referee/sideDrawer/request_list/controllers/request_list_controller.dart';
import 'package:kaldmv/app/widgets/app_bar_widgets.dart';
import 'package:kaldmv/app/widgets/league_card.dart';

class RequestListView extends GetView<RequestListController> {
  const RequestListView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Request List'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Obx(
                () => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(controller.filters.length, (i) {
                      final selected = controller.selectedFilter.value == i;
                      return Padding(
                        padding: EdgeInsets.only(
                          right: i == controller.filters.length - 1 ? 0 : 8.w,
                        ),
                        child: ChoiceChip(
                          label: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2.0,
                            ),
                            child: Text(
                              controller.filters[i],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: selected
                                    ? Colors.white
                                    : theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                          selected: selected,
                          onSelected: (_) => controller.selectFilter(i),
                          backgroundColor: theme.colorScheme.surface,
                          selectedColor: primary,
                          checkmarkColor: Colors.white,
                          side: BorderSide(
                            color: selected
                                ? Colors.transparent
                                : theme.dividerColor,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Expanded(
                child: Obx(() {
                  // Loading state
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Error state
                  if (controller.errorMessage.isNotEmpty) {
                    return Center(
                      child: Text(
                        controller.errorMessage.value,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  // Empty state
                  if (controller.visibleRequests.isEmpty) {
                    return const Center(child: Text('No league requests'));
                  }

                  // Data state - Using LeagueCard (Filter out APPROVED, show only PENDING)
                  final pendingRequests = controller.visibleRequests
                      .where(
                        (league) =>
                            league.requestStatus?.toUpperCase() != 'APPROVED',
                      )
                      .toList();

                  if (pendingRequests.isEmpty) {
                    return const Center(
                      child: Text('No pending league requests'),
                    );
                  }

                  return ListView.separated(
                    itemCount: pendingRequests.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final league = pendingRequests[index];
                      return LeagueCard(
                        league: league,
                        showSaveButton: false,
                        onRequest: () {
                          // Refresh list after request
                          controller.fetchRequests();
                        },
                        onToggleSave: (leagueId) {
                          // Handle save toggle if needed
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
