// ignore_for_file: void_checks
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/leauge_officials/leaugeDrawer/rate_referee/views/widgets/completed_match_card.dart';

List<MatchModel> matches = [
  MatchModel(
    team1Logo: 'assets/dynamic/fc_dallas.png',
    team1Name: 'Team A',
    t1score: 2,
    team2Logo: 'assets/dynamic/la_galaxy.png',
    team2Name: 'Team B',
    t2score: 1,
    date: '21 Nov, 2025',
    refereeImage: 'assets/dynamic/referee.png',
    rate: 4.5,
    onTap: (){
      Get.toNamed('/view-details-match');
    },
  ),
  // Add more matches...
  MatchModel(
    team1Logo: 'assets/dynamic/fc_dallas.png',
    team1Name: 'Team C',
    t1score: 0,
    team2Logo: 'assets/dynamic/la_galaxy.png',
    team2Name: 'Team D',
    t2score: 4,
    date: '22 Nov, 2025',
    refereeImage: 'assets/dynamic/referee.png',
    rate: 4.0,
    onTap: (){},
  ),

  MatchModel(
    team1Logo: 'assets/dynamic/fc_dallas.png',
    team1Name: 'Team C',
    t1score: 0,
    team2Logo: 'assets/dynamic/la_galaxy.png',
    team2Name: 'Team D',
    t2score: 4,
    date: '22 Nov, 2025',
    refereeImage: 'assets/dynamic/referee.png',
    rate: 4.0,
    onTap: (){},
  ),
  MatchModel(
    team1Logo: 'assets/images/barcelona_logo.png',
    team1Name: 'Team C',
    t1score: 2,
    team2Logo: 'assets/images/bayern_logo.png',
    team2Name: 'Team D',
    t2score: 4,
    date: '25 Nov, 2025',
    refereeImage: 'assets/dynamic/referee.png',
    rate: 4.0,
    onTap: (){},
  ),
  MatchModel(
    team1Logo: 'assets/dynamic/fc_dallas.png',
    team1Name: 'Team C',
    t1score: 2,
    team2Logo: 'assets/dynamic/la_galaxy.png',
    team2Name: 'Team D',
    t2score: 4,
    date: '23 Nov, 2025',
    refereeImage: 'assets/dynamic/referee.png',
    rate: 4.0,
    onTap: (){},
  ),
];
