// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
//
// import '../../../../leauge_officials/upcomingMatch/controllers/upcoming_match_controller.dart';
// import '../../../../leauge_officials/upcomingMatch/views/match_detaills_upcoming_match.dart';
// import '../../../../leauge_officials/upcomingMatch/views/widgets/match_card_widgets.dart';
//
// class UpcomingMatchesView extends StatelessWidget {
//   const UpcomingMatchesView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(UpcomingMatchController());
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//
//       body: Column(
//         children: [
//
//           // Matches List
//           Expanded(
//             child: Obx(() {
//               return ListView.builder(
//                 padding: EdgeInsets.symmetric(horizontal: 20.w),
//                 itemCount: controller.filteredMatches.length,
//                 itemBuilder: (context, index) {
//                   final match = controller.filteredMatches[index];
//
//                   return Padding(
//                     padding: EdgeInsets.only(bottom: 12.h),
//                     child: MatchCard(
//                       match: match,
//                       onViewDetails: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 MatchDetailsScreenDetaislUpcomming(match: match),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }
