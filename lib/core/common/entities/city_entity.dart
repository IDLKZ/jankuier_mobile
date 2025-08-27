import 'package:equatable/equatable.dart';

import '../../../features/countries/data/entities/country_entity.dart';

class CityEntity extends Equatable {
  final int id;
  final int countryId;
  final String titleRu;
  final String? titleKk;
  final String? titleEn;
  final int? ticketonCityId;
  final String? ticketonTag;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final CountryEntity? country;

  const CityEntity({
    required this.id,
    required this.countryId,
    required this.titleRu,
    this.titleKk,
    this.titleEn,
    this.ticketonCityId,
    this.ticketonTag,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.country,
  });

  factory CityEntity.fromJson(Map<String, dynamic> json) {
    return CityEntity(
      id: json['id'],
      countryId: json['country_id'],
      titleRu: json['title_ru'],
      titleKk: json['title_kk'],
      titleEn: json['title_en'],
      ticketonCityId: json['ticketon_city_id'],
      ticketonTag: json['ticketon_tag'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      country: json['country'] != null
          ? CountryEntity.fromJson(json['country'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country_id': countryId,
      'title_ru': titleRu,
      'title_kk': titleKk,
      'title_en': titleEn,
      'ticketon_city_id': ticketonCityId,
      'ticketon_tag': ticketonTag,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'country': country?.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        countryId,
        titleRu,
        titleKk,
        titleEn,
        ticketonCityId,
        ticketonTag,
        createdAt,
        updatedAt,
        deletedAt,
        country,
      ];
}
