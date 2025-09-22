// Entity для мультиязычных заголовков
import 'package:equatable/equatable.dart';

class KffLeagueTitleEntity extends Equatable {
  final String? ru;
  final String? kz;
  final String? en;

  const KffLeagueTitleEntity({
    this.ru,
    this.kz,
    this.en,
  });

  factory KffLeagueTitleEntity.fromJson(Map<String, dynamic> json) {
    return KffLeagueTitleEntity(
      ru: json['ru'],
      kz: json['kz'],
      en: json['en'],
    );
  }

  @override
  List<Object?> get props => [ru, kz, en];
}

// Entity для турнира/лиги
class KffLeagueChampionshipEntity extends Equatable {
  final int id;
  final String? slug;
  final KffLeagueTitleEntity? title;
  final String? logo;
  final String? tournamentClass;
  final int? position;
  final int? status;
  final int? withLink;
  final String? sotaId;

  const KffLeagueChampionshipEntity({
    required this.id,
    this.slug,
    this.title,
    this.logo,
    this.tournamentClass,
    this.position,
    this.status,
    this.withLink,
    this.sotaId,
  });

  factory KffLeagueChampionshipEntity.fromJson(Map<String, dynamic> json) {
    return KffLeagueChampionshipEntity(
      id: json['id'] ?? 0,
      slug: json['slug'],
      title: json['title'] != null
          ? KffLeagueTitleEntity.fromJson(json['title'])
          : null,
      logo: json['logo'],
      tournamentClass: json['class'],
      position: json['position'],
      status: json['status'],
      withLink: json['with_link'],
      sotaId: json['sota_id'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        slug,
        title,
        logo,
        tournamentClass,
        position,
        status,
        withLink,
        sotaId,
      ];
}

// Список турниров
class KffLeagueChampionshipListEntity {
  static List<KffLeagueChampionshipEntity> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => KffLeagueChampionshipEntity.fromJson(json))
        .toList();
  }
}
