import 'package:NearMe/extensions/hexColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Container backgroundGradient() {
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [
          0.0,
          1.0
        ],
            colors: [
          HexColor.fromHex('#4aa09d').withOpacity(0.8),
          HexColor.fromHex('#602b83'),
        ])),
  );
}
