import 'package:get/get.dart';

class LeagueProfileController extends GetxController {
  // Header Card Data
  final RxString logoAsset = 'assets/icons/laliga_icons.png'.obs;
  final RxString name = 'Laliga'.obs;
  final RxString email = 'laligaofficial@gmail.com'.obs;
  final RxString leagueType = 'Professional League'.obs;
  final RxString foundedYear = 'Founded in 1929'.obs;

  // League Information Data
  final RxString organizationId = '#LLA-2025'.obs;
  final RxString country = 'Spain'.obs;
  final RxString certifyingAuthority = 'Fifa'.obs;
  final RxString licenseValidTill = 'December 2026'.obs;

  // Official Representative Data
  final RxString repAvatarUrl = 'https://i.pravatar.cc/150?img=12'.obs;
  final RxString repFullName = 'Javier Tebas'.obs;
  final RxString repDesignation = 'League Manager'.obs;
  final RxString repContactNumber = '+34 123 456 789'.obs;
  final RxString repEmail = 'javiertebas@laliga.com'.obs;

  // Account Information Data
  final RxString joinedDate = '12 March 2024'.obs;
  final RxString accountType = 'Premium'.obs;

  // Stats Grid Data
  final RxString refereesHired = '47'.obs;
  final RxString ongoingMatches = '6'.obs;
  final RxString pendingMatches = '47'.obs;
  final RxString completedMatches = '6'.obs;
}