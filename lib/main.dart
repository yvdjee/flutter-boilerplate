import 'package:domodar/providers.dart';
import 'package:domodar/routers.dart';
import 'package:domodar/stores/language/app_localization.dart';
import 'package:domodar/stores/language/store.dart';
import 'package:domodar/stores/providers/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiProvider(
      providers: Providers.providers,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppLocalization>(
      builder: (ctx, localization, child) => Consumer<AppTheme>(
        builder: (_, themeProvider, __) => MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('fr', 'FR'),
            const Locale('en', 'US'),
            const Locale('ar', 'TN'),
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            return Locale(localization.selectedLanguageCode);
          },
          debugShowCheckedModeBanner: false,
          title: 'iheb-boilerplate',
          theme: themeProvider.getThemeData,
          home: null,
          routes: Routes.routes,
        ),
      ),
    );
  }
}
