import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/usecases/get_all_my_field_party_request.dart';
import 'get_all_my_field_party_request_event.dart';
import 'get_all_my_field_party_request_state.dart';

@injectable
class GetAllMyFieldPartyRequestBloc extends Bloc<
    GetAllMyFieldPartyRequestEvent, GetAllMyFieldPartyRequestState> {
  final GetAllMyFieldPartyRequest _getAllMyFieldPartyRequest;

  GetAllMyFieldPartyRequestBloc({
    required GetAllMyFieldPartyRequest getAllMyFieldPartyRequest,
  })  : _getAllMyFieldPartyRequest = getAllMyFieldPartyRequest,
        super(const GetAllMyFieldPartyRequestInitial()) {
    on<LoadAllMyFieldPartyRequest>(_onLoadRequests);
  }

  Future<void> _onLoadRequests(
    LoadAllMyFieldPartyRequest event,
    Emitter<GetAllMyFieldPartyRequestState> emit,
  ) async {
    if (event.isLoadMore) {
      emit(const GetAllMyFieldPartyRequestLoading(isLoadingMore: true));
    } else {
      emit(const GetAllMyFieldPartyRequestLoading(isLoadingMore: false));
    }

    final result = await _getAllMyFieldPartyRequest(event.pagination);

    result.fold(
      (failure) => emit(
          GetAllMyFieldPartyRequestError(failure.message ?? 'Unknown error')),
      (pagination) {
        if (event.isLoadMore && state is GetAllMyFieldPartyRequestSuccess) {
          final currentState = state as GetAllMyFieldPartyRequestSuccess;
          final updatedPagination =
              currentState.pagination.copyWithAppendedItems(pagination);
          emit(GetAllMyFieldPartyRequestSuccess(updatedPagination));
        } else {
          emit(GetAllMyFieldPartyRequestSuccess(pagination));
        }
      },
    );
  }
}
