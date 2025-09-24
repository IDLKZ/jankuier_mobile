import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/auth/domain/usecases/update_profile_photo_usecase.dart';
import 'update_profile_photo_event.dart';
import 'update_profile_photo_state.dart';

@injectable
class UpdateProfilePhotoBloc extends Bloc<UpdateProfilePhotoEvent, UpdateProfilePhotoState> {
  final UpdateProfilePhotoUseCase _updateProfilePhotoUseCase;

  UpdateProfilePhotoBloc(this._updateProfilePhotoUseCase) : super(const UpdateProfilePhotoInitial()) {
    on<UpdateProfilePhotoSubmitted>(_onUpdateProfilePhotoSubmitted);
    on<ResetUpdateProfilePhoto>(_onResetUpdateProfilePhoto);
  }

  Future<void> _onUpdateProfilePhotoSubmitted(
      UpdateProfilePhotoSubmitted event, Emitter<UpdateProfilePhotoState> emit) async {
    emit(const UpdateProfilePhotoLoading());

    final result = await _updateProfilePhotoUseCase(event.photoFile);

    result.fold(
      (failure) => emit(UpdateProfilePhotoFailure(failure.message ?? 'Profile photo update failed')),
      (user) => emit(UpdateProfilePhotoSuccess(
        updatedUser: user,
        successMessage: 'Profile photo updated successfully',
      )),
    );
  }

  void _onResetUpdateProfilePhoto(
      ResetUpdateProfilePhoto event, Emitter<UpdateProfilePhotoState> emit) {
    emit(const UpdateProfilePhotoInitial());
  }
}