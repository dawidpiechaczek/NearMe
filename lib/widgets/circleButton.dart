import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CircleButton extends StatelessWidget {
  CircleButton(
      {Key? key,
      required this.onTap,
      required this.icon,
      required this.backgroundColor,
      required this.size})
      : super(key: key);

  final GestureTapCallback onTap;
  final Icon icon;
  final Color backgroundColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: icon,
      ),
    );
  }
}
