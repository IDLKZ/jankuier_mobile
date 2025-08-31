import 'package:equatable/equatable.dart';
import 'academy_entity.dart';
import 'academy_gallery_entity.dart';
import 'academy_group_entity.dart';

class GetFullAcademyEntity extends Equatable {
  final AcademyEntity academy;
  final List<AcademyGalleryWithRelationsEntity> galleries;
  final List<AcademyGroupEntity> groups;

  const GetFullAcademyEntity({
    required this.academy,
    this.galleries = const [],
    this.groups = const [],
  });

  factory GetFullAcademyEntity.fromJson(Map<String, dynamic> json) {
    return GetFullAcademyEntity(
      academy: AcademyEntity.fromJson(json['academy']),
      galleries: (json['galleries'] as List<dynamic>? ?? [])
          .map((e) => AcademyGalleryWithRelationsEntity.fromJson(e))
          .toList(),
      groups: (json['groups'] as List<dynamic>? ?? [])
          .map((e) => AcademyGroupEntity.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'academy': academy.toJson(),
      'galleries': galleries.map((e) => e.toJson()).toList(),
      'groups': groups.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [academy, galleries, groups];
}
