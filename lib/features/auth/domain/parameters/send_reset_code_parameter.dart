class SendResetCodeParameter {
  final String phone;

  const SendResetCodeParameter({
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
    };
  }

  SendResetCodeParameter copyWith({
    String? phone,
  }) {
    return SendResetCodeParameter(
      phone: phone ?? this.phone,
    );
  }
}
