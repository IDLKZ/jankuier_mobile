import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/shows/ticketon_city_shows_entity.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/shows/ticketon_event_shows_entity.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/shows/ticketon_place_shows_entity.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/shows/ticketon_show_shows_entity.dart';

class TicketonShowsDataEntity extends Equatable {
  final Map<int, TicketonShowsPlaceEntity> places;
  final Map<int, TicketonShowsEventEntity> events;
  final Map<int, TicketonShowsShowEntity> shows;
  final Map<int, TicketonShowsCityEntity> cities;

  const TicketonShowsDataEntity({
    required this.places,
    required this.events,
    required this.shows,
    required this.cities,
  });

  factory TicketonShowsDataEntity.fromJson(Map<String, dynamic> json) {
    return TicketonShowsDataEntity(
      places: (json['places'] as Map<String, dynamic>? ?? {}).map(
        (key, value) =>
            MapEntry(int.parse(key), TicketonShowsPlaceEntity.fromJson(value)),
      ),
      events: (json['events'] as Map<String, dynamic>? ?? {}).map(
        (key, value) =>
            MapEntry(int.parse(key), TicketonShowsEventEntity.fromJson(value)),
      ),
      shows: (json['shows'] as Map<String, dynamic>? ?? {}).map(
        (key, value) =>
            MapEntry(int.parse(key), TicketonShowsShowEntity.fromJson(value)),
      ),
      cities: (json['cities'] as Map<String, dynamic>? ?? {}).map(
        (key, value) =>
            MapEntry(int.parse(key), TicketonShowsCityEntity.fromJson(value)),
      ),
    );
  }

  /// Возвращает только валидные shows (где есть связанный event, place и city)
  List<TicketonShowsShowEntity> get validShows {
    final validShowsList = <TicketonShowsShowEntity>[];
    for (final entry in shows.entries) {
      final show = entry.value;
      // Проверяем наличие необходимых ID
      if (show.placeId == null || show.eventId == null) {
        continue;
      }
      // Проверяем place
      final place = places[show.placeId!];
      // Проверяем event
      final event = events[show.eventId!];
      if (event == null) {
        continue;
      }
      // Проверяем city через place
      final city = (place != null && place.cityId != null)
          ? cities[place.cityId!]
          : null;
      // Добавляем только валидные show
      if (place != null && city != null) {
        validShowsList.add(show);
      }
    }
    return validShowsList;
  }

  /// Возвращает событие по ID
  TicketonShowsEventEntity? getEventById(int eventId) {
    return events[eventId];
  }

  /// Возвращает место по ID
  TicketonShowsPlaceEntity? getPlaceById(int placeId) {
    return places[placeId];
  }

  /// Возвращает город по ID
  TicketonShowsCityEntity? getCityById(int cityId) {
    return cities[cityId];
  }

  /// Возвращает сеанс по ID
  TicketonShowsShowEntity? getShowById(int showId) {
    return shows[showId];
  }

  /// Возвращает все сеансы для определенного события
  List<TicketonShowsShowEntity> getShowsForEvent(int eventId) {
    return validShows.where((show) => show.eventId == eventId).toList();
  }

  /// Возвращает все сеансы для определенного места
  List<TicketonShowsShowEntity> getShowsForPlace(int placeId) {
    return validShows.where((show) => show.placeId == placeId).toList();
  }

  /// Возвращает все сеансы для определенного города
  List<TicketonShowsShowEntity> getShowsForCity(int cityId) {
    return validShows.where((show) {
      if (show.placeId == null) return false;
      final place = places[show.placeId!];
      return place?.cityId == cityId;
    }).toList();
  }

  /// Возвращает полную информацию о сеансе (show + event + place + city)
  ShowWithDetails? getShowWithDetails(int showId) {
    final show = shows[showId];
    if (show == null || show.eventId == null || show.placeId == null)
      return null;

    final event = events[show.eventId!];
    final place = places[show.placeId!];
    final city = place?.cityId != null ? cities[place!.cityId!] : null;

    if (event == null || place == null || city == null) return null;

    return ShowWithDetails(
      show: show,
      event: event,
      place: place,
      city: city,
    );
  }

  @override
  List<Object?> get props => [places, events, shows, cities];
}

/// Класс для полной информации о сеансе
class ShowWithDetails extends Equatable {
  final TicketonShowsShowEntity show;
  final TicketonShowsEventEntity event;
  final TicketonShowsPlaceEntity place;
  final TicketonShowsCityEntity city;

  const ShowWithDetails({
    required this.show,
    required this.event,
    required this.place,
    required this.city,
  });

  @override
  List<Object?> get props => [show, event, place, city];
}
