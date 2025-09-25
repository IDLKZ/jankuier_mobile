import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

String formatDate(String dateString) {
  try {
    // Преобразуем строку в объект DateTime.
    final dateTime = DateTime.parse(dateString);

    // Получаем день, месяц и год из объекта DateTime.
    // padLeft(2, '0') добавляет ведущий ноль, если число состоит из одной цифры (например, 7 -> 07).
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year;

    // Собираем строку в нужном формате.
    return "$day.$month.$year";
  } catch (e) {
    // Если строка не соответствует формату, возвращаем её без изменений.
    return dateString;
  }
}

String formatNewsDate(BuildContext context, String dateString) {
  try {
    final dateTime = DateTime.parse(dateString);
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} ${AppLocalizations.of(context)!.daysAgoShort}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${AppLocalizations.of(context)!.hoursAgoShort}';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${AppLocalizations.of(context)!.minutesAgoShort}';
    } else {
      return AppLocalizations.of(context)!.justNow;
    }
  } catch (e) {
    return dateString;
  }
}