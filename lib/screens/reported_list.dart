import 'dart:math';

import 'package:flutter/material.dart';
import 'package:personajes_star_war/provider/provider.dart';
import 'package:personajes_star_war/routes/routes.dart';
import 'package:personajes_star_war/screens/home.dart';
import 'package:personajes_star_war/utils/helpers.dart';

import 'package:personajes_star_war/utils/style.dart';
import 'package:provider/provider.dart';

import '../utils/hive.dart';

class ReportedList extends StatefulWidget {
  const ReportedList({Key? key}) : super(key: key);

  @override
  State<ReportedList> createState() => _ReportedListState();
}

class _ReportedListState extends State<ReportedList> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scale;
  late Animation<double> rotate;
  late Animation<double> opacity;
  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    scale = Tween(begin: 0.0, end: 1.0).animate(animationController);
    rotate = Tween(begin: 0.0, end: 2.0 * pi).animate(animationController);
    opacity = Tween(begin: 0.0, end: 1.0).animate(animationController);

    animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProviderData>(context);
    return Boxes.listReportedPeople().isNotEmpty
        ? Scaffold(
            appBar: AppBar(
              title: const Text("My Reports"),
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    prov.setIsBackFromReport(true);
                    Navigator.push(context, RoutesApp.routeTransition(const HomeScreen()));
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
            body: ListView.builder(
              itemCount: Boxes.listReportedPeople().length,
              itemBuilder: (context, index) {
                final p = Boxes.listReportedPeople().values.toList()[index];

                return AnimatedBuilder(
                  animation: animationController,
                  builder: (context, _) {
                    return ListTile(
                      leading: Transform.scale(
                        scale: scale.value,
                        child: p.imageGender(p.gender),
                      ),
                      title: Transform.rotate(angle: rotate.value, child: Text(p.name)),
                      subtitle: AnimatedOpacity(
                          opacity: opacity.value,
                          duration: const Duration(seconds: 2),
                          child: Text(capitalize("${p.gender}"))),
                      trailing: AnimatedOpacity(
                        opacity: opacity.value,
                        duration: const Duration(seconds: 2),
                        child: IconButton(
                            onPressed: () {
                              Boxes.deletePeople(index);
                              setState(() {});
                            },
                            icon: const Icon(Icons.delete)),
                      ),
                    );
                  },
                );
              },
            ),
            floatingActionButton: TextButton.icon(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.yellow)),
                onPressed: () {
                  Boxes.deleteAllPeople();
                  setState(() {});
                },
                icon: const Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.red,
                ),
                label: const Text("Delete All")),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.popAndPushNamed(context, RoutesApp.home);
                },
              ),
            ),
            body: Center(
                child: Text(
              "You have not sighting",
              style: AppTextStyle.menu(color: Colors.blue),
            )));
  }
}
