import 'package:flutter/material.dart';
import 'package:personajes_star_war/service/services.dart';

import 'package:personajes_star_war/utils/hive.dart';
import 'package:personajes_star_war/utils/style.dart';
import 'package:personajes_star_war/widgets/card_people.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';
import '../utils/dialog.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scale;
  late Animation<double> translate;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    scale = Tween(begin: 0.0, end: 1.0).animate(animationController);

    animationController.repeat();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final people = Provider.of<ProviderData>(context, listen: false).people;
    final data = Provider.of<ProviderData>(context, listen: false);

    if (people != null) {
      data.getInfo(people);
      return Scaffold(
        endDrawer: Drawer(
          backgroundColor:
              data.isConected ? Colors.yellow.withOpacity(0.4) : Colors.red.withOpacity(0.4),
          width: 100,
          child: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(!data.isConected ? "Eneable connection to report" : "",
                    style: AppTextStyle.title(), textAlign: TextAlign.center),
                const SizedBox(height: 58),
                Switch(
                    value: data.isConected,
                    onChanged: (b) {
                      data.setIsConected(!data.isConected);

                      setState(() {});
                    }),
                Text(
                  data.isConected ? "Connection enable" : "Connection disable",
                  style: AppTextStyle.title(),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: Text(people.name),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Hero(
                tag: people.name,
                child: PeopleCard(
                  people: people,
                ),
              ),
              Card(
                margin: const EdgeInsets.all(12),
                color: Colors.green.withOpacity(0.5),
                child: Column(
                  children: [...data.datos],
                ),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.red,
              splashColor: Colors.blue,
              onPressed: data.isConected
                  ? () {
                      data.setPeopleReported(people);
                      data.sendResult(people).then((value) {
                        animationController.stop();
                        if (value) {
                          Boxes.addPeople(data.people);
                          Future.delayed(const Duration(seconds: 1)).then((value) => showDialog(
                              context: context, builder: (context) => const CustomDialog()));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                    title: Text("Houston we have a problem"),
                                  ));
                        }
                      });
                    }
                  : null,
              child: const Icon(Icons.add),
            ),
            Text(
              "Report sighting",
              style: AppTextStyle.title(color: Colors.red, isBold: true),
            )
          ],
        ),
      );
    }
    return Container();
  }
}
