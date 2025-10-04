import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/notifications/domain/usecases/get_all_notifications_usecase.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_all_notifications/get_all_notifications_event.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_all_notifications/get_all_notifications_state.dart';

@injectable
class GetAllNotificationsBloc
    extends Bloc<GetAllNotificationsEvent, GetAllNotificationsState> {
  final GetAllNotificationsUseCase _getAllNotificationsUseCase;

  GetAllNotificationsBloc(this._getAllNotificationsUseCase)
      : super(const AllNotificationsInitial()) {
    on<LoadAllNotifications>(_onLoadAllNotifications);
    on<RefreshNotifications>(_onRefreshNotifications);
  }

  Future<void> _onLoadAllNotifications(
    LoadAllNotifications event,
    Emitter<GetAllNotificationsState> emit,
  ) async {
    emit(const AllNotificationsLoading());

    final result = await _getAllNotificationsUseCase(event.parameter);

    result.fold(
      (failure) => emit(AllNotificationsError(failure.message ?? "-")),
      (notifications) => emit(AllNotificationsLoaded(notifications)),
    );
  }

  Future<void> _onRefreshNotifications(
    RefreshNotifications event,
    Emitter<GetAllNotificationsState> emit,
  ) async {
    final result = await _getAllNotificationsUseCase(event.parameter);

    result.fold(
      (failure) => emit(AllNotificationsError(failure.message ?? "-")),
      (notifications) => emit(AllNotificationsLoaded(notifications)),
    );
  }
}
