import 'package:jankuier_mobile/core/utils/typedef.dart';

class FieldPartySchedulePreviewParameter {
  final int fieldPartyId;
  final DateTime day;

  const FieldPartySchedulePreviewParameter({
    required this.fieldPartyId,
    required this.day,
  });

  /// Простой map
  Map<String, String> toFlatMap() {
    return {
      'field_party_id': fieldPartyId.toString(),
      'day': day.toIso8601String().split('T').first, // YYYY-MM-DD
    };
  }

  /// MultiDataMap (если API поддерживает повторяющиеся ключи)
  DataMap toQueryParameters() {
    return {
      'field_party_id': [fieldPartyId.toString()],
      'day': [day.toIso8601String().split('T').first],
    };
  }
}
