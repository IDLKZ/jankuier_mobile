import 'package:equatable/equatable.dart';
import 'academy_group_entity.dart';

class AcademyGroupScheduleEntity extends Equatable {
  final int id;
  final int groupId;

  final DateTime trainingDate;
  final String startAt; // время лучше хранить строкой "HH:mm:ss"
  final String endAt;

  final DateTime? rescheduleStartAt;
  final DateTime? rescheduleEndAt;

  final bool isActive;
  final bool isCanceled;
  final bool isFinished;

  final DateTime createdAt;
  final DateTime updatedAt;

  final AcademyGroupEntity? group;

  const AcademyGroupScheduleEntity({
    required this.id,
    required this.groupId,
    required this.trainingDate,
    required this.startAt,
    required this.endAt,
    this.rescheduleStartAt,
    this.rescheduleEndAt,
    this.isActive = true,
    this.isCanceled = false,
    this.isFinished = false,
    required this.createdAt,
    required this.updatedAt,
    this.group,
  });

  factory AcademyGroupScheduleEntity.fromJson(Map<String, dynamic> json) {
    return AcademyGroupScheduleEntity(
      id: json['id'],
      groupId: json['group_id'],
      trainingDate: DateTime.parse(json['training_date']),
      startAt: json['start_at'], // строка "HH:mm:ss"
      endAt: json['end_at'],
      rescheduleStartAt: json['reschedule_start_at'] != null
          ? DateTime.parse(json['reschedule_start_at'])
          : null,
      rescheduleEndAt: json['reschedule_end_at'] != null
          ? DateTime.parse(json['reschedule_end_at'])
          : null,
      isActive: json['is_active'] ?? true,
      isCanceled: json['is_canceled'] ?? false,
      isFinished: json['is_finished'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      group: json['group'] != null
          ? AcademyGroupEntity.fromJson(json['group'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': groupId,
      'training_date': trainingDate.toIso8601String().split('T').first,
      'start_at': startAt,
      'end_at': endAt,
      'reschedule_start_at': rescheduleStartAt?.toIso8601String(),
      'reschedule_end_at': rescheduleEndAt?.toIso8601String(),
      'is_active': isActive,
      'is_canceled': isCanceled,
      'is_finished': isFinished,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'group': group?.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        groupId,
        trainingDate,
        startAt,
        endAt,
        rescheduleStartAt,
        rescheduleEndAt,
        isActive,
        isCanceled,
        isFinished,
        createdAt,
        updatedAt,
        group,
      ];
}

class AcademyGroupScheduleListEntity {
  static List<AcademyGroupScheduleEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => AcademyGroupScheduleEntity.fromJson(json))
        .toList();
  }
}
