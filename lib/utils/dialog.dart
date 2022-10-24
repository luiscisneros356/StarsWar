import 'package:flutter/material.dart';

import '../routes/routes.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Report send successful"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, RoutesApp.reportedList);
          },
          child: Text("Review my reports"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Text("Go back"),
        )
      ],
    );
  }
}
