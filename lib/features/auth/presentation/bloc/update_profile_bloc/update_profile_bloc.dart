import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/auth/domain/usecases/update_profile_usecase.dart';
import 'update_profile_event.dart';
import 'update_profile_state.dart';

@injectable
class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final UpdateProfileUseCase _updateProfileUseCase;

  UpdateProfileBloc(this._updateProfileUseCase) : super(const UpdateProfileInitial()) {
    on<ProfileUpdateSubmitted>(_onProfileUpdateSubmitted);
    on<ResetProfileUpdate>(_onResetProfileUpdate);
  }

  Future<void> _onProfileUpdateSubmitted(
      ProfileUpdateSubmitted event, Emitter<UpdateProfileState> emit) async {
    emit(const UpdateProfileLoading());

    final result = await _updateProfileUseCase(event.updateProfileParameter);

    result.fold(
      (failure) => emit(UpdateProfileFailure(failure.message ?? 'Profile update failed')),
      (user) => emit(UpdateProfileSuccess(
        updatedUser: user,
        successMessage: 'Profile updated successfully',
      )),
    );
  }

  void _onResetProfileUpdate(
      ResetProfileUpdate event, Emitter<UpdateProfileState> emit) {
    emit(const UpdateProfileInitial());
  }
}