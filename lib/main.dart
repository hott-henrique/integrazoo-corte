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
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate
    ],
    home: const IntegrazooApp(),
    supportedLocales: const [ Locale('pt', 'BR') ],
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w800
        ),
      ),
      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
          backgroundColor: WidgetStatePropertyAll<Color>(Colors.green),
          shape: WidgetStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0)))),
        ),
      ),
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll<Color>(Colors.black),
          backgroundColor: WidgetStatePropertyAll<Color>(Colors.transparent),
          shape: WidgetStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0)))),
        )
      ),
      expansionTileTheme: const ExpansionTileThemeData(
        shape: Border(bottom: BorderSide(color: Colors.black, width: 1)),
        collapsedShape: Border(bottom: BorderSide(color: Colors.black, width: 1)),
      ),
      dialogTheme: const DialogTheme(
        iconColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.0))),
        alignment: Alignment.center
      ),
      scrollbarTheme: const ScrollbarThemeData(
        trackVisibility: WidgetStatePropertyAll<bool>(true),
        thumbVisibility: WidgetStatePropertyAll<bool>(true),
      ),
      dividerTheme: const DividerThemeData(color: Colors.transparent, thickness: 0.0, space: 8)
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
