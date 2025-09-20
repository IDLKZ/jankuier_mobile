import 'package:equatable/equatable.dart';

class KffLeagueEntity extends Equatable {
  final int id;
  final String? section;
  final String? slug;
  final String? title;

  const KffLeagueEntity({
    required this.id,
    this.section,
    this.slug,
    this.title,
  });

  factory KffLeagueEntity.fromJson(Map<String, dynamic> json) {
    return KffLeagueEntity(
      id: json['id'],
      section: json['section'],
      slug: json['slug'],
      title: json['title'],
    );
  }

  @override
  List<Object?> get props => [id, section, slug, title];
}

class KffLeagueListEntity {
  static List<KffLeagueEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => KffLeagueEntity.fromJson(json)).toList();
  }
}
