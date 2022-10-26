import 'package:flutter/material.dart';

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
            Navigator.pushNamed(context, RoutesApp.reportedList);
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
