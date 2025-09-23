class SendVerifyCodeParameter {
  final String phone;

  const SendVerifyCodeParameter({
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
    };
  }

  SendVerifyCodeParameter copyWith({
    String? phone,
  }) {
    return SendVerifyCodeParameter(
      phone: phone ?? this.phone,
    );
  }
}