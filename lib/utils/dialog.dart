import 'package:flutter/material.dart';
import 'package:personajes_star_war/screens/reported_list.dart';

import '../routes/routes.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Report send successful"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.push(context, RoutesApp.routeTransition(const ReportedList()));
          },
          child: const Text("Review my reports"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Text("Go back"),
        )
      ],
    );
  }
}

class NoConectionDialog extends StatelessWidget {
  const NoConectionDialog({
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("You have not internet conection"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text("Active conection"),
        )
      ],
    );
  }
}
