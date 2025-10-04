import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/notifications/domain/usecases/get_notification_by_id_usecase.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_notification_by_id/get_notification_by_id_event.dart';
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_notification_by_id/get_notification_by_id_state.dart';

@injectable
class GetNotificationByIdBloc
    extends Bloc<GetNotificationByIdEvent, GetNotificationByIdState> {
  final GetNotificationByIdUseCase _getNotificationByIdUseCase;

  GetNotificationByIdBloc(this._getNotificationByIdUseCase)
      : super(const NotificationByIdInitial()) {
    on<LoadNotificationById>(_onLoadNotificationById);
  }

  Future<void> _onLoadNotificationById(
    LoadNotificationById event,
    Emitter<GetNotificationByIdState> emit,
  ) async {
    emit(const NotificationByIdLoading());

    final result = await _getNotificationByIdUseCase(event.id);

    result.fold(
      (failure) => emit(NotificationByIdError(failure.message ?? "")),
      (notification) => emit(NotificationByIdLoaded(notification)),
    );
  }
}
