import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_tour_coin/providers/auth_provider.dart';
import 'package:trip_tour_coin/router/router.dart';
import 'package:trip_tour_coin/services/alerts_service.dart';
import 'package:trip_tour_coin/services/navigation_service.dart';
import 'package:trip_tour_coin/theme.dart';
import 'package:trip_tour_coin/ui/layouts/auth_layout.dart';
import 'package:trip_tour_coin/ui/layouts/core_layaout.dart';
import 'package:trip_tour_coin/ui/layouts/splash/splash_layout.dart';

import 'api/HttpApi.dart';
import 'l10n/L10n.dart';
import 'providers/locale_provider.dart';
import 'providers/ui_provider.dart';
import 'services/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
  //   SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  // ]);

  //setPathUrlStrategy();
  await LocalStorage.configurePrefs();
  HttpApi.configureDio();
  Flurorouter.configureRoutes();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => UiProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => LocaleProvider()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: CustomTheme.darkTheme,
        title: 'Trip Tour Now',
        initialRoute: '/',
        onGenerateRoute: Flurorouter.router.generator,
        navigatorKey: NavigationService.navigatorKey,
        scaffoldMessengerKey: AlertsService.messengerKey,
        builder: (context, widget) {
          ScreenUtil.init(context);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          // DefaultCupertinoLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate, // Here
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: L10n.all,
        locale: Provider.of<LocaleProvider>(context).locale,
      ),
    );
  }
}
