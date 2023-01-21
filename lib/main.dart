import 'package:easy_localization/easy_localization.dart';
import 'package:firstproject/app/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'app/app.dart';
import 'presentation/resources/languge_manager.dart';

void main() async {
  // we use one for make sure any future instace ready
  WidgetsFlutterBinding.ensureInitialized();
  // this one hold all instance we should put before start program
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(
    EasyLocalization(
        child: Phoenix(
          child: MyApp(),
        ),
        supportedLocales: const [ARABIC_LOCAL, ENGLISH_LOCAL],
        path: ASSET_PATH_LOCALISATIONS),
  );
}
