import 'package:flutter/cupertino.dart';

mixin LocalizedDescriptionEntity {
  String? get descriptionRu;
  String? get descriptionKk;
  String? get descriptionEn;

  String localizedDescription(BuildContext context) {
    final locale = Localizations.localeOf(context);

    switch (locale.languageCode) {
      case 'kk':
        return descriptionKk ?? descriptionRu ?? "-";
      case 'en':
        return descriptionEn ?? descriptionRu ?? "-";
      case 'ru':
      default:
        return descriptionRu ?? "-";
    }
  }
}
