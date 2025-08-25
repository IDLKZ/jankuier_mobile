import 'package:equatable/equatable.dart';

class TournamentEntity extends Equatable {
  final int id;
  final String name;
  final String createdAt;
  final String updatedAt;
  final bool isInternational;
  final String? image;
  final bool showInStats;
  final String? lastFullCalculatedAt;
  final bool isMale;
  final int? sport;

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
  });

  factory TournamentEntity.fromJson(Map<String, dynamic> json) {
    return TournamentEntity(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      isInternational: json['is_international'] as bool,
      image: json['image'] as String?,
      showInStats: json['show_in_stats'] as bool,
      lastFullCalculatedAt: json['last_full_calculated_at'] as String?,
      isMale: json['is_male'] as bool,
      sport: json['sport'] as int?,
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
      ];
}
