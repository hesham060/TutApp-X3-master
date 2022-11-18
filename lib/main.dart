import 'package:firstproject/app/di.dart';
import 'package:flutter/material.dart';
import 'app/app.dart';

void main() async {
  // we use one for make sure any future instace ready 
  WidgetsFlutterBinding.ensureInitialized();
  // this one hold all instance we should put before start program
  await initAppModule();
  runApp(MyApp());
}
