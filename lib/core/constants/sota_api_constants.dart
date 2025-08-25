class SotaApiConstant {
  //Base URL to Sota
  static const String BaseURL = "https://sota.id/api/";
  //Get Token URL
  static const String GetTokenURL = "${BaseURL}auth/token/";
  static const String AuthEmail = "kazachenko.galina@gmail.com";
  static const String AuthPassword = r"afd#@$afsad";
  static const int SaveTokenSession = 60 * 23;
  // Get Countries
  static const int KZCountryId = 112;
  static const int FootballID = 1;
  static const String GetCountryURL = "${BaseURL}registers/countries/";
  static const String GetTournamentURL = "${BaseURL}registers/tournaments/";
}
