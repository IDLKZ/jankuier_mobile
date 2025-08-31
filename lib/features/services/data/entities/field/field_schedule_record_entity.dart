import 'package:equatable/equatable.dart';

class ScheduleRecordEntity extends Equatable {
  final int partyId;
  final int settingId;
  final String day; // формат YYYY-MM-DD
  final String startAt; // HH:mm:ss
  final String endAt; // HH:mm:ss
  final double price;
  final bool isBooked;
  final bool isPaid;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const ScheduleRecordEntity({
    required this.partyId,
    required this.settingId,
    required this.day,
    required this.startAt,
    required this.endAt,
    required this.price,
    required this.isBooked,
    required this.isPaid,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ScheduleRecordEntity.fromJson(Map<String, dynamic> json) {
    return ScheduleRecordEntity(
      partyId: json['party_id'],
      settingId: json['setting_id'],
      day: json['day'],
      startAt: json['start_at'],
      endAt: json['end_at'],
      price: double.parse(json['price'].toString()),
      isBooked: json['is_booked'],
      isPaid: json['is_paid'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'party_id': partyId,
      'setting_id': settingId,
      'day': day,
      'start_at': startAt,
      'end_at': endAt,
      'price': price,
      'is_booked': isBooked,
      'is_paid': isPaid,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        partyId,
        settingId,
        day,
        startAt,
        endAt,
        price,
        isBooked,
        isPaid,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}

class ScheduleGeneratorResponseEntity {
  final bool success;
  final String message;
  final int generatedCount;
  final List<ScheduleRecordEntity> scheduleRecords;

  const ScheduleGeneratorResponseEntity({
    required this.success,
    required this.message,
    required this.generatedCount,
    required this.scheduleRecords,
  });

  factory ScheduleGeneratorResponseEntity.fromJson(Map<String, dynamic> json) {
    return ScheduleGeneratorResponseEntity(
      success: json['success'],
      message: json['message'],
      generatedCount: json['generated_count'],
      scheduleRecords: (json['schedule_records'] as List<dynamic>)
          .map((e) => ScheduleRecordEntity.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'generated_count': generatedCount,
      'schedule_records':
          scheduleRecords.map((record) => record.toJson()).toList(),
    };
  }
}
