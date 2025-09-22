import 'package:equatable/equatable.dart';

import 'kff_league_pagination_response_entity.dart';

class KffLeagueSeasonEntity extends Equatable {
  final int id;
  final String? title;
  final int? status;

  const KffLeagueSeasonEntity({
    required this.id,
    this.title,
    this.status,
  });

  factory KffLeagueSeasonEntity.fromJson(Map<String, dynamic> json) {
    return KffLeagueSeasonEntity(
      id: json['id'] ?? 0,
      title: json['title'],
      status: json['status'],
    );
  }

  @override
  List<Object?> get props => [id, title, status];
}
