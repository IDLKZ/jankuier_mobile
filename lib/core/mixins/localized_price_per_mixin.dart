import 'package:flutter/cupertino.dart';

mixin LocalizedPricePerEntity {
  String? get pricePerRu;
  String? get pricePerKk;
  String? get pricePerEn;

  String localizedPricePer(BuildContext context) {
    final locale = Localizations.localeOf(context);

    switch (locale.languageCode) {
      case 'kk':
        return pricePerKk ?? pricePerRu ?? "-";
      case 'en':
        return pricePerEn ?? pricePerRu ?? "-";
      case 'ru':
      default:
        return pricePerRu ?? "-";
    }
  }
}
