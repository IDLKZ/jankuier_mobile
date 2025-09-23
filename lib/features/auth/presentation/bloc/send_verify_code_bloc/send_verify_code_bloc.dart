import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/auth/domain/usecases/send_verify_code_usecase.dart';
import 'send_verify_code_event.dart';
import 'send_verify_code_state.dart';

@injectable
class SendVerifyCodeBloc
    extends Bloc<SendVerifyCodeEvent, SendVerifyCodeState> {
  final SendVerifyCodeUseCase _sendVerifyCodeUseCase;

  SendVerifyCodeBloc(this._sendVerifyCodeUseCase)
      : super(const SendVerifyCodeInitial()) {
    on<SendVerifyCodeSubmitted>(_onSendVerifyCodeSubmitted);
    on<SendVerifyCodeReset>(_onSendVerifyCodeReset);
  }

  Future<void> _onSendVerifyCodeSubmitted(
      SendVerifyCodeSubmitted event, Emitter<SendVerifyCodeState> emit) async {
    emit(const SendVerifyCodeLoading());

    final result = await _sendVerifyCodeUseCase(event.phone);

    result.fold(
      (failure) => emit(
          SendVerifyCodeFailure(failure.message ?? 'Send verify code failed')),
      (verificationResult) => emit(SendVerifyCodeSuccess(verificationResult)),
    );
  }

  void _onSendVerifyCodeReset(
      SendVerifyCodeReset event, Emitter<SendVerifyCodeState> emit) {
    emit(const SendVerifyCodeInitial());
  }
}
