import 'package:jankuier_mobile/core/utils/typedef.dart';

class AcademyGroupScheduleByDayParameter {
  final DateTime day;
  final List<int> groupIds;

  AcademyGroupScheduleByDayParameter({
    required this.day,
    required this.groupIds,
  });

  /// Для API в формате query-параметров
  DataMap toQueryParameters() {
    final map = <String, List<String>>{};

    map["day"] = [day.toIso8601String().split("T").first]; // только YYYY-MM-DD
    map["group_ids"] = groupIds.map((e) => e.toString()).toList();

    return map;
  }

  /// Для логов / отладки
  DataMap toJson() {
    return {
      "day": day.toIso8601String().split("T").first,
      "group_ids": groupIds,
    };
  }

  /// CopyWith для обновления отдельных полей
  AcademyGroupScheduleByDayParameter copyWith({
    DateTime? day,
    List<int>? groupIds,
  }) {
    return AcademyGroupScheduleByDayParameter(
      day: day ?? this.day,
      groupIds: groupIds ?? this.groupIds,
    );
  }
}
