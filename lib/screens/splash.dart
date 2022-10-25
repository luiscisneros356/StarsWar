import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:personajes_star_war/routes/routes.dart';
import 'package:personajes_star_war/utils/image_assets.dart';

class Splash extends StatefulWidget {
  const Splash();

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> rotate;
  late Animation<double> opacity;
  late Animation<double> translate;
  // late Animation<Color> color;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 5));
    rotate = Tween(begin: 0.0, end: 2.0 * pi).animate(animationController);
    opacity = Tween(begin: 0.0, end: 1.0).animate(animationController);
    translate = Tween(begin: 0.0, end: 200.0).animate(animationController);
    scale = Tween(begin: 0.0, end: 1.0).animate(animationController);
    //color = Tween(begin: Colors.red, end: Colors.brown).animate(animationController);

    Future.delayed(Duration(seconds: 5)).then((value) {
      // Navigator.pushReplacementNamed(context, RoutesApp.home);
      // Navigator.pushNamed(context, RoutesApp.home);
      // Hive.openBox("hola");
      // Box box = Hive.box("nombre");
      // box.put("nombre", "Luis");
      // print(box.keys);
      // print(box.values);
      print("JAJAJAJJAJAJAJA");
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    animationController.forward();

    return Scaffold(
      body: Container(
        height: mq.height,
        width: mq.width,
        alignment: Alignment.center,
        child: AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget? child) {
            return Transform.scale(
                scale: scale.value,
                child: Transform.rotate(
                    angle: rotate.value,
                    child: AnimatedOpacity(
                        opacity: opacity.value,
                        duration: Duration(seconds: 5),
                        child: ImageAsset(asset: "logo"))));
          },
        ),
      ),
    );
  }
}
