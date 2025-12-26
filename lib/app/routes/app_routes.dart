// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const SPLASH = _Paths.SPLASH;
  static const ONBOARDING = _Paths.ONBOARDING;
  static const AUTH = _Paths.AUTH;
  static const FORGOT_PASSWORD = _Paths.FORGOT_PASSWORD;
  static const OTP = _Paths.OTP;
  static const RESET_PASSWORD = _Paths.RESET_PASSWORD;
  static const RESET_SUCCESS = _Paths.RESET_SUCCESS;
  static const SET_ROLE = _Paths.SET_ROLE;
  static const REFEREE_TYPE = _Paths.REFEREE_TYPE;
  static const REFEREE_HOME = _Paths.REFEREE_HOME;
  static const NOTIFICATION = _Paths.NOTIFICATION;
  static const UPCOMING_MATCHES = _Paths.UPCOMING_MATCHES;
  static const NOTIFICATION_SEETING = _Paths.NOTIFICATION_SEETING;
  static const PREMIUM = _Paths.PREMIUM;
  static const SAVED = _Paths.SAVED;
  static const PROFILE = _Paths.PROFILE;
  static const EDIT_PROFILE = _Paths.EDIT_PROFILE;
  static const REQUEST_LIST = _Paths.REQUEST_LIST;
  static const SAVED_PROFILE_VIEW = _Paths.SAVED_PROFILE_VIEW;
  static const CHANGEPASSWORD = _Paths.CHANGEPASSWORD;
  static const CONTACTSUPPORT = _Paths.CONTACTSUPPORT;
  static const SUBSCRIBETION = _Paths.SUBSCRIBETION;
  static const MESSAGE = _Paths.MESSAGE;
  static const CHAT_DETAIL = _Paths.CHAT_DETAIL;
  static const RATING = _Paths.RATING;
  static const VIW_DETAILS = _Paths.VIW_DETAILS;
  static const FEADBACK = _Paths.FEADBACK;
  static const HOME_LEAUGE = _Paths.HOME_LEAUGE;
  static const LEAUGE = _Paths.LEAUGE;
  static const ADD_MATCH_MODULES = _Paths.ADD_MATCH_MODULES;
  static const LEAUGE_PROFILE = _Paths.LEAUGE_PROFILE;
  static const LEAGE_OFFICIAL_MATCHES = _Paths.LEAGE_OFFICIAL_MATCHES;
  static const LEAUGE_EDIT_PROFILE = _Paths.LEAUGE_EDIT_PROFILE;
  static const RATE_REFEREE = _Paths.RATE_REFEREE;
  static const REFEREES_SIDE = _Paths.REFEREES_SIDE;
  static const REFREE_REQUEST_LIST = _Paths.REFREE_REQUEST_LIST;
  static const UPCOMING_MATCH = _Paths.UPCOMING_MATCH;
  static const VIEW_DETAILS_MATCH = _Paths.VIEW_DETAILS_MATCH;
  static const MESSAGE_SIDE = _Paths.MESSAGE_SIDE;
  static const REQUESTLIST = _Paths.REQUESTLIST;
  static const REGULAR_USER_SET_ROLE = _Paths.REGULAR_USER_SET_ROLE;
  static const HOME_REGULAR_USER = _Paths.HOME_REGULAR_USER;
  static const COMPLETED_MATCHES_REGULAR_USER =
      _Paths.COMPLETED_MATCHES_REGULAR_USER;
  static const UPDATE_MATCHES = _Paths.UPDATE_MATCHES;
  static const REFEREE_DETAILS = _Paths.REFEREE_DETAILS;
  static const LEAGUES_REGULAR_USER = _Paths.LEAGUES_REGULAR_USER;
  static const ACCOUNT_REGULAR_PAGE = _Paths.ACCOUNT_REGULAR_PAGE;
  static const PROFILE_REGULAR = _Paths.PROFILE_REGULAR;
  static const EDIT_PROFILE_REGULAR = _Paths.EDIT_PROFILE_REGULAR;
  static const LEAGUE_OFFICIAL_UPCOMING_MATCHES =
      _Paths.LEAGUE_OFFICIAL_UPCOMING_MATCHES;
  static const LEAGUE_OFFICIAL_COMPLETE_MATCHES =
      _Paths.LEAGUE_OFFICIAL_COMPLETE_MATCHES;
  static const REFEREE_MATCHES = '/referee-matches';
  static const REFEREE_COMPLETE_MATCHES = _Paths.REFEREE_COMPLETE_MATCHES;
  static const MATCH_DETAILS = _Paths.MATCH_DETAILS;
  static const RATE_TEAM_CONDUCT = _Paths.RATE_TEAM_CONDUCT;
  static const RATE_SCREEN = _Paths.RATE_SCREEN;
<<<<<<< HEAD
  static const REFEREFORLEAUGE = _Paths.REFEREFORLEAUGE;
  static const REFEREFORLEAUGE_DETAILS = _Paths.REFEREFORLEAUGE_DETAILS;
=======
  static const REGULAR_MATCH = _Paths.REGULAR_MATCH;
  static const REGULAR_LEAGUE = _Paths.REGULAR_LEAGUE;
>>>>>>> 074dca573ec78ee82d59ce69b908b08a972ec865
}

//
abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const SPLASH = '/splash';
  static const ONBOARDING = '/onboarding';
  static const AUTH = '/auth';
  static const FORGOT_PASSWORD = '/forgot-password';
  static const OTP = '/otp';
  static const RESET_PASSWORD = '/reset-password';
  static const RESET_SUCCESS = '/reset-success';
  static const SET_ROLE = '/set-role';
  static const REFEREE_TYPE = '/referee-type';
  static const REFEREE_HOME = '/referee-home';
  static const NOTIFICATION = '/notification';
  static const UPCOMING_MATCHES = '/upcoming-matches';
  static const NOTIFICATION_SEETING = '/notification-seeting';
  static const PREMIUM = '/premium';
  static const SAVED = '/saved';
  static const PROFILE = '/profile';
  static const EDIT_PROFILE = '/edit-profile';
  static const REQUEST_LIST = '/request-list';
  static const SAVED_PROFILE_VIEW = '/saved-profile-view';
  static const CHANGEPASSWORD = '/changepassword';
  static const CONTACTSUPPORT = '/contactsupport';
  static const SUBSCRIBETION = '/subscribetion';
  static const MESSAGE = '/message';
  static const CHAT_DETAIL = '/chat-detail';
  static const RATING = '/rating';
  static const VIW_DETAILS = '/viw-details';
  static const FEADBACK = '/feadback';
  static const HOME_LEAUGE = '/home-leauge';
  static const LEAUGE = '/leauge';
  static const ADD_MATCH_MODULES = '/add-match';
  static const LEAUGE_PROFILE = '/leauge-profile';
  static const LEAGE_OFFICIAL_MATCHES = '/leage-official-matches';
  static const LEAUGE_EDIT_PROFILE = '/leauge-edit-profile';
  static const RATE_REFEREE = '/rate-referee';
  static const REFEREES_SIDE = '/referees-side';
  static const REFREE_REQUEST_LIST = '/refree-request-list';
  static const UPCOMING_MATCH = '/upcoming-match';
  static const VIEW_DETAILS_MATCH = '/view-details-match';
  static const MESSAGE_SIDE = '/message-side';
  static const REQUESTLIST = '/requestlist';
  static const REGULAR_USER_SET_ROLE = '/regular-user-set-role';
  static const HOME_REGULAR_USER = '/home-regular-user';
  static const COMPLETED_MATCHES_REGULAR_USER =
      '/completed-matches-regular-user';
  static const UPDATE_MATCHES = '/update-matches';
  static const REFEREE_DETAILS = '/referee-details';
  static const LEAGUES_REGULAR_USER = '/leagues-regular-user';
  static const ACCOUNT_REGULAR_PAGE = '/account-regular-page';
  static const PROFILE_REGULAR = '/profile-regular';
  static const EDIT_PROFILE_REGULAR = '/edit-profile-regular';
  static const LEAGUE_OFFICIAL_UPCOMING_MATCHES =
      '/league-official-upcoming-matches';
  static const LEAGUE_OFFICIAL_COMPLETE_MATCHES =
      '/league-official-complete-matches';
  static const REFEREE_MATCHES = '/referee-matches';
  static const REFEREE_COMPLETE_MATCHES = '/referee-complete-matches';
  static const MATCH_DETAILS = '/match-details';
  static const RATE_TEAM_CONDUCT = '/rate-team-conduct';
  static const RATE_SCREEN = '/rate-screen';
<<<<<<< HEAD
  static const REFEREFORLEAUGE = '/refereforleauge';
  static const REFEREFORLEAUGE_DETAILS = '/refereforleauge-details';
=======
  static const REGULAR_MATCH = '/regular-match';
  static const REGULAR_LEAGUE = '/regular-league';
>>>>>>> 074dca573ec78ee82d59ce69b908b08a972ec865
}
