import 'package:equatable/equatable.dart';
import '../../../../../core/common/entities/file_entity.dart';
import 'academy_entity.dart';
import 'academy_group_entity.dart';

class AcademyGalleryEntity extends Equatable {
  final int id;
  final int academyId;
  final int? groupId;
  final int? fileId;

  final DateTime createdAt;
  final DateTime updatedAt;

  const AcademyGalleryEntity({
    required this.id,
    required this.academyId,
    this.groupId,
    this.fileId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AcademyGalleryEntity.fromJson(Map<String, dynamic> json) {
    return AcademyGalleryEntity(
      id: json['id'],
      academyId: json['academy_id'],
      groupId: json['group_id'],
      fileId: json['file_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'academy_id': academyId,
      'group_id': groupId,
      'file_id': fileId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        academyId,
        groupId,
        fileId,
        createdAt,
        updatedAt,
      ];
}

class AcademyGalleryWithRelationsEntity extends AcademyGalleryEntity {
  final AcademyEntity? academy;
  final AcademyGroupEntity? group;
  final FileEntity? file;

  const AcademyGalleryWithRelationsEntity({
    required super.id,
    required super.academyId,
    super.groupId,
    super.fileId,
    required super.createdAt,
    required super.updatedAt,
    this.academy,
    this.group,
    this.file,
  }) : super();

  factory AcademyGalleryWithRelationsEntity.fromJson(
      Map<String, dynamic> json) {
    return AcademyGalleryWithRelationsEntity(
      id: json['id'],
      academyId: json['academy_id'],
      groupId: json['group_id'],
      fileId: json['file_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      academy: json['academy'] != null
          ? AcademyEntity.fromJson(json['academy'])
          : null,
      group: json['group'] != null
          ? AcademyGroupEntity.fromJson(json['group'])
          : null,
      file: json['file'] != null ? FileEntity.fromJson(json['file']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'academy': academy?.toJson(),
      'group': group?.toJson(),
      'file': file?.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        ...super.props,
        academy,
        group,
        file,
      ];
}
