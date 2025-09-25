import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/content_refresh_service.dart';
import '../di/injection.dart';

/// Mixin that provides automatic content refresh functionality when language changes
/// Usage: class MyBloc extends Bloc<MyEvent, MyState> with LanguageRefreshMixin<MyEvent, MyState>
mixin LanguageRefreshMixin<Event, State> on BlocBase<State> {
  StreamSubscription? _languageSubscription;
  ContentRefreshService? _contentRefreshService;

  /// Override this method to define what event should be triggered on language change
  Event? get refreshEvent => null;

  /// Initialize the language refresh functionality
  void initLanguageRefresh() {
    _initContentRefreshService();
  }

  void _initContentRefreshService() async {
    try {
      _contentRefreshService = await getIt.getAsync<ContentRefreshService>();
      _languageSubscription = _contentRefreshService!.onLanguageChanged.listen(
        (newLanguage) {
          final event = refreshEvent;
          if (event != null && this is Bloc<Event, State>) {
            (this as Bloc<Event, State>).add(event);
          }
        },
      );
    } catch (e) {
      // Service not available, continue without language refresh
    }
  }

  /// Clean up resources when bloc is closed
  @override
  Future<void> close() {
    _languageSubscription?.cancel();
    return super.close();
  }
}