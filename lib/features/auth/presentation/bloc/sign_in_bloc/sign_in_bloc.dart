import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/utils/hive_utils.dart';
import 'package:jankuier_mobile/features/auth/domain/usecases/sign_in_usecase.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

@injectable
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase _signInUseCase;
  final HiveUtils _hiveUtils = HiveUtils();

  SignInBloc(this._signInUseCase) : super(const SignInInitial()) {
    on<SignInSubmitted>(_onSignInSubmitted);
    on<SignInReset>(_onSignInReset);
  }

  Future<void> _onSignInSubmitted(
      SignInSubmitted event, Emitter<SignInState> emit) async {
    emit(const SignInLoading());

    final result = await _signInUseCase(event.loginParameter);

    result.fold(
      (failure) => emit(SignInFailure(failure.message ?? 'Sign in failed')),
      (token) async {
        // Save token to secure storage
        await _hiveUtils.setAccessToken(token.accessToken);
        if (token.refreshToken != null) {
          await _hiveUtils.setRefreshToken(token.refreshToken!);
        }

        emit(SignInSuccess(token));
      },
    );
  }

  void _onSignInReset(SignInReset event, Emitter<SignInState> emit) {
    emit(const SignInInitial());
  }
}