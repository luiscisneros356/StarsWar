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
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        Provider.of<ProviderData>(context, listen: false).infiniteScroll();
        // print(Provider.of<ProviderData>(context, listen: false).listPeople.last.name);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProviderData>(context);

    return ListView.builder(
        controller: _scrollController,
        itemCount: prov.listPeople.length,
        itemBuilder: ((context, i) {
          final people = prov.listPeople[i];

          return GestureDetector(
              onTap: (() {
                Navigator.pushNamed(context, RoutesApp.details);
                prov.setPeople(people);
              }),
              child: Hero(tag: people.name, child: PeopleCard(people: people)));
        }));
  }
}
