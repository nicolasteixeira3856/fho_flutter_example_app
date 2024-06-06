import 'package:flutter/material.dart';

// coverage:ignore-file

// Abstrair em um arquivo colors.dart para evitar repetições
final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF000b70)),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF000b70),
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(fontSize: 20, color: Colors.white),
    surfaceTintColor: Color(0xFF000b70),
    centerTitle: false,
  ),
  primaryColor: const Color(0xFF000b70),
);
