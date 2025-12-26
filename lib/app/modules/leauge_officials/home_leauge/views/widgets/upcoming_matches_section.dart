import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'upcoming_match_card.dart';

class UpcomingMatchesSection extends StatefulWidget {
  const UpcomingMatchesSection({super.key});

  @override
  State<UpcomingMatchesSection> createState() => _UpcomingMatchesSectionState();
}

class _UpcomingMatchesSectionState extends State<UpcomingMatchesSection> {
  final PageController _pageController = PageController(viewportFraction: 0.88);
  int _currentPage = 0;

  final List<Map<String, dynamic>> upcomingMatches = [
    {
      "team1": "Barcelona",
      "team2": "Real Madrid",
      "time": "10:00 PM",
      "date": "Nov 25",
      "image": "assets/bg/match_perfomence.png"
    },
    {
      "team1": "Liverpool",
      "team2": "Chelsea",
      "time": "11:30 PM",
      "date": "Nov 27",
      "image": "assets/bg/match_perfomence.png"
    },
    {
      "team1": "Bayern",
      "team2": "Dortmund",
      "time": "9:45 PM",
      "date": "Nov 30",
      "image": "assets/bg/match_perfomence.png"
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Upcoming Matches',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See All',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // Carousel
        SizedBox(
          height: 160.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: upcomingMatches.length,
            padEnds: false,
            itemBuilder: (context, index) {
              return UpcomingMatchCard(
                data: upcomingMatches[index],
              );
            },
          ),
        ),

        SizedBox(height: 10.h),

        // Page Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            upcomingMatches.length,
                (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: _currentPage == index ? 32.w : 8.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? Colors.blue
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
