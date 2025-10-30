import 'package:flutter/material.dart';
import 'yandex_afisha_ticket_entity.dart';

extension YandexAfishaWidgetTicketEntityExtension on YandexAfishaWidgetTicketEntity {
  /// Получить локализованное название билета
  String localizedTitle(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    switch (locale) {
      case 'kk':
        return titleKk ?? titleRu;
      case 'en':
        return titleEn ?? titleRu;
      default:
        return titleRu;
    }
  }

  /// Получить локализованное описание билета
  String? localizedDescription(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    switch (locale) {
      case 'kk':
        return descriptionKk ?? descriptionRu;
      case 'en':
        return descriptionEn ?? descriptionRu;
      default:
        return descriptionRu;
    }
  }

  /// Получить локализованный адрес билета
  String? localizedAddress(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    switch (locale) {
      case 'kk':
        return addressKk ?? addressRu;
      case 'en':
        return addressEn ?? addressRu;
      default:
        return addressRu;
    }
  }

  /// Получить локализованное название стадиона
  String? localizedStadium(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    switch (locale) {
      case 'kk':
        return stadiumKk ?? stadiumRu;
      case 'en':
        return stadiumEn ?? stadiumRu;
      default:
        return stadiumRu;
    }
  }
}
