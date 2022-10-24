import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:personajes_star_war/routes/routes.dart';
import 'package:personajes_star_war/utils/image_assets.dart';

class Splash extends StatefulWidget {
  const Splash();

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5)).then((value) {
      // Navigator.pushReplacementNamed(context, RoutesApp.home);
      // Navigator.pushNamed(context, RoutesApp.home);
      Hive.openBox("hola");
      Box box = Hive.box("nombre");
      box.put("nombre", "Luis");
      print(box.keys);
      print(box.values);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: 500,
          width: 500,
          color: Colors.blue,
          alignment: Alignment.center,
          child: ImageAsset(asset: "logo")),
    );
  }
}
