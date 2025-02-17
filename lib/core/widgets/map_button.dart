import 'package:flutter/material.dart';

class MapButton extends StatelessWidget {
  final int row;
  final int col;
  final String iconPath;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const MapButton({
    Key? key,
    required this.row,
    required this.col,
    required this.iconPath,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Image.asset(
        iconPath,
        height: 40,
        width: 40,
        fit: BoxFit.contain,
      ),
    );
  }
}