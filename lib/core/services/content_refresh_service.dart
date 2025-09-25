import 'dart:async';
import 'package:injectable/injectable.dart';
import 'localization_service.dart';

/// Service that handles content refresh when language changes
@singleton
class ContentRefreshService {
  final LocalizationService _localizationService;
  StreamSubscription? _languageSubscription;

  // Stream controller for notifying about language changes
  final _refreshController = StreamController<String>.broadcast();

  ContentRefreshService(this._localizationService);

  /// Stream that emits the new language code when language changes
  Stream<String> get onLanguageChanged => _refreshController.stream;

  @PostConstruct()
  void initialize() {
    // Listen to localization service changes
    _localizationService.addListener(_onLanguageChanged);
  }

  void _onLanguageChanged() {
    final currentLanguage = _localizationService.currentLocale.languageCode;
    _refreshController.add(currentLanguage);
  }

  void dispose() {
    _languageSubscription?.cancel();
    _refreshController.close();
    _localizationService.removeListener(_onLanguageChanged);
  }
}