import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/notifications/domain/usecases/get_firebase_token_usecase.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_firebase_token/get_firebase_token_event.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_firebase_token/get_firebase_token_state.dart';

@injectable
class GetFirebaseTokenBloc
    extends Bloc<GetFirebaseTokenEvent, GetFirebaseTokenState> {
  final GetFirebaseTokenUseCase _getFirebaseTokenUseCase;

  GetFirebaseTokenBloc(this._getFirebaseTokenUseCase)
      : super(const FirebaseTokenInitial()) {
    on<LoadFirebaseToken>(_onLoadFirebaseToken);
  }

  Future<void> _onLoadFirebaseToken(
    LoadFirebaseToken event,
    Emitter<GetFirebaseTokenState> emit,
  ) async {
    emit(const FirebaseTokenLoading());

    final result = await _getFirebaseTokenUseCase(NoParams());

    result.fold(
      (failure) => emit(FirebaseTokenError(failure.message ?? "")),
      (token) => emit(FirebaseTokenLoaded(token)),
    );
  }
}
