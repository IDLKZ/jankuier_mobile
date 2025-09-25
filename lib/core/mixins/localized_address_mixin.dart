import 'package:flutter/cupertino.dart';

mixin LocalizedAddressEntity {
  String? get addressRu;
  String? get addressKk;
  String? get addressEn;

  String localizedAddress(BuildContext context) {
    final locale = Localizations.localeOf(context);

    switch (locale.languageCode) {
      case 'kk':
        return addressKk ?? addressRu ?? "-";
      case 'en':
        return addressEn ?? addressRu ?? "-";
      case 'ru':
      default:
        return addressRu ?? "-";
    }
  }
}
