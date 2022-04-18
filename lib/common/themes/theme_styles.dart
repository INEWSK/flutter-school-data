import 'package:flutter/material.dart';

ThemeData light(BuildContext context) {
  return ThemeData.light().copyWith(
    textTheme: ThemeData.light().textTheme.apply(fontFamily: 'open-huninn'),
    appBarTheme: appBarTheme,
  );
}

ThemeData dark(BuildContext context) {
  return ThemeData.dark().copyWith(
    textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'open-huninn'),
  );
}

AppBarTheme appBarTheme = const AppBarTheme(elevation: 0);
