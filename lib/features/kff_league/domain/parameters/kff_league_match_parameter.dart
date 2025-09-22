typedef MultiDataMap = Map<String, List<String>>;

class KffLeagueClubMatchParameters {
  final int? tournamentId;
  final int? seasonId;
  final String? order;
  final int? status;
  final int? dateFrom;
  final int? dateTo;
  final int? perPage;
  final int? page;

  const KffLeagueClubMatchParameters({
    this.tournamentId,
    this.seasonId,
    this.order,
    this.status,
    this.dateFrom,
    this.dateTo,
    this.perPage,
    this.page,
  });

  /// Используется, если нужна простая сериализация (Map<String, String>)
  Map<String, String> toFlatMap() {
    final map = <String, String>{};

    void put<T>(String key, T? value) {
      if (value != null) {
        map[key] = value.toString();
      }
    }

    put("tournament_id", tournamentId);
    put("season_id", seasonId);
    put("order", order);
    put("status", status);
    put("date_from", dateFrom);
    put("date_to", dateTo);
    put("per_page", perPage);
    put("page", page);

    return map;
  }

  /// Используется, если API ожидает множественные параметры (`key=value&key=value`)
  MultiDataMap toQueryParameters() {
    final map = <String, List<String>>{};

    void put(String key, dynamic value) {
      if (value != null) {
        map[key] = [value.toString()];
      }
    }

    put("tournament_id", tournamentId);
    put("season_id", seasonId);
    put("order", order);
    put("status", status);
    put("date_from", dateFrom);
    put("date_to", dateTo);
    put("per_page", perPage);
    put("page", page);

    return map;
  }

  KffLeagueClubMatchParameters copyWith({
    int? tournamentId,
    int? seasonId,
    String? order,
    int? status,
    int? dateFrom,
    int? dateTo,
    int? perPage,
    int? page,
  }) {
    return KffLeagueClubMatchParameters(
      tournamentId: tournamentId ?? this.tournamentId,
      seasonId: seasonId ?? this.seasonId,
      order: order ?? this.order,
      status: status ?? this.status,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
    );
  }
}
