import 'dart:math';

import 'package:flutter/material.dart';

import 'package:personajes_star_war/utils/style.dart';
import 'package:provider/provider.dart';

import '../models/people.dart';
import '../provider/provider.dart';
import '../routes/routes.dart';

class PeopleCard extends StatelessWidget {
  const PeopleCard({
    Key? key,
    required this.people,
  }) : super(key: key);

  final People people;

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProviderData>(context);
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(12),
      width: double.infinity,
      height: 260,
      decoration: BoxDecoration(
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          border: Border.all(
              width: 10, color: Colors.primaries[Random().nextInt(Colors.primaries.length)])),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(100)), child: people.imageGender),
              Positioned(
                  top: 10,
                  right: 5,
                  child: Container(
                      alignment: Alignment.center,
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: Text(
                        people.gender.toUpperCase(),
                        style: AppTextStyle.subTitle(),
                      ))),
            ],
          ),
          SizedBox(height: 12),
          Text(
            "Name:",
            style: AppTextStyle.menu(),
          ),
          Text(
            people.name.toUpperCase(),
            style: AppTextStyle.title(isBold: true),
          )
        ],
      ),
    );
  }
}
