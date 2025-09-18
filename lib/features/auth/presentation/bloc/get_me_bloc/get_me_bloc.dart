import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/auth/domain/usecases/get_me_usecase.dart';
import 'get_me_event.dart';
import 'get_me_state.dart';

@injectable
class GetMeBloc extends Bloc<GetMeEvent, GetMeState> {
  final GetMeUseCase _getMeUseCase;

  GetMeBloc(this._getMeUseCase) : super(const GetMeInitial()) {
    on<LoadUserProfile>(_onLoadUserProfile);
    on<RefreshUserProfile>(_onRefreshUserProfile);
    on<ResetUserProfile>(_onResetUserProfile);
  }

  Future<void> _onLoadUserProfile(
      LoadUserProfile event, Emitter<GetMeState> emit) async {
    emit(const GetMeLoading());

    final result = await _getMeUseCase(const NoParams());

    result.fold(
      (failure) => emit(GetMeError(failure.message ?? 'Unknown error')),
      (user) => emit(GetMeLoaded(user)),
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

    result.fold(
      (failure) => emit(GetMeError(failure.message ?? 'Unknown error')),
      (user) => emit(GetMeLoaded(user)),
    );
  }

  void _onResetUserProfile(ResetUserProfile event, Emitter<GetMeState> emit) {
    emit(const GetMeInitial());
  }
}