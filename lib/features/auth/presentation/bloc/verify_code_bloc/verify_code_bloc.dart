import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/auth/domain/usecases/verify_code_usecase.dart';
import 'verify_code_event.dart';
import 'verify_code_state.dart';

@injectable
class VerifyCodeBloc extends Bloc<VerifyCodeEvent, VerifyCodeState> {
  final VerifyCodeUseCase _verifyCodeUseCase;

  VerifyCodeBloc(this._verifyCodeUseCase)
      : super(const VerifyCodeInitial()) {
    on<VerifyCodeSubmitted>(_onVerifyCodeSubmitted);
    on<VerifyCodeReset>(_onVerifyCodeReset);
  }

  Future<void> _onVerifyCodeSubmitted(
      VerifyCodeSubmitted event, Emitter<VerifyCodeState> emit) async {
    emit(const VerifyCodeLoading());

    final result = await _verifyCodeUseCase(event.parameter);

    result.fold(
      (failure) => emit(VerifyCodeFailure(failure.message ?? 'Verify code failed')),
      (verificationResult) => emit(VerifyCodeSuccess(verificationResult)),
    );
  }

  void _onVerifyCodeReset(VerifyCodeReset event, Emitter<VerifyCodeState> emit) {
    emit(const VerifyCodeInitial());
  }
}