import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

var kcolorscheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 140, 176, 51),
);

var kDarkcolorscheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([
    //DeviceOrientation.portraitUp,
  //]).then((fn) {
    runApp(
      MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: kDarkcolorscheme,
          cardTheme: const CardTheme().copyWith(
            color: kDarkcolorscheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kDarkcolorscheme.primaryContainer,
              foregroundColor: kDarkcolorscheme.onPrimaryContainer,
            ),
          ),
        ),
        theme: ThemeData().copyWith(
          colorScheme: kcolorscheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kcolorscheme.primary,
            foregroundColor: kcolorscheme.onPrimary,
          ),
          cardTheme: const CardTheme().copyWith(
            color: kcolorscheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kcolorscheme.primaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: kcolorscheme.onSecondaryContainer,
                  //color: Colors.red, with this we will be able to change the color of expense title as we have set it it there
                  fontSize: 17,
                ),
              ),
        ),
        home: const Expenses(),
      ),
    );
  //});
}
