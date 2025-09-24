import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/entities/from_kff/kff_league_player_entity.dart';

Map<String, List<KffLeaguePlayerEntity>> groupByLineTitle(List<KffLeaguePlayerEntity> players) {
  final Map<String, List<KffLeaguePlayerEntity>> grouped = {};
  for (var player in players) {
    final line = player.line;
    final title = (line != null && line.title != null) ? line.title as String : 'Не указано';

    if (!grouped.containsKey(title)) {
      grouped[title] = [];
    }
    grouped[title]!.add(player);
  }
  return grouped;
}

String firstLetterCapitalized(String name) {
  if (name.isEmpty) return '';
  return '${name[0].toUpperCase()}.';
}

/// Форматирует дату и время для отображения
/// Параметр [dateTime] - строка с датой в ISO формате
/// Возвращает отформатированную строку вида "DD.MM.YYYY\nHH:MM"
String formatDateTime(String? dateTime) {
  if (dateTime == null) return 'Время не указано';
  try {
    final dt = DateTime.parse(dateTime);
    return '${dt.day}.${dt.month.toString().padLeft(2, '0')}.${dt.year}\n${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  } catch (e) {
    return 'Неверный формат';
  }
}

/// Возвращает иконку для позиции игрока
IconData getPositionIcon(String position) {
  switch (position.toLowerCase()) {
    case 'вратарь':
    case 'goalkeeper':
      return Icons.sports_handball;
    case 'защитник':
    case 'defender':
      return Icons.shield;
    case 'полузащитник':
    case 'midfielder':
      return Icons.compare_arrows;
    case 'нападающий':
    case 'forward':
    case 'striker':
      return Icons.sports_soccer;
    default:
      return Icons.person;
  }
}