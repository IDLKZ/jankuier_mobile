// Parameter для создания запроса бронирования площадки
class CreateBookingFieldPartyRequestParameter {
  final int fieldPartyId;
  final String day;
  final String startAt;
  final String endAt;
  final String? email;
  final String? phone;

  const CreateBookingFieldPartyRequestParameter({
    required this.fieldPartyId,
    required this.day,
    required this.startAt,
    required this.endAt,
    this.email,
    this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'field_party_id': fieldPartyId,
      'day': day,
      'start_at': startAt,
      'end_at': endAt,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
    };
  }

  CreateBookingFieldPartyRequestParameter copyWith({
    int? fieldPartyId,
    String? day,
    String? startAt,
    String? endAt,
    String? email,
    String? phone,
  }) {
    return CreateBookingFieldPartyRequestParameter(
      fieldPartyId: fieldPartyId ?? this.fieldPartyId,
      day: day ?? this.day,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }
}
