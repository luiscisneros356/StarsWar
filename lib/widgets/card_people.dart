import 'package:flutter/material.dart';

import 'package:personajes_star_war/utils/style.dart';

import '../models/people.dart';

class PeopleCard extends StatelessWidget {
  const PeopleCard({
    Key? key,
    required this.people,
  }) : super(key: key);

  final People people;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(12),
      width: double.infinity,
      height: 260,
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          border: Border.all(width: 10, color: Colors.green)),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: people.imageGender(people.gender)),
              Positioned(
                  top: 10,
                  right: 5,
                  child: Container(
                      alignment: Alignment.center,
                      height: 45,
                      width: 45,
                      decoration: const BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: Text(
                        people.gender != null ? people.gender!.toUpperCase() : "",
                        style: AppTextStyle.subTitle(color: Colors.black),
                      ))),
            ],
          ),
          const SizedBox(height: 12),
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
