import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/auth/domain/usecases/delete_account_usecase.dart';

import 'delete_account_event.dart';
import 'delete_account_state.dart';

@injectable
class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  final DeleteAccountUseCase _deleteAccountUseCase;

  DeleteAccountBloc(this._deleteAccountUseCase)
      : super(const DeleteAccountInitial()) {
    on<DeleteAccountSubmitted>(_onDeleteAccountSubmitted);
    on<ResetDeleteAccount>(_onResetDeleteAccount);
  }

  Future<void> _onDeleteAccountSubmitted(
    DeleteAccountSubmitted event,
    Emitter<DeleteAccountState> emit,
  ) async {
    emit(const DeleteAccountLoading());

    final result = await _deleteAccountUseCase(const NoParams());

    result.fold(
      (failure) => emit(DeleteAccountFailure(failure.message ?? 'Unknown error occurred')),
      (success) => emit(const DeleteAccountSuccess()),
    );
  }

  void _onResetDeleteAccount(
    ResetDeleteAccount event,
    Emitter<DeleteAccountState> emit,
  ) {
    emit(const DeleteAccountInitial());
  }
}