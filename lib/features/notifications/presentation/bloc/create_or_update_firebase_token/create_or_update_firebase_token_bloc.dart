import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/notifications/domain/usecases/create_or_update_firebase_token_usecase.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/create_or_update_firebase_token/create_or_update_firebase_token_event.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/create_or_update_firebase_token/create_or_update_firebase_token_state.dart';

@injectable
class CreateOrUpdateFirebaseTokenBloc extends Bloc<
    CreateOrUpdateFirebaseTokenEvent, CreateOrUpdateFirebaseTokenState> {
  final CreateOrUpdateFirebaseTokenUseCase _createOrUpdateFirebaseTokenUseCase;

  CreateOrUpdateFirebaseTokenBloc(this._createOrUpdateFirebaseTokenUseCase)
      : super(const CreateOrUpdateTokenInitial()) {
    on<CreateOrUpdateToken>(_onCreateOrUpdateToken);
  }

  Future<void> _onCreateOrUpdateToken(
    CreateOrUpdateToken event,
    Emitter<CreateOrUpdateFirebaseTokenState> emit,
  ) async {
    emit(const CreateOrUpdateTokenLoading());

    final result = await _createOrUpdateFirebaseTokenUseCase(event.parameter);

    result.fold(
      (failure) => emit(CreateOrUpdateTokenError(failure.message ?? "-")),
      (token) => emit(CreateOrUpdateTokenSuccess(token)),
    );
  }
}
