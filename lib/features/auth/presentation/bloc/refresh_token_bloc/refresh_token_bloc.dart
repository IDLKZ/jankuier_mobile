import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/utils/hive_utils.dart';
import 'package:jankuier_mobile/features/auth/domain/usecases/refresh_token_usecase.dart';
import 'refresh_token_event.dart';
import 'refresh_token_state.dart';

@injectable
class RefreshTokenBloc extends Bloc<RefreshTokenEvent, RefreshTokenState> {
  final RefreshTokenUseCase _refreshTokenUseCase;
  final HiveUtils _hiveUtils;

  RefreshTokenBloc(this._refreshTokenUseCase, this._hiveUtils)
      : super(const RefreshTokenInitial()) {
    on<RefreshTokenSubmitted>(_onRefreshTokenSubmitted);
    on<RefreshTokenReset>(_onRefreshTokenReset);
  }

  Future<void> _onRefreshTokenSubmitted(
      RefreshTokenSubmitted event, Emitter<RefreshTokenState> emit) async {
    emit(const RefreshTokenLoading());

    final result = await _refreshTokenUseCase(event.refreshTokenParameter);

    await result.fold(
      (failure) async => emit(RefreshTokenFailure(
          failure.message ?? 'Refresh token failed',
          failure: failure)),
      (token) async {
        // Save new access token to secure storage
        await _hiveUtils.setAccessToken(token.accessToken);
        if (token.refreshToken != null) {
          await _hiveUtils.setRefreshToken(token.refreshToken!);
        }

        emit(RefreshTokenSuccess(token));
      },
    );
  }

  void _onRefreshTokenReset(
      RefreshTokenReset event, Emitter<RefreshTokenState> emit) {
    emit(const RefreshTokenInitial());
  }
}
