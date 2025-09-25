import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/core/mixins/localized_title_mixin.dart';

import '../../../../core/common/entities/sota_pagination_entity.dart';

class CountryEntity extends Equatable {
  final int id;
  final String name;
  final String flagImage;
  final String code;

  const CountryEntity({
    required this.id,
    required this.name,
    required this.flagImage,
    required this.code,
  });

  factory CountryEntity.fromJson(Map<String, dynamic> json) {
    return CountryEntity(
      id: json['id'],
      name: json['name'],
      flagImage: json['flag_image'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'flag_image': flagImage,
      'code': code,
    };
  }

  @override
  List<Object?> get props => [id, name, flagImage, code];
}

class LocalCountryEntity extends Equatable with LocalizedTitleEntity {
  final int id;
  @override
  final String titleRu;
  @override
  final String? titleKk;
  @override
  final String? titleEn;
  final String? sotaCode;
  final String? sotaFlagImage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<LocalCityEntity>? cities;

  const LocalCountryEntity({
    required this.id,
    required this.titleRu,
    this.titleKk,
    this.titleEn,
    this.sotaCode,
    this.sotaFlagImage,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.cities,
  });

  factory LocalCountryEntity.fromJson(Map<String, dynamic> json) {
    return LocalCountryEntity(
      id: json['id'],
      titleRu: json['title_ru'],
      titleKk: json['title_kk'],
      titleEn: json['title_en'],
      sotaCode: json['sota_code'],
      sotaFlagImage: json['sota_flag_image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      cities: json['cities'] != null
          ? LocalCityListEntity.fromJsonList(json['cities'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title_ru': titleRu,
      'title_kk': titleKk,
      'title_en': titleEn,
      'sota_code': sotaCode,
      'sota_flag_image': sotaFlagImage,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'cities': cities?.map((city) => city.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        titleRu,
        titleKk,
        titleEn,
        sotaCode,
        sotaFlagImage,
        createdAt,
        updatedAt,
        deletedAt,
        cities,
      ];
}

class LocalCountryListEntity {
  static List<LocalCountryEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => LocalCountryEntity.fromJson(json)).toList();
  }
}

// Placeholder для LocalCityEntity - нужно будет создать отдельно
class LocalCityEntity extends Equatable {
  final int id;
  final String name;

  const LocalCityEntity({
    required this.id,
    required this.name,
  });

  factory LocalCityEntity.fromJson(Map<String, dynamic> json) {
    return LocalCityEntity(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [id, name];
}

class LocalCityListEntity {
  static List<LocalCityEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => LocalCityEntity.fromJson(json)).toList();
  }
}
