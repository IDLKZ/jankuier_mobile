import 'package:flutter/cupertino.dart';

mixin LocalizedLocaleEntity {
  String? get ru;
  String? get kz;
  String? get en;

  String localizedLocale(BuildContext context) {
    final locale = Localizations.localeOf(context);

    switch (locale.languageCode) {
      case 'kk':
        return kz ?? ru ?? "-";
      case 'en':
        return en ?? ru ?? "-";
      case 'ru':
      default:
        return ru ?? "-";
    }
  }
}
