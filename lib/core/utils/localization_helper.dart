import 'package:flutter/widgets.dart';

/// Helper класс для автоматического выбора локализованного контента
class LocalizationHelper {
  /// Получает локализованный текст на основе текущего языка
  static String getLocalizedText(
    BuildContext context, {
    String? kk,
    required String ru,
    String? en,
  }) {
    final locale = Localizations.localeOf(context);

    switch (locale.languageCode) {
      case 'kk':
        return kk ?? ru;
      case 'en':
        return en ?? ru;
      case 'ru':
      default:
        return ru;
    }
  }

  /// Получает локализованный текст из объекта с полями title
  static String getLocalizedTitle(
    BuildContext context,
    dynamic titleObject,
  ) {
    if (titleObject == null) return '';

    return getLocalizedText(
      context,
      kk: titleObject.kk,
      ru: titleObject.ru ?? '',
      en: titleObject.en,
    );
  }

  /// Получает локализованный текст из объекта с полями description
  static String getLocalizedDescription(
    BuildContext context,
    dynamic descriptionObject,
  ) {
    if (descriptionObject == null) return '';

    return getLocalizedText(
      context,
      kk: descriptionObject.kk,
      ru: descriptionObject.ru ?? '',
      en: descriptionObject.en,
    );
  }

  /// Получает локализованный текст из объекта с полями address
  static String getLocalizedAddress(
    BuildContext context,
    dynamic addressObject,
  ) {
    if (addressObject == null) return '';

    return getLocalizedText(
      context,
      kk: addressObject.kk,
      ru: addressObject.ru ?? '',
      en: addressObject.en,
    );
  }

  /// Получает локализованный текст из объекта с прямыми полями title*
  /// Для объектов с полями titleRu, titleKk, titleEn
  static String getLocalizedDirectTitle(
    BuildContext context,
    dynamic entity,
  ) {
    if (entity == null) return '';

    return getLocalizedText(
      context,
      kk: entity.titleKk,
      ru: entity.titleRu ?? '',
      en: entity.titleEn,
    );
  }

  /// Получает локализованный текст из объекта с прямыми полями description*
  /// Для объектов с полями descriptionRu, descriptionKk, descriptionEn
  static String getLocalizedDirectDescription(
    BuildContext context,
    dynamic entity,
  ) {
    if (entity == null) return '';

    return getLocalizedText(
      context,
      kk: entity.descriptionKk,
      ru: entity.descriptionRu ?? '',
      en: entity.descriptionEn,
    );
  }

  /// Получает локализованный текст из объекта с прямыми полями address*
  /// Для объектов с полями addressRu, addressKk, addressEn
  static String getLocalizedDirectAddress(
    BuildContext context,
    dynamic entity,
  ) {
    if (entity == null) return '';

    return getLocalizedText(
      context,
      kk: entity.addressKk,
      ru: entity.addressRu ?? '',
      en: entity.addressEn,
    );
  }

  /// Получает локализованный текст из объекта с прямыми полями price*
  /// Для объектов с полями pricePerRu, pricePerKk, pricePerEn
  static String getLocalizedDirectPricePer(
    BuildContext context,
    dynamic entity,
  ) {
    if (entity == null) return '';

    return getLocalizedText(
      context,
      kk: entity.pricePerKk,
      ru: entity.pricePerRu ?? '',
      en: entity.pricePerEn,
    );
  }
}

/// Extension методы для удобного использования
extension LocalizedTextExtension on BuildContext {
  /// Получает локализованный текст на основе текущего языка
  String localizedText({
    String? kk,
    required String ru,
    String? en,
  }) {
    return LocalizationHelper.getLocalizedText(
      this,
      kk: kk,
      ru: ru,
      en: en,
    );
  }

  /// Получает локализованный title из объекта
  String localizedTitle(dynamic titleObject) {
    return LocalizationHelper.getLocalizedTitle(this, titleObject);
  }

  /// Получает локализованный description из объекта
  String localizedDescription(dynamic descriptionObject) {
    return LocalizationHelper.getLocalizedDescription(this, descriptionObject);
  }

  /// Получает локализованный address из объекта
  String localizedAddress(dynamic addressObject) {
    return LocalizationHelper.getLocalizedAddress(this, addressObject);
  }

  /// Получает локализованный title из объекта с прямыми полями titleRu, titleKk, titleEn
  String localizedDirectTitle(dynamic entity) {
    return LocalizationHelper.getLocalizedDirectTitle(this, entity);
  }

  /// Получает локализованный description из объекта с прямыми полями descriptionRu, descriptionKk, descriptionEn
  String localizedDirectDescription(dynamic entity) {
    return LocalizationHelper.getLocalizedDirectDescription(this, entity);
  }

  /// Получает локализованный address из объекта с прямыми полями addressRu, addressKk, addressEn
  String localizedDirectAddress(dynamic entity) {
    return LocalizationHelper.getLocalizedDirectAddress(this, entity);
  }

  /// Получает локализованный address из объекта с прямыми полями pricePerRu, pricePerKk, pricePerEn
  String localizedDirectPricePer(dynamic entity) {
    return LocalizationHelper.getLocalizedDirectPricePer(this, entity);
  }
}