import 'package:get/get.dart';
import '../modules/common/auth/bindings/auth_binding.dart';
import '../modules/common/auth/views/auth_view.dart';
import '../modules/common/auth/views/forgot_password_view.dart';
import '../modules/common/auth/views/otp_view.dart';
import '../modules/common/auth/views/reset_password_view.dart';
import '../modules/common/auth/views/reset_success_view.dart';
import '../modules/common/auth/views/set_role_view.dart';
import '../modules/common/premium/bindings/premium_binding.dart';
import '../modules/common/premium/views/premium_view.dart';
import '../modules/common/splash/bindings/splash_binding.dart';
import '../modules/common/splash/views/onboarding_view.dart';
import '../modules/common/splash/views/splash_view.dart';
import '../modules/leauge_officials/League_official_upcoming_matches/bindings/league_official_upcoming_matches_binding.dart';
import '../modules/leauge_officials/League_official_upcoming_matches/views/league_official_upcoming_matches_view.dart';
import '../modules/leauge_officials/RefereesSide/bindings/referees_side_binding.dart';
import '../modules/leauge_officials/RefereesSide/views/referees_side_view.dart';
import '../modules/leauge_officials/add_match/modules/bindings/add_match_modules_binding.dart';
import '../modules/leauge_officials/add_match/modules/views/add_match_modules_view.dart';
import '../modules/leauge_officials/add_match/refereforleauge/bindings/refereforleauge_binding.dart';
import '../modules/leauge_officials/add_match/refereforleauge/views/refereforleauge_view.dart';
import '../modules/leauge_officials/add_match/refereforleaugeDetails/bindings/refereforleauge_details_binding.dart';
import '../modules/leauge_officials/add_match/refereforleaugeDetails/views/refereforleauge_details_view.dart';
import '../modules/leauge_officials/home_leauge/bindings/home_leauge_binding.dart';
import '../modules/leauge_officials/home_leauge/views/home_leauge_view.dart';
import '../modules/leauge_officials/league_official_complete_matches/bindings/league_official_complete_matches_binding.dart';
import '../modules/leauge_officials/league_official_complete_matches/views/league_official_complete_matches_view.dart';
import '../modules/leauge_officials/league_official_matches/bindings/leage_official_matches_binding.dart';
import '../modules/leauge_officials/league_official_matches/views/league_official_matches_view.dart';
import '../modules/leauge_officials/leaugeDrawer/profile/leauge_edit_profile/bindings/leauge_edit_profile_binding.dart';
import '../modules/leauge_officials/leaugeDrawer/profile/leauge_edit_profile/views/leauge_edit_profile_view.dart';
import '../modules/leauge_officials/leaugeDrawer/profile/leauge_profile/bindings/leauge_profile_binding.dart';
import '../modules/leauge_officials/leaugeDrawer/profile/leauge_profile/views/leauge_profile_view.dart';
import '../modules/leauge_officials/leaugeDrawer/rate_referee/bindings/rate_referee_binding.dart';
import '../modules/leauge_officials/leaugeDrawer/rate_referee/bindings/view_details_match_binding.dart';
import '../modules/leauge_officials/leaugeDrawer/rate_referee/views/rate_referee_view.dart';
import '../modules/leauge_officials/leaugeDrawer/rate_referee/views/view_details_match.dart';
import '../modules/leauge_officials/leaugeDrawer/requestlist/bindings/requestlist_binding.dart';
import '../modules/leauge_officials/leaugeDrawer/requestlist/views/requestlist_view.dart';
import '../modules/leauge_officials/upcomingMatch/bindings/upcoming_match_binding.dart';
import '../modules/leauge_officials/upcomingMatch/views/upcoming_match_view.dart';
import '../modules/leauge_officials/update_matches/bindings/update_matches_binding.dart';
import '../modules/leauge_officials/update_matches/views/update_matches_view.dart';
import '../modules/referee/leauge/bindings/leauge_binding.dart';
import '../modules/referee/leauge/views/leauge_view.dart';
import '../modules/referee/message/bindings/chat_detail_binding.dart';
import '../modules/referee/message/bindings/message_binding.dart';
import '../modules/referee/message/views/chat_detail_view.dart';
import '../modules/referee/message/views/message_view.dart';
import '../modules/referee/notification/notification_seeting/bindings/notification_seeting_binding.dart';
import '../modules/referee/notification/notification_seeting/views/notification_seeting_view.dart';
import '../modules/referee/notification/notification_view/bindings/notification_binding.dart';
import '../modules/referee/notification/notification_view/views/notification_view.dart';
import '../modules/referee/rating/feadback/bindings/feadback_binding.dart';
import '../modules/referee/rating/feadback/views/feadback_view.dart';
import '../modules/referee/rating/view_details/bindings/viw_details_binding.dart';
import '../modules/referee/rating/view_details/views/view_details_view.dart';
import '../modules/referee/referee_complete_matches/bindings/referee_complete_matches_binding.dart';
import '../modules/referee/referee_complete_matches/views/referee_completed_match_view_details.dart';
import '../modules/referee/referee_home/bindings/referee_home_binding.dart';
import '../modules/referee/referee_home/views/nav_home_view.dart';
import '../modules/referee/referee_home/views/referee_type_view.dart';
import '../modules/referee/referee_matches/bindings/referee_matches_binding.dart';
import '../modules/referee/referee_matches/views/referee_matches_view.dart';
import '../modules/referee/saved/bindings/saved_binding.dart';
import '../modules/referee/saved/bindings/saved_profile_binding.dart';
import '../modules/referee/saved/views/saved_profile_view.dart';
import '../modules/referee/saved/views/saved_view.dart';
import '../modules/referee/sideDrawer/changepassword/bindings/changepassword_binding.dart';
import '../modules/referee/sideDrawer/changepassword/views/changepassword_view.dart';
import '../modules/referee/sideDrawer/contactsupport/bindings/contactsupport_binding.dart';
import '../modules/referee/sideDrawer/contactsupport/views/contactsupport_view.dart';
import '../modules/referee/sideDrawer/profle/editProfile/bindings/edit_profile_binding.dart';
import '../modules/referee/sideDrawer/profle/editProfile/views/edit_profile_view.dart';
import '../modules/referee/sideDrawer/profle/profile_view/bindings/profile_binding.dart';
import '../modules/referee/sideDrawer/profle/profile_view/views/profile_view.dart';
import '../modules/referee/sideDrawer/rate/rate_screen/bindings/rate_screen_binding.dart';
import '../modules/referee/sideDrawer/rate/rate_screen/views/rate_screen_view.dart';
import '../modules/referee/sideDrawer/rate/rate_team_conduct/bindings/rate_team_conduct_binding.dart';
import '../modules/referee/sideDrawer/rate/rate_team_conduct/views/rate_team_conduct_view.dart';
import '../modules/referee/sideDrawer/request_list/bindings/request_list_binding.dart';
import '../modules/referee/sideDrawer/request_list/views/request_list_view.dart';
import '../modules/referee/subscribetion/bindings/subscribetion_binding.dart';
import '../modules/referee/subscribetion/views/subscribetion_view.dart';
import '../modules/referee/upcoming_matches/bindings/upcoming_matches_binding.dart';
import '../modules/referee/upcoming_matches/controllers/match_details_controller.dart';
import '../modules/referee/upcoming_matches/views/match_details_view.dart';
import '../modules/referee/upcoming_matches/views/upcoming_matches_view.dart';
import '../modules/regular_user/regular_league/bindings/regular_league_binding.dart';
import '../modules/regular_user/regular_league/views/regular_league_view.dart';
import '../modules/regular_user/regular_match/bindings/regular_match_binding.dart';
import '../modules/regular_user/regular_match/views/regular_match_view.dart';
import '../modules/regular_user/Completed_matches_regular_user/bindings/completed_matches_regular_user_binding.dart';
import '../modules/regular_user/Completed_matches_regular_user/views/completed_matches_regular_user_view.dart';
import '../modules/regular_user/LeaguesRegularUser/bindings/leagues_regular_user_binding.dart';
import '../modules/regular_user/LeaguesRegularUser/views/leagues_regular_user_view.dart';
import '../modules/regular_user/RefereeDetails/bindings/referee_details_binding.dart';
import '../modules/regular_user/RefereeDetails/views/referee_details_view.dart';
import '../modules/regular_user/account_regular_page/bindings/account_regular_page_binding.dart';
import '../modules/regular_user/account_regular_page/views/account_regular_page_view.dart';
import '../modules/regular_user/account_regular_page/views/pages/edit_profile_regular.dart';
import '../modules/regular_user/account_regular_page/views/pages/profile_regular.dart';
import '../modules/regular_user/home_regular_user/bindings/home_regular_user_binding.dart';
import '../modules/regular_user/home_regular_user/views/home_regular_user_view.dart';
import '../modules/regular_user/regular_user_set_role/bindings/regular_user_set_role_binding.dart';
import '../modules/regular_user/regular_user_set_role/views/regular_user_set_role_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
    ),
    GetPage(name: _Paths.OTP, page: () => const OtpView()),
    GetPage(name: _Paths.RESET_PASSWORD, page: () => const ResetPasswordView()),
    GetPage(name: _Paths.RESET_SUCCESS, page: () => const ResetSuccessView()),
    GetPage(name: _Paths.SET_ROLE, page: () => const SetRoleView()),
    GetPage(name: _Paths.REFEREE_TYPE, page: () => const RefereeTypeView()),
    GetPage(
      name: _Paths.REFEREE_HOME,
      page: () => const RefereeHomeView(),
      binding: RefereeHomeBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_SEETING,
      page: () => const NotificationSeetingView(),
      binding: NotificationSeetingBinding(),
    ),
    GetPage(
      name: _Paths.UPCOMING_MATCHES,
      page: () => const UpcomingMatchesView(),
      binding: UpcomingMatchesBinding(),
    ),
    GetPage(
      name: _Paths.MATCH_DETAILS,
      page: () => const MatchDetailsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MatchDetailsController>(() => MatchDetailsController());
      }),
    ),
    GetPage(
      name: _Paths.PREMIUM,
      page: () =>  PremiumView(),
      binding: PremiumBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.SAVED,
      page: () => SavedView(),
      binding: SavedBinding(),
    ),
    GetPage(
      name: _Paths.REQUEST_LIST,
      page: () => const RequestListView(),
      binding: RequestListBinding(),
    ),
    GetPage(
      name: _Paths.SAVED_PROFILE_VIEW,
      page: () => SavedProfileView(),
      binding: SavedProfileBinding(),
    ),
    GetPage(
      name: _Paths.CHANGEPASSWORD,
      page: () => ChangepasswordView(),
      binding: ChangepasswordBinding(),
    ),
    GetPage(
      name: _Paths.CONTACTSUPPORT,
      page: () => const ContactsupportView(),
      binding: ContactsupportBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIBETION,
      page: () => const SubscribetionView(),
      binding: SubscribetionBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGE,
      page: () =>MessageView(),
      binding: MessageBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_DETAIL,
      page: () => ChatDetailView(),
      binding: ChatDetailBinding(),
    ),
    GetPage(
      name: _Paths.VIW_DETAILS,
      page: () => const ViwDetailsView(),
      binding: ViwDetailsBinding(),
      children: [
        GetPage(
          name: _Paths.FEADBACK,
          page: () => const FeadbackView(),
          binding: FeadbackBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.HOME_LEAUGE,
      page: () => const HomeLeagueView(),
      binding: HomeLeaugeBinding(),
    ),
    GetPage(
      name: _Paths.LEAUGE,
      page: () => const LeaugeView(),
      binding: LeaugeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_MATCH_MODULES,
      page: () => AddMatchModulesView(),
      binding: AddMatchModulesBinding(),
    ),
    GetPage(
      name: _Paths.LEAGE_OFFICIAL_MATCHES,
      page: () => LeagueOfficialMatchesView(),
      binding: LeagueOfficialMatchesBinding(),
    ),
    GetPage(
      name: _Paths.LEAUGE_PROFILE,
      page: () => const LeaugeProfileView(),
      binding: LeaugeProfileBinding(),
    ),
    GetPage(
      name: _Paths.LEAUGE_EDIT_PROFILE,
      page: () => const LeaugeEditProfileView(),
      binding: LeaugeEditProfileBinding(),
    ),
    GetPage(
      name: _Paths.RATE_REFEREE,
      page: () => const RateRefereeView(),
      binding: RateRefereeBinding(),
    ),
    GetPage(
      name: _Paths.REFEREES_SIDE,
      page: () => RefereesSideView(),
      binding: RefereesSideBinding(),
    ),
    GetPage(
      name: _Paths.UPCOMING_MATCH,
      page: () => UpcomingMatchView(),
      binding: UpcomingMatchBinding(),
    ),
    GetPage(
      name: _Paths.VIEW_DETAILS_MATCH,
      page: () => ViewDetailsMatch(),
      binding: ViewDetailsMatchBinding(),
    ),
    GetPage(
      name: _Paths.REQUESTLIST,
      page: () => const RequestlistView(),
      binding: RequestlistBinding(),
    ),
    GetPage(
      name: _Paths.REGULAR_USER_SET_ROLE,
      page: () => RegularUserSetRoleView(),
      binding: RegularUserSetRoleBinding(),
    ),
    GetPage(
      name: _Paths.HOME_REGULAR_USER,
      page: () => const HomeRegularUserView(),
      binding: HomeRegularUserBinding(),
    ),
    GetPage(
      name: _Paths.COMPLETED_MATCHES_REGULAR_USER,
      page: () => CompletedMatchesRegularUserView(),
      binding: CompletedMatchesRegularUserBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_MATCHES,
      page: () => const UpdateMatchesView(),
      binding: UpdateMatchesBinding(),
    ),
    GetPage(
      name: _Paths.REFEREE_DETAILS,
      page: () => const RefereeDetailsView(),
      binding: RefereeDetailsBinding(),
    ),
    GetPage(
      name: _Paths.LEAGUES_REGULAR_USER,
      page: () => LeaguesRegularUserView(),
      binding: LeaguesRegularUserBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_REGULAR_PAGE,
      page: () => const AccountRegularPageView(),
      binding: AccountRegularPageBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_REGULAR,
      page: () => const ProfileRegularView(),
      binding: AccountRegularPageBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE_REGULAR,
      page: () => EditProfileRegular(),
      binding: AccountRegularPageBinding(),
    ),
    GetPage(
      name: _Paths.LEAGUE_OFFICIAL_UPCOMING_MATCHES,
      page: () => const LeagueOfficialUpcomingMatchesView(),
      binding: LeagueOfficialUpcomingMatchesBinding(),
    ),
    GetPage(
      name: _Paths.LEAGUE_OFFICIAL_COMPLETE_MATCHES,
      page: () => const LeagueOfficialCompleteMatchesView(),
      binding: LeagueOfficialCompleteMatchesBinding(),
    ),
    GetPage(
      name: _Paths.REFEREE_MATCHES,
      page: () => const RefereeMatchesView(),
      binding: RefereeMatchesBinding(),
    ),
    GetPage(
      name: _Paths.REFEREE_COMPLETE_MATCHES,
      page: () => const RefereeCompletedMatchViewDetails(),
      binding: RefereeCompleteMatchesBinding(),
    ),
    GetPage(
      name: _Paths.RATE_TEAM_CONDUCT,
      page: () => const RateTeamConductView(),
      binding: RateTeamConductBinding(),
    ),
    GetPage(
      name: _Paths.RATE_SCREEN,
      page: () => const RateScreenView(),
      binding: RateScreenBinding(),
    ),
    GetPage(
<<<<<<< HEAD
      name: _Paths.REFEREFORLEAUGE,
      page: () => RefereforleaugeView(),
      binding: RefereforleaugeBinding(),
    ),
    GetPage(
      name: _Paths.REFEREFORLEAUGE_DETAILS,
      page: () =>  RefereforleaugeDetailsView(),
      binding: RefereforleaugeDetailsBinding(),
=======
      name: _Paths.REGULAR_MATCH,
      page: () => const RegularMatchView(),
      binding: RegularMatchBinding(),
    ),
    GetPage(
      name: _Paths.REGULAR_LEAGUE,
      page: () => const RegularLeagueView(),
      binding: RegularLeagueBinding(),
>>>>>>> 074dca573ec78ee82d59ce69b908b08a972ec865
    ),
  ];
}
