import 'package:flutter/material.dart';

import '../utils/style.dart';

class Fab extends StatelessWidget {
  const Fab(
      {required this.name,
      required this.onPressed,
      required this.tag,
      required this.icon,
      Key? key})
      : super(key: key);

  final String name;
  final void Function()? onPressed;
  final String tag;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FloatingActionButton(
            heroTag: tag, onPressed: onPressed, child: Icon(icon), backgroundColor: Colors.black),
        Text(
          name,
          style: AppTextStyle.title(color: Colors.black, isBold: true, size: 20),
        )
      ],
    );
  }
}
