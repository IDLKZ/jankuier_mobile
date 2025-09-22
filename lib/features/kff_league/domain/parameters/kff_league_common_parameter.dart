typedef MultiDataMap = Map<String, List<String>>;

class KffLeagueCommonParameter {
  final int? perPage;
  final int? page;

  const KffLeagueCommonParameter({
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

    put("per_page", perPage);
    put("page", page);

    return map;
  }

  KffLeagueCommonParameter copyWith({
    int? perPage,
    int? page,
  }) {
    return KffLeagueCommonParameter(
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
    );
  }
}
