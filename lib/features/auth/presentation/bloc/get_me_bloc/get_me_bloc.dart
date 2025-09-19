import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/core/utils/hive_utils.dart';
import 'package:jankuier_mobile/features/auth/domain/usecases/get_me_usecase.dart';
import 'get_me_event.dart';
import 'get_me_state.dart';

@injectable
class GetMeBloc extends Bloc<GetMeEvent, GetMeState> {
  final GetMeUseCase _getMeUseCase;
  final HiveUtils _hiveUtils;

  GetMeBloc(this._getMeUseCase, this._hiveUtils) : super(const GetMeInitial()) {
    on<LoadUserProfile>(_onLoadUserProfile);
    on<RefreshUserProfile>(_onRefreshUserProfile);
    on<ResetUserProfile>(_onResetUserProfile);
    on<LoadUserFromCache>(_onLoadUserFromCache);
  }

  Future<void> _onLoadUserProfile(
      LoadUserProfile event, Emitter<GetMeState> emit) async {
    // First try to load from cache
    final cachedUser = await _hiveUtils.getCurrentUser();
    if (cachedUser != null) {
      emit(GetMeLoaded(cachedUser));
    } else {
      emit(const GetMeLoading());
    }

    // Then fetch from API
    final result = await _getMeUseCase(const NoParams());

    await result.fold(
      (failure) async {
        // If we don't have cached user, show error
        if (cachedUser == null) {
          emit(GetMeError(failure.message ?? 'Unknown error'));
        }
        // If we have cached user, keep it but could show a toast about network error
      },
      (user) async {
        // Save user to cache
        await _hiveUtils.setCurrentUser(user);
        emit(GetMeLoaded(user));
      },
    );
  }

  Future<void> _onRefreshUserProfile(
      RefreshUserProfile event, Emitter<GetMeState> emit) async {
    // Keep current state while refreshing
    final currentState = state;
    if (currentState is GetMeLoaded) {
      emit(GetMeLoaded(currentState.user)); // Keep current user while loading
    }

    final result = await _getMeUseCase(const NoParams());

    await result.fold(
      (failure) async {
        // If refresh fails, keep current user if available
        if (currentState is GetMeLoaded) {
          emit(GetMeLoaded(currentState.user));
        } else {
          emit(GetMeError(failure.message ?? 'Unknown error'));
        }
      },
      (user) async {
        // Save updated user to cache
        await _hiveUtils.setCurrentUser(user);
        emit(GetMeLoaded(user));
      },
    );
  }

  Future<void> _onResetUserProfile(
      ResetUserProfile event, Emitter<GetMeState> emit) async {
    await _hiveUtils.clearCurrentUser();
    emit(const GetMeInitial());
  }

  Future<void> _onLoadUserFromCache(
      LoadUserFromCache event, Emitter<GetMeState> emit) async {
    final cachedUser = await _hiveUtils.getCurrentUser();
    if (cachedUser != null) {
      emit(GetMeLoaded(cachedUser));
    } else {
      emit(const GetMeInitial());
    }
  }
}
