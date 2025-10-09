import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/user_reset_parameter.dart';
import 'package:jankuier_mobile/features/auth/domain/usecases/send_reset_code_usecase.dart';
import 'package:jankuier_mobile/features/auth/domain/usecases/verify_reset_code_usecase.dart';
import 'reset_password_event.dart';
import 'reset_password_state.dart';

@injectable
class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final SendResetCodeUseCase _sendResetCodeUseCase;
  final VerifyResetCodeUseCase _verifyResetCodeUseCase;

  ResetPasswordBloc(
    this._sendResetCodeUseCase,
    this._verifyResetCodeUseCase,
  ) : super(const ResetPasswordInitial()) {
    on<SendResetCodeSubmitted>(_onSendResetCodeSubmitted);
    on<VerifyResetCodeSubmitted>(_onVerifyResetCodeSubmitted);
    on<ResetPasswordReset>(_onResetPasswordReset);
  }

  Future<void> _onSendResetCodeSubmitted(
    SendResetCodeSubmitted event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(const ResetPasswordLoading());

    final result = await _sendResetCodeUseCase(event.phone);

    result.fold(
      (failure) => emit(
        ResetPasswordFailure(failure.message ?? 'Failed to send reset code'),
      ),
      (resetResult) => emit(SendResetCodeSuccess(resetResult)),
    );
  }

  Future<void> _onVerifyResetCodeSubmitted(
    VerifyResetCodeSubmitted event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(const ResetPasswordLoading());

    final params = UserCodeResetParameter(
      phone: event.phone,
      code: event.code,
      newPassword: event.newPassword,
    );

    final result = await _verifyResetCodeUseCase(params);

    result.fold(
      (failure) => emit(
        ResetPasswordFailure(failure.message ?? 'Failed to verify reset code'),
      ),
      (resetResult) => emit(VerifyResetCodeSuccess(resetResult)),
    );
  }

  void _onResetPasswordReset(
    ResetPasswordReset event,
    Emitter<ResetPasswordState> emit,
  ) {
    emit(const ResetPasswordInitial());
  }
}
