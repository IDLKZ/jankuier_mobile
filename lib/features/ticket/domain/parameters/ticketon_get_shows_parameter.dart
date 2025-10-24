import 'package:flutter/widgets.dart';

import '../../../../core/constants/ticketon_api_constants.dart';
import '../../../../core/utils/typedef.dart';
import '../../../../core/utils/localization_helper.dart';

class TicketonGetShowsParameter {
  final int? place;
  final String? withParam;
  final String? i18n;
  final String? type;

  const TicketonGetShowsParameter(
      {this.place,
      this.withParam = "future",
      this.i18n = "ru",
      this.type = TicketonApiConstant.CategoryType});

  /// Создает параметр с автоматическим определением языка из контекста
  factory TicketonGetShowsParameter.withLocale(
    BuildContext context, {
    int? place,
    String? withParam = "future",
    String? type = TicketonApiConstant.CategoryType,
  }) {
    final locale = Localizations.localeOf(context);
    String i18nCode;

    switch (locale.languageCode) {
      case 'kk':
        i18nCode = 'kk';
        break;
      case 'en':
        i18nCode = 'en';
        break;
      case 'ru':
      default:
        i18nCode = 'ru';
        break;
    }

    return TicketonGetShowsParameter(
      place: place,
      withParam: withParam,
      i18n: i18nCode,
      type: type,
    );
  }

  /// Создает параметр с автоматическим определением языка из LocalizationService
  /// Используется в блоках где нет доступа к BuildContext
  factory TicketonGetShowsParameter.withCurrentLocale({
    int? place,
    String? withParam = "future",
    String? type = TicketonApiConstant.CategoryType,
  }) {
    String languageCode;
    try {
      languageCode = LocalizationHelper.getCurrentLanguageCode();
    } catch (e) {
      // Fallback если не удалось получить язык
      languageCode = 'kk';
    }

    return TicketonGetShowsParameter(
      place: place,
      withParam: withParam,
      i18n: languageCode,
      type: type,
    );
  }

  DataMap toMap() {
    DataMap map = {
      "type": type.toString(),
      "with": withParam.toString(),
      "i18n": i18n.toString(),
    };
    if (place != null) {
      map["place"] = place.toString();
    }
    return map;
  }
}
