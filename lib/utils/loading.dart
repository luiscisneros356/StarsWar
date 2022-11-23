import 'package:flutter/material.dart';
import 'package:personajes_star_war/utils/style.dart';

class Loading extends StatelessWidget {
  const Loading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            strokeWidth: 10,
          ),
        ),
        const SizedBox(height: 50),
        Text(
          "Loading people",
          style: AppTextStyle.title(color: Colors.black),
        )
      ],
    ));
  }
}
