import 'package:flutter/material.dart';

import '../utils/style.dart';

class NoConection extends StatelessWidget {
  const NoConection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cancel, color: Colors.red, size: 50),
          const SizedBox(height: 24),
          Text(
            "You have not\ninternet conection",
            style: AppTextStyle.title(color: Colors.black, isBold: true),
          ),
        ],
      ),
    );
  }
}
