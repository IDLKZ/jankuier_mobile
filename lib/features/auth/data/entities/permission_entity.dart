import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/mixins/localized_title_mixin.dart';
import '../../../../l10n/app_localizations.dart';

class PermissionEntity extends Equatable with LocalizedTitleEntity {
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

  const PermissionEntity({
    required this.id,
    required this.titleRu,
    this.titleKk,
    this.titleEn,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory PermissionEntity.fromJson(Map<String, dynamic> json) {
    return PermissionEntity(
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

  /// Возвращает локализованный заголовок
  String localizedTitle(BuildContext context) {
    final locale = AppLocalizations.of(context)?.localeName;
    switch (locale) {
      case 'kk':
        return titleKk ?? titleRu;
      case 'en':
        return titleEn ?? titleRu;
      case 'ru':
      default:
        return titleRu;
    }
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

class PermissionListEntity {
  static List<PermissionEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PermissionEntity.fromJson(json)).toList();
  }
}
