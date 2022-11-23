import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:personajes_star_war/provider/provider.dart';
import 'package:personajes_star_war/routes/routes.dart';

import 'package:personajes_star_war/screens/splash.dart';
import 'package:personajes_star_war/utils/hive.dart';
import 'package:provider/provider.dart';

/*
===========IMPORTANTE============

MODO DE USO:

1) UTILIZAR LA APP Y VER SU FUNCIONALIDAD
3) REVISAR LOS COMENTARIOS, EN LA APP SE VAN A ENCONTRAR "TODO" CON COMENTARIOS Y EXPLICACIONES.
3) POR FAVOR, SERIA DE GRAN AYUDA Y UTILIDAD QUE SE COMENTE LO QUE SE CREA NECESARIO MEDIANTE UN "TODO" CON LA PRIMERA PALABRA RESPUESTA

*/
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
