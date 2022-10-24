import 'dart:math';

import 'package:flutter/material.dart';

import 'package:personajes_star_war/utils/helpers.dart';
import 'package:personajes_star_war/utils/style.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';

class PeopleData extends StatefulWidget {
  const PeopleData({Key? key, required this.value, required this.keey, required this.emoji})
      : super(key: key);

  final dynamic value;
  final dynamic keey;
  final String emoji;

  @override
  State<PeopleData> createState() => _PeopleDataState();
}

class _PeopleDataState extends State<PeopleData> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> opacity;
  late Animation<double> rotation;
  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    opacity = Tween(begin: 0.0, end: 1.0).animate(animationController);
    rotation = Tween(begin: 0.0, end: 2.0 * pi).animate(animationController);
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
    final prov = Provider.of<ProviderData>(context, listen: false);

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, _) {
        return Opacity(
          opacity: opacity.value,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 40),
            dense: true,
            trailing: Transform.rotate(
              angle: rotation.value,
              child: Text(
                widget.emoji,
                style: AppTextStyle.title(size: 30),
              ),
            ),
            title: Text(
              capitalize("${widget.keey}"),
              style: AppTextStyle.menu(color: Colors.black, isBold: true),
            ),
            subtitle: widget.value.runtimeType == List
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [...getWidget(widget.value)],
                  )
                : Text(
                    "${widget.value}".toUpperCase(),
                    style: AppTextStyle.title(isBold: true),
                  ),
          ),
        );
      },
    );
  }
}

List<Widget> getWidget(List<dynamic> val) {
  List<Widget> listWidget = [];
  for (var item in val) {
    item as String;
    listWidget.add(Text(item.toUpperCase(), style: AppTextStyle.title(isBold: true)));
  }

  return listWidget;
}
