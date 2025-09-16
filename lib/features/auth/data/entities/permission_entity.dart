import 'package:equatable/equatable.dart';

class PermissionEntity extends Equatable {
  final int id;
  final String titleRu;
  final String? titleKk;
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
