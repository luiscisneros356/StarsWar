import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../provider/provider.dart';
import '../routes/routes.dart';
import 'bottom.dart';
import 'card_people.dart';

class ListPeople extends StatefulWidget {
  const ListPeople({
    Key? key,
  }) : super(key: key);

  @override
  State<ListPeople> createState() => _ListPeopleState();
}

class _ListPeopleState extends State<ListPeople> with SingleTickerProviderStateMixin {
  late PageController _controller;
  late AnimationController _animationController;
  late Animation<double> _opacity;

  late Duration _duration;
  late Curve _curves;
  double _currentPage = 0.0;
  @override
  void initState() {
    _controller = PageController();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));

    _opacity = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _controller.addListener(() {
      _currentPage = _controller.page ?? 0.0;
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
          AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget? child) {
                return PageView.builder(
                    controller: _controller,
                    itemCount: prov.listPeople.length,
                    itemBuilder: ((context, i) {
                      final people = prov.listPeople[i];
                      final scale = 1 - (_currentPage - i);

                      scale.clamp(0.0, 1.0);

                      return GestureDetector(
                        onTap: (() {
                          Navigator.pushNamed(context, RoutesApp.details);
                          prov.setPeople(people);
                          prov.setIsBackFromDetail(true);
                        }),
                        child: Hero(
                            tag: people.name,
                            child: AnimatedOpacity(
                              opacity: _opacity.value == 0 ? 1 : _opacity.value,
                              duration: const Duration(milliseconds: 100),
                              child: AnimatedScale(
                                  duration: const Duration(milliseconds: 100),
                                  scale: scale,
                                  child: PeopleCard(people: people)),
                            )),
                      );
                    }));
              }),
          Botton(
              icon: Icons.arrow_back_ios,
              function: () {
                _animationController.forward(from: 0.0);
                _controller.previousPage(duration: _duration, curve: _curves);
              },
              alignment: Alignment.centerLeft),
          Botton(
              icon: Icons.arrow_forward_ios,
              function: () {
                _animationController.forward(from: 0.0);
                _controller.nextPage(duration: _duration, curve: _curves);
              },
              alignment: Alignment.centerRight),
        ]),
      ),
    );
  }
}
