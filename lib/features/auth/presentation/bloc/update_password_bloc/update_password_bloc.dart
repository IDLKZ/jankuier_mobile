import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/auth/domain/usecases/update_password_usecase.dart';
import 'update_password_event.dart';
import 'update_password_state.dart';

@injectable
class UpdatePasswordBloc extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
  final UpdatePasswordUseCase _updatePasswordUseCase;

  UpdatePasswordBloc(this._updatePasswordUseCase) : super(const UpdatePasswordInitial()) {
    on<PasswordUpdateSubmitted>(_onPasswordUpdateSubmitted);
    on<ResetPasswordUpdate>(_onResetPasswordUpdate);
  }

  Future<void> _onPasswordUpdateSubmitted(
      PasswordUpdateSubmitted event, Emitter<UpdatePasswordState> emit) async {
    emit(const UpdatePasswordLoading());

    final result = await _updatePasswordUseCase(event.updatePasswordParameter);

    result.fold(
      (failure) => emit(UpdatePasswordFailure(failure.message ?? 'Password update failed')),
      (success) => emit(const UpdatePasswordSuccess(
        successMessage: 'Password updated successfully',
      )),
    );
  }

  void _onResetPasswordUpdate(
      ResetPasswordUpdate event, Emitter<UpdatePasswordState> emit) {
    emit(const UpdatePasswordInitial());
  }
}