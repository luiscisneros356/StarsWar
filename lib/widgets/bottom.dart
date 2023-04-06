import 'package:flutter/material.dart';

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
