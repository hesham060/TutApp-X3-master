import 'package:easy_localization/easy_localization.dart';
import 'package:firstproject/app/di.dart';
import 'package:firstproject/app/shared_prefs.dart';
import 'package:firstproject/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import '../presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  // named constructor
  MyApp._internal();

  int appState = 0;

  static final MyApp _instance =
      MyApp._internal(); // singleton or single instance

  factory MyApp() => _instance; // factory

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPrefreneces _appPrefreneces= instance<AppPrefreneces>();
  @override
  void didChangeDependencies() {
   _appPrefreneces.getLocal().then((local) =>{context.setLocale(local)});
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme() ,
    );
  }
}