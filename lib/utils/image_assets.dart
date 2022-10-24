import 'package:flutter/cupertino.dart';

class ImageAsset extends StatelessWidget {
  const ImageAsset({Key? key, required this.asset, this.height = 175, this.width})
      : super(key: key);
  final String asset;
  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/$asset.jpg',
      fit: BoxFit.fill,
      height: height,
      width: width,
    );
  }
}
