import 'package:agence_immobiliere/app/widgets/detail_bien_immobiler.dart';
import 'package:agence_immobiliere/app/widgets/liste_biens_immobiliers.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'data/repository/repository.dart';
import 'data/repository/repository_mock_impl.dart';
import 'models/model_data.dart';

void main() {
  GetIt.instance.registerSingleton<Repository>(RepoMockImpl());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);
    return MaterialApp(
      debugShowCheckedModeBanner: false, // remove debug banner
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
      initialRoute: '/realestate',
      routes: {
        '/realestate': (context) => const ListeBiensImmobiliers(),
        '/details' : (context) => DetailsBienImmobilier(
          bienImmobilier: ModalRoute.of(context)!.settings.arguments as BienImmobilier,
        ),
      },
    );
  }
}

