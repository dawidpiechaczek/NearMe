import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget roundedButton(
    Color backgroundColor,
    String text,
    IconData? icon,
    double paddingTop,
    double paddingBottom,
    double elevation,
    Color borderColor,
    Function() onPress) {
  return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, bottom: 12),
      child: ElevatedButton(
        child: Padding(
          padding: EdgeInsets.only(top: paddingTop, bottom: paddingBottom),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (icon != null)
                Padding(
                    padding: EdgeInsets.only(right: 12), child: FaIcon(icon)),
              Text(
                text,
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
        onPressed: onPress,
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: borderColor))),
            elevation: MaterialStateProperty.all(elevation),
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            textStyle:
                MaterialStateProperty.all(TextStyle(color: Colors.white))),
      ));
}
