import 'package:flutter/cupertino.dart';

mixin LocalizedLocaleEntity {
  String? get ru;
  String? get kk;
  String? get en;

  String localizedLocale(BuildContext context) {
    final locale = Localizations.localeOf(context);

    switch (locale.languageCode) {
      case 'kk':
        return kk ?? ru ?? "-";
      case 'en':
        return en ?? ru ?? "-";
      case 'ru':
      default:
        return ru ?? "-";
    }
  }
}
