class AppRouteConstants {
  // Main navigation routes

  //Homes Starts
  static const String HomePagePath = "/";
  static const String HomePageName = "Home Page";

  static const String TasksPagePath = "${HomePagePath}tasks";
  static const String TasksCleanPagePath = "/tasks";
  static const String TasksPageName = "Tasks Page";

  static const String MatchesPagePath = "${HomePagePath}matches";
  static const String MatchesCleanPagePath = "/matches";
  static const String MatchesPageName = "Matches Page";

  static const String KffMatchesPagePath = "${HomePagePath}kff-matches";
  static const String KffMatchesCleanPagePath = "/kff-matches";
  static const String KffMatchesPageName = "Kff Matches Page Path";

  static const String KffLeagueClubPagePath = "${HomePagePath}kff-league-club";
  static const String KffLeagueClubCleanPagePath = "/kff-league-club";
  static const String KffLeagueClubPageName = "Kff League Club Page";

  static const String CountryListPagePath = "${HomePagePath}countries";
  static const String CountryListCleanPagePath = "/countries";
  static const String CountryListPageName = "Country list";

  static const String TournamentSelectionPagePath =
      "${HomePagePath}tournament-selection";
  static const String TournamentSelectionCleanPagePath =
      "/tournament-selection";
  static const String TournamentSelectionPageName = "Tournament Selection Page";

  static const String StandingsPagePath = "${HomePagePath}standings";
  static const String StandingsCleanPagePath = "/standings";
  static const String StandingsPageName = "Standings Page";

  static const String GameStatPagePath = "${HomePagePath}game-stat/";
  static const String GameStatCleanPagePath = "/game-stat/";
  static const String GameStatPageName = "Game Statistics Page";

  static const String ActivityPagePath = "${HomePagePath}activity";
  static const String ActivityCleanPagePath = "/activity";
  static const String ActivityPageName = "Activity Page";
  //Home Page Ends

  //Tickets Starts

  static const String TicketPagePath = "/tickets";
  static const String TicketPageName = "Ticket Page";

  //Tickets Ends

  //Services Starts
  static const String ServicesPagePath = "/services";
  static const String ServicesPageName = "Services Page";

  static const String SingleProductPagePath =
      "${ServicesPagePath}/product-page/";
  static const String SingleProductCleanPagePath = "/product-page/";
  static const String SingleProductPageName = "Product Page";

  static const String ServiceSectionSinglePagePath =
      "${ServicesPagePath}/section-single-page/";
  static const String ServiceSectionSingleCleanPagePath =
      "/section-single-page/";
  static const String ServiceSectionSinglePageName = "Single Section Page";

  static const String MyCartPagePath = "${ServicesPagePath}/my-cart";
  static const String MyCartCleanPagePath = "/my-cart";
  static const String MyCartPageName = "My Cart Page";

  static const String MyProductOrdersPagePath =
      "${ServicesPagePath}/my-product-orders-page-path";
  static const String MyProductOrdersCleanPagePath =
      "/my-product-orders-page-path";
  static const String MyProductOrdersPageName = "My Product Orders Page";
  //Services - My Product Orders
  static const String MySingleProductOrderPagePath =
      "${MyProductOrdersPagePath}/my-product-order-page-path/";
  static const String MySingleProductOrderCleanPagePath =
      "/my-product-order-page-path/";
  static const String MySingleProductOrderPageName = "My Product Order Page";
  //Services - My Product Orders

  static const String MyBookingFieldRequestsPagePath =
      "${ServicesPagePath}/my-booking-field-requests";
  static const String MyBookingFieldRequestsCleanPagePath =
      "/my-booking-field-requests";
  static const String MyBookingFieldRequestsPageName =
      "My Booking Field Requests";

  //Services Ends

  //Blog List Starts
  static const String BlogListPagePath = "/blog";
  static const String BlogListPageName = "Blog list";
  //Blog List Ends

  //Profile Starts
  static const String ProfilePagePath = "/profile";
  static const String ProfilePageName = "Profile Page";

  static const String EditAccountPagePath = "${ProfilePagePath}/edit-account";
  static const String EditAccountCleanPagePath = "/edit-account";
  static const String EditAccountPageName = "Edit Account";

  static const String EditPasswordPagePath = "${ProfilePagePath}/edit-password";
  static const String EditPasswordCleanPagePath = "/edit-password";
  static const String EditPasswordPageName = "Edit Password";

  static const String MyNotificationsPagePath =
      "${ProfilePagePath}/my-notifications-path";
  static const String MyNotificationsCleanPagePath = "/my-notifications-path";
  static const String MyNotificationsPageName = "My Notifications Page";

  static const String ReloadPINCodePagePath =
      "${ProfilePagePath}/reload-pin-code";
  static const String ReloadPINCodeCleanPath = "/reload-pin-code";
  static const String ReloadPINCodePageName = "Reload Pin Code Page Name";

  //Profile Ends

  //Out Of ShellRoute
  static const String WelcomePagePath = "/welcome";
  static const String WelcomePageName = "Welcome Page";
  //Auth Starts
  static const String SignInPagePath = "/sign-in";
  static const String SignInPageName = "Sign In Page";
  static const String SignUpPagePath = "/sign-up";
  static const String SignUpPageName = "Sign Up Page";
  static const String EnterPhonePagePath = "/enter-phone";
  static const String EnterPhonePageName = "Enter Phone Page";
  static const String VerifyCodePagePath = "/verify-code";
  static const String VerifyCodePageName = "Verify Code Page";
  static const String SendResetCodePagePath = "/send-reset-code";
  static const String SendResetCodePageName = "Send Reset Code Page";
  static const String ResetPasswordPagePath = "/reset-password";
  static const String ResetPasswordPageName = "Reset Password Page";

  static const String MyFirstLocalAuthPagePath = "/set-up-local-auth";
  static const String MyFirstLocalAuthPageName = "Set Up Local Auth";

  static const String RefreshTokenViaLocalAuthPagePath =
      "/refresh-token-via-local-auth";
  static const String RefreshTokenViaLocalAuthPageName =
      "Refresh Token Via Local Auth";

//Auth Ends

//Out Of ShellRoute
}
