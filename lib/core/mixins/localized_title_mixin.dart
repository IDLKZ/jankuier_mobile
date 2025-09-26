import 'package:flutter/widgets.dart';

mixin LocalizedTitleEntity {
  String get titleRu;
  String? get titleKk;
  String? get titleEn;

  String localizedTitle(BuildContext context) {
    final locale = Localizations.localeOf(context);

    switch (locale.languageCode) {
      case 'kk':
        return titleKk ?? titleRu;
      case 'en':
        return titleEn ?? titleRu;
      case 'ru':
        return titleRu;
      default:
        return titleRu;
    }
  }
}
