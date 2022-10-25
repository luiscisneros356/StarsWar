import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:personajes_star_war/models/people.dart';

import 'package:personajes_star_war/provider/provider.dart';
import 'package:personajes_star_war/routes/routes.dart';

import 'package:personajes_star_war/screens/splash.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PeopleAdapter());
  await Hive.openBox<People>("people");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      lazy: false,
      create: ((context) => ProviderData()),
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: RoutesApp.splash,
        routes: RoutesApp.getRoutes(),
        // home: MyHomePage(title: 'Flutter Demo Home Page'),

        home: Splash(),
      ),
    );
  }
}
