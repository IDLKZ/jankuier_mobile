import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/auth/domain/usecases/delete_profile_photo_usecase.dart';
import 'delete_profile_photo_event.dart';
import 'delete_profile_photo_state.dart';

@injectable
class DeleteProfilePhotoBloc extends Bloc<DeleteProfilePhotoEvent, DeleteProfilePhotoState> {
  final DeleteProfilePhotoUseCase _deleteProfilePhotoUseCase;

  DeleteProfilePhotoBloc(this._deleteProfilePhotoUseCase) : super(const DeleteProfilePhotoInitial()) {
    on<DeleteProfilePhotoSubmitted>(_onDeleteProfilePhotoSubmitted);
    on<ResetDeleteProfilePhoto>(_onResetDeleteProfilePhoto);
  }

  Future<void> _onDeleteProfilePhotoSubmitted(
      DeleteProfilePhotoSubmitted event, Emitter<DeleteProfilePhotoState> emit) async {
    emit(const DeleteProfilePhotoLoading());

    final result = await _deleteProfilePhotoUseCase(NoParams());

    result.fold(
      (failure) => emit(DeleteProfilePhotoFailure(failure.message ?? 'Profile photo deletion failed')),
      (user) => emit(DeleteProfilePhotoSuccess(
        updatedUser: user,
        successMessage: 'Profile photo deleted successfully',
      )),
    );
  }

  void _onResetDeleteProfilePhoto(
      ResetDeleteProfilePhoto event, Emitter<DeleteProfilePhotoState> emit) {
    emit(const DeleteProfilePhotoInitial());
  }
}