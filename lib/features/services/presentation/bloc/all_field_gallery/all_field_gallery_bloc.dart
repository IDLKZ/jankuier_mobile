import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jankuier_mobile/features/services/domain/use_cases/field/all_field_gallery_case.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/all_field_gallery/all_field_gallery_event.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/all_field_gallery/all_field_gallery_state.dart';

class AllFieldGalleryBloc extends Bloc<AllFieldGalleryEvent, AllFieldGalleryState> {
  AllFieldGalleryCase allFieldGalleryCase;
  AllFieldGalleryBloc({required this.allFieldGalleryCase})
      : super(AllFieldGalleryInitialState()) {
    on<GetAllFieldGalleryEvent>(_onAllFieldGallery);
  }

  Future<void> _onAllFieldGallery(
    GetAllFieldGalleryEvent event,
    Emitter<AllFieldGalleryState> emit,
  ) async {
    emit(AllFieldGalleryLoadingState());
    final result = await this.allFieldGalleryCase.call(event.parameter);
    result.fold(
      (failure) => emit(AllFieldGalleryFailedState(failure)),
      (data) {
        emit(AllFieldGalleryLoadedState(data));
      },
    );
  }
}