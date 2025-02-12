import 'package:bot_toast/bot_toast.dart';
import 'package:evently/core/routes/pages_route_name.dart';
import 'package:evently/modules/layout/layout_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'core/routes/app_routes.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'core/services/loading_service.dart';
import 'core/theme/app_theme_manager.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'modules/layout/settings_provider.dart';
import 'modules/onBoarding/onBoarding_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstRun = prefs.getBool('isFirstRun') ?? true;

  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: const MyApp(isFirstRun: false,),
    ),
  );

  configLoading();
}

class MyApp extends StatelessWidget {
  final bool isFirstRun;

  const MyApp({super.key, required this.isFirstRun});


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppThemeManager.lightTheme,
      darkTheme: AppThemeManager.darkTheme,
      themeMode: provider.currentTheme,
      onGenerateRoute: AppRoutes.onGeneratedRoute,
      debugShowCheckedModeBanner: false,
      //initialRoute: PagesRouteName.initial,
      navigatorKey: navigatorKey,
      builder: EasyLoading.init(
        builder: BotToastInit(),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.currentLanguage),

        home: isFirstRun ? const OnBoardingView() : const LayoutView(),
    );
  }
}
