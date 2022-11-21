import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:personajes_star_war/provider/provider.dart';
import 'package:personajes_star_war/routes/routes.dart';

import 'package:personajes_star_war/screens/splash.dart';
import 'package:personajes_star_war/utils/hive.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Boxes.initData();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      lazy: false,
      create: ((context) => ProviderData()),
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: RoutesApp.splash,
        routes: RoutesApp.getRoutes(),
        home: const Splash(),
      ),
    );
  }
}
