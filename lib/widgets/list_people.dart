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

  @override
  void initState() {
    _controller = PageController(viewportFraction: 0.7);

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
        child: PageView.builder(
            controller: _controller,
            itemCount: prov.listPeople.length,
            itemBuilder: ((context, i) {
              final people = prov.listPeople[i];

              return GestureDetector(
                  onTap: (() {
                    Navigator.pushNamed(context, RoutesApp.details);
                    prov.setPeople(people);
                    prov.setIsBackFromDetail(true);
                  }),
                  child: Hero(tag: people.name, child: PeopleCard(people: people)));
            })),
      ),
    );
  }
}
