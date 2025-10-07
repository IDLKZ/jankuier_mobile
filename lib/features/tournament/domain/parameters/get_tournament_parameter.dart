import '../../../../core/constants/sota_api_constants.dart';

typedef DataMap = Map<String, String>;

class GetTournamentParameter {
  final int page;
  final int pageSize;
  final int? id;
  final int country;
  final bool? is_male;
  final String? search;
  final int? team;

  const GetTournamentParameter({
    this.page = 1,
    this.pageSize = 50,
    this.id,
    this.country = SotaApiConstant.KZCountryId,
    this.is_male,
    this.search,
    this.team,
  });

  DataMap toMap() {
    final map = <String, String>{
      "page": page.toString(),
      "page_size": pageSize.toString(),
      "country": country.toString(),
    };

    if (id != null) map["id"] = id.toString();
    if (search != null) map["search"] = search!;
    if (team != null) map["team"] = team.toString();
    if (is_male != null) map["is_male"] = is_male.toString();

    return map;
  }
}
