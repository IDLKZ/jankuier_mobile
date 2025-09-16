import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/auth/data/entities/role_entity.dart';
import '../../../../core/common/entities/file_entity.dart';

class UserEntity extends Equatable {
  final int id;
  final int? roleId;
  final int? imageId;
  final String firstName;
  final String lastName;
  final String? patronomic;
  final String email;
  final String phone;
  final String username;
  final int sex;
  final String? iin;
  final DateTime birthdate;
  final bool isActive;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final RoleEntity? role;
  final FileEntity? image;

  const UserEntity({
    required this.id,
    this.roleId,
    this.imageId,
    required this.firstName,
    required this.lastName,
    this.patronomic,
    required this.email,
    required this.phone,
    required this.username,
    required this.sex,
    this.iin,
    required this.birthdate,
    required this.isActive,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.role,
    this.image,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      roleId: json['role_id'],
      imageId: json['image_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      patronomic: json['patronomic'],
      email: json['email'],
      phone: json['phone'],
      username: json['username'],
      sex: json['sex'],
      iin: json['iin'],
      birthdate: DateTime.parse(json['birthdate']),
      isActive: json['is_active'] ?? false,
      isVerified: json['is_verified'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      role: json['role'] != null ? RoleEntity.fromJson(json['role']) : null,
      image: json['image'] != null ? FileEntity.fromJson(json['image']) : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        roleId,
        imageId,
        firstName,
        lastName,
        patronomic,
        email,
        phone,
        username,
        sex,
        iin,
        birthdate,
        isActive,
        isVerified,
        createdAt,
        updatedAt,
        deletedAt,
        role,
        image,
      ];
}

class UserListEntity {
  static List<UserEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => UserEntity.fromJson(json)).toList();
  }
}
