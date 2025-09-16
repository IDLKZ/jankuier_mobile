import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/auth/data/entities/permission_entity.dart';

class RoleEntity extends Equatable {
  final int id;
  final String titleRu;
  final String titleKk;
  final String? titleEn;
  final String? descriptionRu;
  final String? descriptionKk;
  final String? descriptionEn;
  final String value;
  final bool isActive;
  final bool canRegister;
  final bool isSystem;
  final bool isAdministrative;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<PermissionEntity> permissions;

  const RoleEntity({
    required this.id,
    required this.titleRu,
    required this.titleKk,
    this.titleEn,
    this.descriptionRu,
    this.descriptionKk,
    this.descriptionEn,
    required this.value,
    required this.isActive,
    required this.canRegister,
    required this.isSystem,
    required this.isAdministrative,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.permissions,
  });

  factory RoleEntity.fromJson(Map<String, dynamic> json) {
    return RoleEntity(
      id: json['id'],
      titleRu: json['title_ru'],
      titleKk: json['title_kk'],
      titleEn: json['title_en'],
      descriptionRu: json['description_ru'],
      descriptionKk: json['description_kk'],
      descriptionEn: json['description_en'],
      value: json['value'],
      isActive: json['is_active'] ?? true,
      canRegister: json['can_register'] ?? false,
      isSystem: json['is_system'] ?? false,
      isAdministrative: json['is_administrative'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      permissions: json['permissions'] != null
          ? PermissionListEntity.fromJsonList(json['permissions'])
          : [],
    );
  }

  @override
  List<Object?> get props => [
        id,
        titleRu,
        titleKk,
        titleEn,
        descriptionRu,
        descriptionKk,
        descriptionEn,
        value,
        isActive,
        canRegister,
        isSystem,
        isAdministrative,
        createdAt,
        updatedAt,
        deletedAt,
        permissions,
      ];
}

class RoleListEntity {
  static List<RoleEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => RoleEntity.fromJson(json)).toList();
  }
}
