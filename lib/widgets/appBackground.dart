import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Container backgroundGradient() {
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
          0.0,
          1.0
        ],
            colors: [
          Colors.blue.withOpacity(0.8),
          Colors.purple,
        ])),
  );
}
