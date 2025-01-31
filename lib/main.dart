import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:integrazoo/base.dart';
import 'package:integrazoo/globals.dart';
import 'package:integrazoo/database/database.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = AppDatabase();

  await database.doWhenOpened((e) => e.runCustom("PRAGMA foreign_keys = ON;"));

  runApp(MaterialApp(
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ],
    home: const IntegrazooApp(),
    supportedLocales: const [ Locale('pt', 'BR') ],
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w800
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.green[400]),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          shape: WidgetStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))))
        )
      )
    )
  ));
}

class IntegrazooApp extends StatefulWidget {
  const IntegrazooApp({super.key});

  @override
  State<StatefulWidget> createState() => _IntegrazooAppState();
}

class _IntegrazooAppState extends State<IntegrazooApp> {
  bool isDBLoaded = false;

  @override
  Widget build(BuildContext context) {
    return const IntegrazooBaseApp(body: Center(child: Text('Selecione uma funcionalidade!')));
  }
}
