import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/ticket/presentation/bloc/shows/ticketon_event.dart';
import 'package:jankuier_mobile/features/ticket/presentation/bloc/shows/ticketon_state.dart';
import '../../../domain/use_cases/get_ticketon_shows_use_case.dart';

@injectable
class TicketonShowsBloc extends Bloc<TicketonShowsEvent, TicketonShowsState> {
  final GetTicketonShowsUseCase getTicketonShowsShowsUseCase;

  TicketonShowsBloc({required this.getTicketonShowsShowsUseCase})
      : super(const TicketonShowsInitial()) {
    on<LoadTicketonShowsEvent>(_onLoadTicketonShowsShows);
  }

  Future<void> _onLoadTicketonShowsShows(
    LoadTicketonShowsEvent event,
    Emitter<TicketonShowsState> emit,
  ) async {
    emit(const TicketonShowsLoading());

    final result = await getTicketonShowsShowsUseCase(event.parameter);

    result.fold(
      (failure) => emit(TicketonShowsError(message: failure.message ?? "")),
      (shows) => emit(TicketonShowsShowsLoaded(shows: shows)),
    );
  }
}
