import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/send_verify_code_parameter.dart';

abstract class SendVerifyCodeEvent extends Equatable {
  const SendVerifyCodeEvent();

  @override
  List<Object?> get props => [];
}

class SendVerifyCodeSubmitted extends SendVerifyCodeEvent {
  final String phone;

  const SendVerifyCodeSubmitted(this.phone);

  @override
  List<Object?> get props => [phone];
}

class SendVerifyCodeReset extends SendVerifyCodeEvent {
  const SendVerifyCodeReset();
}
