import 'dart:math';

import 'package:flutter/material.dart';
import 'package:personajes_star_war/screens/details.dart';

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
  late Animation<double> _rotate;
  late Duration _duration;
  late Curve _curves;
  double _currentPage = 0.0;
  @override
  void initState() {
    _controller = PageController();
    _duration = const Duration(seconds: 2);
    _animationController = AnimationController(vsync: this, duration: _duration);
    _rotate = Tween(begin: 0.0, end: -2.0 * pi).animate(_animationController);
    _opacity = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _controller.addListener(() {
      _currentPage = _controller.page ?? 0.0;
      setState(() {});

//TODO: Pantalla de personajes: Su funcionamiento es muy confuso, se repiten
//personajes en la lista. El cambio de color a cada rato genera difícil el uso de
//la app.

// El primer punto era por que no implemente bien los botones de paginación, ya que se me ocurrió que
// al usar un Listview Builder y usar un controller que estuche la posición del scroll sumara a la lista de personajes los correspondientes
//a la siguiente página. Es ese punto, parte el siguiente de los colores, que era por que usaba Colors.primaries[index]. Cuando sumaba mas personajes al hacer scroll
//llamaba a setSate, lo que hacia que se construya el método Build de nuevo y se vuelva a asignar un nuevo color a la tarjeta, ya que no es una constante.
    });

    _curves = Curves.easeInOut;

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    _animationController.removeListener(() {});
    super.dispose();
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
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: prov.listPeople.length,
                    itemBuilder: ((context, i) {
                      final people = prov.listPeople[i];
                      final scale = 1 - (_currentPage - i);

                      scale.clamp(0.0, 1.0);

                      return GestureDetector(
                        onTap: (() {
                          Navigator.push(context, RoutesApp.routeTransition(const DetailsScreen()));
                          prov.setPeople(people);
                          prov.setIsBackFromDetail(true);
                        }),
                        child: Hero(
                            tag: people.name,
                            child: Transform.rotate(
                              angle: _rotate.value,
                              child: AnimatedOpacity(
                                opacity: _opacity.value == 0 ? 1 : _opacity.value,
                                duration: const Duration(milliseconds: 100),
                                child: AnimatedScale(
                                    duration: const Duration(milliseconds: 100),
                                    scale: scale,
                                    child: PeopleCard(people: people)),
                              ),
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
