import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/shows/ticketon_price_entity.dart';

class TicketonShowsShowEntity extends Equatable {
  final String? id;
  final int? placeId;
  final String? hallId;
  final int? eventId;
  final String? timestamp;
  final String? hall;
  final String? language;
  final String? format;
  final String? shift;
  final String? name;
  final String? sessionFormat;
  final String? sessionId;
  final DateTime? dateTime;
  final List<TicketonPrice>? prices;

  const TicketonShowsShowEntity({
    this.id,
    this.placeId,
    this.hallId,
    this.eventId,
    this.timestamp,
    this.hall,
    this.language,
    this.format,
    this.shift,
    this.name,
    this.sessionFormat,
    this.sessionId,
    this.dateTime,
    this.prices,
  });

  factory TicketonShowsShowEntity.fromJson(Map<String, dynamic> json) {
    final pricesList = json['prices'] as List?;
    final prices = pricesList?.map((price) => TicketonPrice.fromJson(price)).toList();
    return TicketonShowsShowEntity(
      id: json['id']?.toString(),
      placeId: int.tryParse(json['place']?.toString() ?? ''),
      hallId: json['hall_id']?.toString(),
      eventId: int.tryParse(json['event']?.toString() ?? ''),
      timestamp: json['ts']?.toString(),
      hall: json['hall'],
      language: json['lang'],
      format: json['format'],
      shift: json['shift']?.toString(),
      name: json['name'],
      sessionFormat: json['session_format'],
      sessionId: json['session_id']?.toString(),
      dateTime: DateTime.tryParse(json['dt'] ?? ''),
      prices: prices,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (placeId != null) 'place': placeId,
      if (hallId != null) 'hall_id': hallId,
      if (eventId != null) 'event': eventId,
      if (timestamp != null) 'ts': timestamp,
      if (hall != null) 'hall': hall,
      if (language != null) 'lang': language,
      if (format != null) 'format': format,
      if (shift != null) 'shift': shift,
      if (name != null) 'name': name,
      if (sessionFormat != null) 'session_format': sessionFormat,
      if (sessionId != null) 'session_id': sessionId,
      if (dateTime != null) 'dt': dateTime!.toIso8601String(),
      if (prices != null) 'prices': prices!.map((price) => price.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        placeId,
        hallId,
        eventId,
        timestamp,
        hall,
        language,
        format,
        shift,
        name,
        sessionFormat,
        sessionId,
        dateTime,
        prices
      ];
}
