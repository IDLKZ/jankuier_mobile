import 'package:equatable/equatable.dart';
import 'field_party_entity.dart';

class FieldPartyScheduleEntity extends Equatable {
  final int id;
  final int partyId;
  final int settingId;

  final DateTime day;
  final String startAt; // время лучше хранить строкой в формате HH:mm:ss
  final String endAt;

  final double price;

  final bool isBooked;
  final bool isPaid;

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  final FieldPartyEntity? party;

  const FieldPartyScheduleEntity({
    required this.id,
    required this.partyId,
    required this.settingId,
    required this.day,
    required this.startAt,
    required this.endAt,
    required this.price,
    this.isBooked = false,
    this.isPaid = false,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.party,
  });

  factory FieldPartyScheduleEntity.fromJson(Map<String, dynamic> json) {
    return FieldPartyScheduleEntity(
      id: json['id'],
      partyId: json['party_id'],
      settingId: json['setting_id'],
      day: DateTime.parse(json['day']),
      startAt: json['start_at'], // строка "HH:mm:ss"
      endAt: json['end_at'],
      price: double.parse(json['price'].toString()),
      isBooked: json['is_booked'] ?? false,
      isPaid: json['is_paid'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      party: json['party'] != null
          ? FieldPartyEntity.fromJson(json['party'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'party_id': partyId,
      'setting_id': settingId,
      'day': day.toIso8601String().split('T').first, // только дата
      'start_at': startAt,
      'end_at': endAt,
      'price': price,
      'is_booked': isBooked,
      'is_paid': isPaid,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'party': party?.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        id,
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
        party,
      ];
}

class FieldPartyScheduleListEntity {
  static List<FieldPartyScheduleEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => FieldPartyScheduleEntity.fromJson(json))
        .toList();
  }
}
