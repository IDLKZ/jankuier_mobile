import 'package:flutter/cupertino.dart';

mixin LocalizedMessageEntity {
  String? get messageRu;
  String? get messageKk;
  String? get messageEn;

  String localizedMessage(BuildContext context) {
    final locale = Localizations.localeOf(context);

    switch (locale.languageCode) {
      case 'kk':
        return messageKk ?? messageRu ?? "-";
      case 'en':
        return messageEn ?? messageRu ?? "-";
      case 'ru':
        return messageRu ?? "-";
      default:
        return messageRu ?? "-";
    }
  }
}
