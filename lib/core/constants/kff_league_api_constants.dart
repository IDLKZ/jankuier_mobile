class KffLeagueApiConstant {
  //Base URL to Sota
  static const String BaseURL = "https://kffleague.kz/api/v1/";
  static const String Token =
      "cb776410401f84b59ecafc838613cb5bc1c8e8e3ba60d946dbdcb271a1f4bc92";

  static String seasons() => "seasons";
  static String season(int seasonId) => "seasons/$seasonId";
  static String championships() => "championships";
  static String championship(int championshipId) =>
      "championships/$championshipId";
  static String tournaments() => "tournaments";
  static String tournament(int tournamentId) => "tournaments/$tournamentId";
}
