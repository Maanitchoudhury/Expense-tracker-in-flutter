import 'package:expense_tracker/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var kcolorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(215, 104, 236, 3));

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((fn) {
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kcolorScheme,
          appBarTheme: const AppBarTheme()
              .copyWith(backgroundColor: kcolorScheme.primaryContainer),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kcolorScheme.primaryContainer),
          ),
        ),
        home: const Expenses(),
      ),
    );
  });
}
