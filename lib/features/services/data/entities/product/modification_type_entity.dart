import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/core/mixins/localized_title_mixin.dart';

class ModificationTypeEntity extends Equatable with LocalizedTitleEntity {
  final int id;
  @override
  final String titleRu;
  @override
  final String? titleKk;
  @override
  final String? titleEn;
  final String value;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const ModificationTypeEntity({
    required this.id,
    required this.titleRu,
    this.titleKk,
    this.titleEn,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ModificationTypeEntity.fromJson(Map<String, dynamic> json) {
    return ModificationTypeEntity(
      id: json['id'],
      titleRu: json['title_ru'],
      titleKk: json['title_kk'],
      titleEn: json['title_en'],
      value: json['value'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title_ru': titleRu,
      'title_kk': titleKk,
      'title_en': titleEn,
      'value': value,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        titleRu,
        titleKk,
        titleEn,
        value,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}
