class KffApiConstant {
  //Base URL to Sota
  static const String BaseURL = "https://kff.kz/api/";
  static const String Token =
      "cb776410401f84b59ecafc838613cb5bc1c8e8e3ba60d946dbdcb271a1f4bc92";

  static String leagues() => "leagues";
  static String league(int leagueId) => "leagues/$leagueId";
  static String leagueMatches(int leagueId) => "leagues/$leagueId/matches";
  static String leagueCoaches(int leagueId) => "leagues/$leagueId/coaches";
  static String leaguePlayers(int leagueId) => "leagues/$leagueId/players";
  static String leaguePastMatches(int leagueId) =>
      "leagues/$leagueId/past-matches";
}
