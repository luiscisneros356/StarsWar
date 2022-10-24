import 'dart:math';

import 'package:flutter/material.dart';
import 'package:personajes_star_war/utils/helpers.dart';
import 'package:personajes_star_war/utils/image_assets.dart';

import 'package:provider/provider.dart';

import '../provider/provider.dart';

class ReportedList extends StatefulWidget {
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
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    scale = Tween(begin: 0.0, end: 1.0).animate(animationController);
    rotate = Tween(begin: 0.0, end: 2.0 * pi).animate(animationController);
    opacity = Tween(begin: 0.0, end: 1.0).animate(animationController);

    animationController.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ProviderData>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("My Reports"),
        centerTitle: true,
        actions: [
          TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.delete_forever_outlined),
              label: Text("Delete All"))
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: ListView.builder(
        itemCount: data.reportedListPeople.length,
        itemBuilder: (context, index) {
          final p = data.reportedListPeople[index];

          return AnimatedBuilder(
            animation: animationController,
            builder: (context, _) {
              return ListTile(
                leading: Transform.scale(
                  scale: scale.value,
                  child: p!.imageGender,
                ),
                title: Transform.rotate(angle: rotate.value, child: Text(p.name)),
                subtitle: AnimatedOpacity(
                  opacity: opacity.value,
                  duration: Duration(seconds: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date of report"),
                      Text("${p.edited.year}/${p.edited.month}/${p.edited.day}"),
                    ],
                  ),
                ),
                trailing: AnimatedOpacity(
                  opacity: opacity.value,
                  duration: Duration(seconds: 2),
                  child: IconButton(
                      onPressed: () {
                        data.reportedListPeople
                            .removeWhere((element) => element?.edited == p.edited);
                        setState(() {});
                      },
                      icon: Icon(Icons.delete)),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: TextButton.icon(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.yellow)),
          onPressed: () {
            data.reportedListPeople.clear();
            setState(() {});
          },
          icon: Icon(
            Icons.delete_forever_rounded,
            color: Colors.red,
          ),
          label: Text("Delete All")),
    );
  }
}
