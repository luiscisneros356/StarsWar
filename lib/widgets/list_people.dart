import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../provider/provider.dart';
import '../routes/routes.dart';
import 'card_people.dart';

class ListPeople extends StatefulWidget {
  const ListPeople({
    Key? key,
  }) : super(key: key);

  @override
  State<ListPeople> createState() => _ListPeopleState();
}

class _ListPeopleState extends State<ListPeople> {
  late PageController _controller;

  late Duration _duration;
  late Curve _curves;
  double d = 0.0;
  @override
  void initState() {
    _controller = PageController();

    _controller.addListener(() {
      d = _controller.page ?? 0.0;
      setState(() {});
    });
    _duration = const Duration(seconds: 1);
    _curves = Curves.easeInOut;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProviderData>(context, listen: false);
    final mq = MediaQuery.of(context).size;
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: mq.height / 2,
        width: mq.width,
        child: Stack(children: [
          PageView.builder(
              controller: _controller,
              itemCount: prov.listPeople.length,
              itemBuilder: ((context, i) {
                final people = prov.listPeople[i];
                final scale = 1 - (d - i);
                scale.clamp(0.0, 1.0);
                return GestureDetector(
                    onTap: (() {
                      Navigator.pushNamed(context, RoutesApp.details);
                      prov.setPeople(people);
                      prov.setIsBackFromDetail(true);
                    }),
                    child: Hero(
                        tag: people.name,
                        child: AnimatedScale(
                            duration: const Duration(milliseconds: 100),
                            scale: scale,
                            child: PeopleCard(people: people))));
              })),
          Botton(
              icon: Icons.arrow_back_ios,
              function: () => _controller.previousPage(duration: _duration, curve: _curves),
              alignment: Alignment.centerLeft),
          Botton(
              icon: Icons.arrow_forward_ios,
              function: () => _controller.nextPage(duration: _duration, curve: _curves),
              alignment: Alignment.centerRight),
        ]),
      ),
    );
  }
}

class Botton extends StatelessWidget {
  const Botton({Key? key, required this.icon, required this.function, required this.alignment})
      : super(key: key);
  final IconData icon;
  final VoidCallback function;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: IconButton(
        icon: Icon(
          icon,
          size: 50,
        ),
        onPressed: function,
      ),
    );
  }
}
