import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/auth/domain/usecases/sign_up_usecase.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase _signUpUseCase;

  SignUpBloc(this._signUpUseCase) : super(const SignUpInitial()) {
    on<SignUpSubmitted>(_onSignUpSubmitted);
    on<SignUpReset>(_onSignUpReset);
  }

  Future<void> _onSignUpSubmitted(
      SignUpSubmitted event, Emitter<SignUpState> emit) async {
    emit(const SignUpLoading());

    final result = await _signUpUseCase(event.registerParameter);

    result.fold(
      (failure) => emit(SignUpFailure(failure.message ?? 'Sign up failed')),
      (user) => emit(SignUpSuccess(user)),
    );
  }

  void _onSignUpReset(SignUpReset event, Emitter<SignUpState> emit) {
    emit(const SignUpInitial());
  }
}