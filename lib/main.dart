import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:jankuier_mobile/core/api_client/sota_api_client.dart';
import 'package:path_provider/path_provider.dart';
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
  Hive.registerAdapter(TournamentEntityAdapter());
  Hive.registerAdapter(SeasonEntityAdapter());

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
  await SotaApiClient().getSotaToken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp.router(
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
        locale: Locale("ru"),
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ru', 'RU'),
          Locale('kk', 'KZ'),
        ],
      ),
    );
  }
}
