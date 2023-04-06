import 'dart:math';

import 'package:flutter/material.dart';
import 'package:personajes_star_war/provider/provider.dart';

import 'package:personajes_star_war/routes/routes.dart';
import 'package:personajes_star_war/screens/home.dart';

import 'package:personajes_star_war/utils/image_assets.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> rotate;
  late Animation<double> opacity;
  late Animation<double> translate;

  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProviderData>(context, listen: false).setInitPage(true);
    });
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    rotate = Tween(begin: 0.0, end: 2.0 * pi).animate(animationController);
    opacity = Tween(begin: 0.0, end: 1.0).animate(animationController);
    translate = Tween(begin: 0.0, end: 200.0).animate(animationController);
    scale = Tween(begin: 0.0, end: 1.0).animate(animationController);

    animationController.forward();
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 2)).then((value) {
          Navigator.push(context, RoutesApp.routeTransition(const HomeScreen()));
        });
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    animationController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget? child) {
          return Transform.scale(
              scale: scale.value,
              child: Transform.rotate(
                  angle: rotate.value,
                  child: AnimatedOpacity(
                      opacity: opacity.value,
                      duration: const Duration(seconds: 3),
                      child: ImageAsset(
                        asset: "logo",
                        height: mq.height,
                        width: mq.height,
                      ))));
        },
      ),
    );
  }
}
