import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'tournament_entity.g.dart';

@HiveType(typeId: 1)
class TournamentEntity extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String createdAt;
  @HiveField(3)
  final String updatedAt;
  @HiveField(4)
  final bool isInternational;
  @HiveField(5)
  final String? image;
  @HiveField(6)
  final bool showInStats;
  @HiveField(7)
  final String? lastFullCalculatedAt;
  @HiveField(8)
  final bool isMale;
  @HiveField(9)
  final int? sport;
  @HiveField(10)
  final List<SeasonEntity> seasons;

  const TournamentEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.isInternational,
    this.image,
    required this.showInStats,
    this.lastFullCalculatedAt,
    required this.isMale,
    this.sport,
    required this.seasons,
  });

  factory TournamentEntity.fromJson(Map<String, dynamic> json) {
    return TournamentEntity(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      isInternational: json['is_international'],
      image: json['image'],
      showInStats: json['show_in_stats'],
      lastFullCalculatedAt: json['last_full_calculated_at'],
      isMale: json['is_male'],
      sport: json['sport'],
      seasons: (json['seasons'] as List<dynamic>?)
              ?.map((e) => SeasonEntity.fromJson(Map<String, dynamic>.from(e)))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_international': isInternational,
      'image': image,
      'show_in_stats': showInStats,
      'last_full_calculated_at': lastFullCalculatedAt,
      'is_male': isMale,
      'sport': sport,
      'seasons': seasons.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        createdAt,
        updatedAt,
        isInternational,
        image,
        showInStats,
        lastFullCalculatedAt,
        isMale,
        sport,
        seasons,
      ];
}

@HiveType(typeId: 2)
class SeasonEntity extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final DateTime startDate;
  @HiveField(3)
  final DateTime endDate;
  @HiveField(4)
  final List<int> teams;

  const SeasonEntity({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.teams,
  });

  factory SeasonEntity.fromJson(Map<String, dynamic> json) {
    return SeasonEntity(
      id: json['id'],
      name: json['name'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      teams: List<int>.from(json['teams']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'teams': teams,
    };
  }

  @override
  List<Object?> get props => [id, name, startDate, endDate, teams];
}
