import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:jankuier_mobile/core/api_client/sota_api_client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'core/adapters/file_entity_adapter.dart';
import 'core/services/localization_service.dart';
import 'core/adapters/permission_entity_adapter.dart';
import 'core/adapters/role_entity_adapter.dart';
import 'core/adapters/user_entity_adapter.dart';
import 'core/constants/flavor_config.dart';
import 'core/di/injection.dart';
import 'core/routes/app_router.dart';
import 'features/tournament/data/entities/tournament_entity.dart';
import 'l10n/app_localizations.dart';
import 'shared/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup flavor configuration (default to dev for demo)
  DevFlavorConfig.setup();

  // Initialize Hive
  if (!kIsWeb) {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
  }

  // Register Hive Adapters
  Hive.registerAdapter(TournamentEntityAdapter()); // typeId: 1
  Hive.registerAdapter(SeasonEntityAdapter()); // typeId: 2
  Hive.registerAdapter(FileEntityAdapter()); // typeId: 3
  Hive.registerAdapter(PermissionEntityAdapter()); // typeId: 4
  Hive.registerAdapter(RoleEntityAdapter()); // typeId: 5
  Hive.registerAdapter(UserEntityAdapter()); // typeId: 6

  // Initialize HydratedBloc
  if (kIsWeb) {
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorage.webStorageDirectory,
    );
  } else {
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory(),
    );
  }

  // Configure dependencies
  await configureDependencies();

  // Initialize LocalizationService (already initialized by dependency injection)
  await getIt.isReady<LocalizationService>();

  await SotaApiClient().getSotaToken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: FutureBuilder<LocalizationService>(
        future: getIt.getAsync<LocalizationService>(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(child: Text('Error initializing app')),
              ),
            );
          }

          final localizationService = snapshot.data!;

          return AnimatedBuilder(
            animation: localizationService,
            builder: (context, child) {
              return MaterialApp.router(
                title: FlavorConfig.instance.appName,
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: ThemeMode.system,
                routerConfig: AppRouter.router,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                locale: localizationService.currentLocale,
                supportedLocales: LocalizationService.supportedLocales,
              );
            },
          );
        },
      ),
    );
  }
}
