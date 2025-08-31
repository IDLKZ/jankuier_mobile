import 'package:equatable/equatable.dart';

class ScheduleTimeEntity extends Equatable {
  final int day;
  final String start;
  final String end;

  const ScheduleTimeEntity({
    required this.day,
    required this.start,
    required this.end,
  });

  factory ScheduleTimeEntity.fromJson(Map<String, dynamic> json) {
    return ScheduleTimeEntity(
      day: json['day'],
      start: json['start'],
      end: json['end'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'start': start,
      'end': end,
    };
  }

  @override
  List<Object?> get props => [day, start, end];
}

class PricePerTimeEntity extends Equatable {
  final int day;
  final String start;
  final String end;
  final double price;

  const PricePerTimeEntity({
    required this.day,
    required this.start,
    required this.end,
    required this.price,
  });

  factory PricePerTimeEntity.fromJson(Map<String, dynamic> json) {
    return PricePerTimeEntity(
      day: json['day'],
      start: json['start'],
      end: json['end'],
      price: double.parse(json['price'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'start': start,
      'end': end,
      'price': price,
    };
  }

  @override
  List<Object?> get props => [day, start, end, price];
}

class FieldPartyScheduleSettingsEntity extends Equatable {
  final int id;
  final int partyId;

  final DateTime activeStartAt;
  final DateTime activeEndAt;

  final List<int> workingDays;
  final List<String>? excludedDates;

  final List<ScheduleTimeEntity> workingTime;
  final List<ScheduleTimeEntity> breakTime;
  final List<PricePerTimeEntity> pricePerTime;

  final int sessionMinuteInt;
  final int breakBetweenSessionInt;
  final int bookedLimit;

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const FieldPartyScheduleSettingsEntity({
    required this.id,
    required this.partyId,
    required this.activeStartAt,
    required this.activeEndAt,
    required this.workingDays,
    this.excludedDates,
    required this.workingTime,
    required this.breakTime,
    required this.pricePerTime,
    required this.sessionMinuteInt,
    required this.breakBetweenSessionInt,
    required this.bookedLimit,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory FieldPartyScheduleSettingsEntity.fromJson(Map<String, dynamic> json) {
    return FieldPartyScheduleSettingsEntity(
      id: json['id'],
      partyId: json['party_id'],
      activeStartAt: DateTime.parse(json['active_start_at']),
      activeEndAt: DateTime.parse(json['active_end_at']),
      workingDays: (json['working_days'] as List).map((e) => e as int).toList(),
      excludedDates: json['excluded_dates'] != null
          ? List<String>.from(json['excluded_dates'])
          : null,
      workingTime: (json['working_time'] as List<dynamic>)
          .map((e) => ScheduleTimeEntity.fromJson(e))
          .toList(),
      breakTime: (json['break_time'] as List<dynamic>)
          .map((e) => ScheduleTimeEntity.fromJson(e))
          .toList(),
      pricePerTime: (json['price_per_time'] as List<dynamic>)
          .map((e) => PricePerTimeEntity.fromJson(e))
          .toList(),
      sessionMinuteInt: json['session_minute_int'],
      breakBetweenSessionInt: json['break_between_session_int'],
      bookedLimit: json['booked_limit'],
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
      'party_id': partyId,
      'active_start_at': activeStartAt.toIso8601String().split('T').first,
      'active_end_at': activeEndAt.toIso8601String().split('T').first,
      'working_days': workingDays,
      'excluded_dates': excludedDates,
      'working_time': workingTime.map((e) => e.toJson()).toList(),
      'break_time': breakTime.map((e) => e.toJson()).toList(),
      'price_per_time': pricePerTime.map((e) => e.toJson()).toList(),
      'session_minute_int': sessionMinuteInt,
      'break_between_session_int': breakBetweenSessionInt,
      'booked_limit': bookedLimit,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        partyId,
        activeStartAt,
        activeEndAt,
        workingDays,
        excludedDates,
        workingTime,
        breakTime,
        pricePerTime,
        sessionMinuteInt,
        breakBetweenSessionInt,
        bookedLimit,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}
