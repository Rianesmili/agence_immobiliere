import 'package:agence_immobiliere/app/widgets/liste_biens_immobiliers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);
    return MaterialApp(
      title: 'agence immobilière',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: const TextTheme(
            bodyMedium: TextStyle(fontSize: 20),
            labelLarge: TextStyle(fontSize: 20),
            bodyLarge: TextStyle(fontSize: 20)),
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      home: const ListeBiensImmobiliers(),
    );
  }
}

